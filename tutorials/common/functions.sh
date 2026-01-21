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

sql() {
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
    timeout 1800s grep -q 'DATABASE IS READY TO USE' <(docker logs -f "${1}")
}

docker_rm() {
    docker rm -f "$@" 1>/dev/null 2>&1 || true
}

docker_down() {
    docker compose down 1>/dev/null 2>&1 || true
}

docker_up() {
    docker compose "$@" up --detach
}

file_rm() {
    sudo rm -rf "$@" 1>/dev/null 2>&1 || true
}

kafka_create_topic() {
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --create \
      --topic "${3}" \
      --partitions 1 \
      --replication-factor 1
}

kafka_create_topic_compact() {
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --create \
      --topic "${3}" \
      --partitions 1 \
      --replication-factor 1 \
      --config cleanup.policy=compact
}

kafka_list_topics() {
    docker exec "${1}" /kafka/bin/kafka-topics.sh \
      --bootstrap-server "${2}" \
      --list
}
