#!/bin/bash
# Copyright (C) 2018-2026 Adam Leszczynski (aleszczynski@bersler.com)
#
# This file is part of OpenLogReplicator-tutorials
#
# Open Log Replicator is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# Open Log Replicator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Open Log Replicator; see the file LICENSE.txt  If not see
# <http://www.gnu.org/licenses/>.

db_sql() {
    echo "- running SQL script ${2}"
    docker exec "${1}" /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus / as sysdba <<EOF
set echo off
set verify off
set heading off
set termout off
set showmode off
set linesize 5000
set pagesize 0
ALTER SESSION SET CONTAINER = XEPDB1;
spool ${3}
@${2}
spool off
EOF
chmod a+r ${3}
" 1>/dev/null 2>&1 || true
}

db_wait() {
    echo "- waiting for db to start"
    timeout 600s grep -q 'DATABASE IS READY TO USE' <(docker logs -f "${1}")
}

db_client() {
    echo "- downloading JDBC driver"
    wget -q -O oracle_libs/${JDBC_FILE} "${JDBC_URL}"

    echo "- downloading Instant Client"
    wget -q -O "${INSTANT_CLIENT_FILE}" "${INSTANT_CLIENT_URL}"

    echo "- extracting Instant Client"
    unzip -q "${INSTANT_CLIENT_FILE}" 2>&1 >/dev/null
    rm -rf "${INSTANT_CLIENT_FILE}" META-INF 2>&1 >/dev/null || true
    chmod 755 "${INSTANT_CLIENT_DIR}"
}

db_files() {
    echo "- creating directories"
    mkdir oradata
    chmod 755 oradata
    sudo chown 54321:54321 oradata

    mkdir fra
    chmod 755 fra
    sudo chown 54321:54321 fra

    chmod a+x+r+w sql
    chmod a+r sql/*.sql

    chmod 777 setup
    chmod 644 setup/config.sql

    if [ "${1}" == "oracle_libs" ]; then
        mkdir oracle_libs
        chmod 755 oracle_libs
    fi
}

docker_check() {
    echo "- checking docker image: ${1}"
    if [[ "$(docker images -q ${1} 2> /dev/null)" == "" ]]; then
        echo "Docker image ${1} not found. Please build it first."
        exit 1
    fi
}

docker_rm() {
    echo "- dropping container: $@"
    docker rm -f "$@" 1>/dev/null 2>&1 || true
}

docker_down() {
    echo "- dropping all containers"
    docker compose down 1>/dev/null 2>&1 || true
}

docker_up() {
    echo "- starting database and $@"
    docker compose "$@" up --detach
}

docker_up_wait() {
    echo "- starting database and $@"
    docker compose "$@" up --detach --wait
}

file_rm() {
    echo "- cleaning up files"
    sudo rm -rf "$@" 1>/dev/null 2>&1 || true
}

olr_files() {
    echo "- creating directories"
    mkdir checkpoint
    chmod 777 checkpoint

    mkdir log
    chmod 777 log

    chmod 777 scripts
    chmod 644 scripts/OpenLogReplicator.json

    if [ "${1}" == "output" ]; then
        mkdir output
        chmod 777 output
    fi
}

olr_wait_for_start() {
    echo "- waiting for OpenLogReplicator to start ${2}"
    for ((i=1; i<=60; i++)); do
        if docker exec "${1}" curl -s http://localhost:8080/metrics | grep -q "service_state{state=\"${2}\"} 1"; then
            return 0
        fi
        sleep 1
    done

    echo "- timeout waiting for OpenLogReplicator to start ${2}"
    exit 1
}

olr_config_offline() {
    echo "- creating OpenLogReplicator configuration"
    curl https://raw.githubusercontent.com/bersler/OpenLogReplicator/refs/tags/v${OLR_VERSION}/scripts/gencfg.sql -o sql/gencfg.sql
    cat sql/gencfg.sql | sed "s/'DB'/'ORA1'/g" | sed "s/'USR1', 'USR2'/'USRTBL'/g" > sql/gencfg-ORA1.sql
    db_sql "${1}" /opt/sql/gencfg-ORA1.sql /opt/sql/gencfg-ORA1.out

    SCN=`cat sql/gencfg-ORA1.out | egrep "^SCN:" | sed "s/SCN: //g"`
    RESETLOGS=`cat sql/gencfg-ORA1.out | egrep "^{\"incarnation" | grep "\"status\":\"CURRENT\"" | sed "s/^.*\"resetlogs\"://g" | sed "s/\,.*$//g"`
    ACTIVATION=`cat sql/gencfg-ORA1.out | egrep "^{\"database" | sed "s/^.*activation\"://g" | sed "s/\,.*$//g"`
    if [[ -z "${SCN}" ]] || [[ -z "${RESETLOGS}" ]] || [[ -z "${ACTIVATION}" ]]; then
        echo "- error obtaining parameters from gencfg output"
        exit 1
    fi
    cat sql/gencfg-ORA1.out \
        | grep -v "PL/SQL procedure successfully completed." \
        | egrep -v "^SQL\>" \
        | egrep -v "SCN: " \
        | egrep -v "^CONTENT OF: " \
        | egrep -v "^$" \
        > checkpoint/ORA1-chkpt-${SCN}.json

    cat <<EOF >checkpoint/ORA1-chkpt.json
    {"database":"ORA1","scn":${SCN},"resetlogs":${RESETLOGS},"activation":${ACTIVATION}}
EOF
}

olr_wait_for_results() {
    echo "- waiting for OpenLogReplicator to produce results"
    for i in {1..60}; do
        if [ -f output/results.txt ]; then
            LEN=$(cat output/results.txt | wc -l)
            if [ "${LEN}" == "${1}" ] ; then
                return 0
            fi
        fi
        sleep 1
    done

    echo "- timeout waiting for results"
    exit 1
}

kafka_files() {
    echo "- creating directories"
    mkdir kafka
    chmod 777 kafka
}

kafka_wait_for_messages() {
    echo "- waiting for Kafka ${3} messages"
    for i in {1..60}; do
        set +e
        MSGS=$(docker exec "${1}" /kafka/bin/kafka-console-consumer.sh \
            --bootstrap-server "${2}" \
            --topic "${3}" \
            --from-beginning \
            --timeout-ms 1000 \
            --property print.key=true \
            --property print.timestamp=true \
            --property key.separator=" | " | grep "CreateTime")
        set -e
        if [ ! -z "${MSGS}" ]; then
            LEN=$(echo "${MSGS}" | wc -l)
            if [ "${LEN}" == "${4}" ] ; then
                echo "${MSGS}"
                return 0
            fi
        fi
        sleep 1
    done

    echo "- timeout waiting for messages"
    exit 1
}

kafka_create_topic() {
    echo "- creating Kafka topic ${1}"
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --create \
      --topic "${3}" \
      --partitions 1 \
      --replication-factor 1
}

kafka_create_topic_compact() {
    echo "- creating Kafka topic ${1}"
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --create \
      --topic "${3}" \
      --partitions 1 \
      --replication-factor 1 \
      --config cleanup.policy=compact
}

kafka_list_topics() {
    echo "- listing Kafka topic"
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --list
}

debezium_logminer() {
    echo "- creating Debezium Oracle LogMiner connector ${1}"
    docker exec "${1}" curl --no-progress-meter -X POST -H "Accept:application/json" -H "Content-Type:application/json" \
      localhost:8083/connectors/ -d "{
      \"name\": \"oracle-logminer-connector\",
      \"config\": {
        \"connector.class\": \"io.debezium.connector.oracle.OracleConnector\",
        \"database.hostname\": \"oracle\",
        \"database.port\": \"1521\",
        \"database.user\": \"c##usrdbz_logminer\",
        \"database.password\": \"dbzpwd\",
        \"database.dbname\": \"XEPDB1\",
        \"database.pdb.name\": \"XEPDB1\",
        \"database.connection.adapter\": \"logminer\",
        \"topic.prefix\": \"oracle_server\",
        \"schema.history.internal.kafka.bootstrap.servers\": \"${2}\",
        \"schema.history.internal.kafka.topic\": \"schema-changes.oracle\",
        \"table.include.list\": \"USRTBL.ADAM1\",
        \"database.history.store.only.captured.tables.ddl\": \"true\"
      }
    }"
}

debezium_olr() {
    echo "- creating Debezium Oracle OLR connector ${1}"
    docker exec "${1}" curl --no-progress-meter -X POST -H "Accept:application/json" -H "Content-Type:application/json" \
      localhost:8083/connectors/ -d "{
      \"name\": \"oracle-olr-connector\",
      \"config\": {
        \"connector.class\": \"io.debezium.connector.oracle.OracleConnector\",
        \"database.hostname\": \"oracle\",
        \"database.port\": \"1521\",
        \"database.user\": \"c##usrdbz_olr\",
        \"database.password\": \"dbzpwd\",
        \"database.dbname\": \"XEPDB1\",
        \"database.pdb.name\": \"XEPDB1\",
        \"database.connection.adapter\": \"olr\",
        \"openlogreplicator.host\": \"openlogreplicator\",
        \"openlogreplicator.port\": \"5000\",
        \"openlogreplicator.source\": \"ORA1\",
        \"topic.prefix\": \"oracle_server\",
        \"schema.history.internal.kafka.bootstrap.servers\": \"${2}\",
        \"schema.history.internal.kafka.topic\": \"schema-changes.oracle\",
        \"table.include.list\": \"USRTBL.ADAM1\",
        \"database.history.store.only.captured.tables.ddl\": \"true\"
      }
    }"
}

debezium_wait_for_connect() {
    echo "- waiting for Debezium connector ${2} to start"
    for ((i=1; i<=60; i++)); do
        if docker exec "${1}" curl -s http://localhost:8083/connectors/"${2}"/status | grep -q '"state":"RUNNING"'; then
            sleep 10
            return 0
        fi
        sleep 1
    done

    echo "- timeout waiting for Debezium connector to start"
    exit 1
}

finish() {
    echo "- all OK"
}
