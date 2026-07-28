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
set -e

. cfg.sh
. ../common/functions.sh

echo "6a. running test - verify data in Kafka topic"
db_sql "${DB_CONTAINER}" /opt/sql/test.sql /opt/sql/test.out
kafka_wait_for_messages "${KAFKA_CONTAINER}" "${KAFKA_BROKER}" "${KAFKA_TOPIC_OLR}" "COUNT" 3

echo "6. running test - restart Debezium"
docker stop ${DEBEZIUM_CONTAINER}
docker start ${DEBEZIUM_CONTAINER}
debezium_wait_for_connect "${DEBEZIUM_CONTAINER}" "oracle-olr-connector"
db_sql "${DB_CONTAINER}" /opt/sql/test.sql /opt/sql/test.out
kafka_wait_for_messages "${KAFKA_CONTAINER}" "${KAFKA_BROKER}" "${KAFKA_TOPIC_OLR}" "COUNT" 6

echo "6. running test - restart database"
docker stop ${DB_CONTAINER}
docker start ${DB_CONTAINER}
db_wait "${DB_CONTAINER}"
sleep 30
db_sql "${DB_CONTAINER}" /opt/sql/test.sql /opt/sql/test.out
kafka_wait_for_messages "${KAFKA_CONTAINER}" "${KAFKA_BROKER}" "${KAFKA_TOPIC_OLR}" "COUNT" 9

#echo "6. running test  - restart OLR"
#docker stop ${OLR_CONTAINER}
#docker start ${OLR_CONTAINER}
#sleep 10
#db_sql "${DB_CONTAINER}" /opt/sql/test.sql /opt/sql/test.out
#kafka_wait_for_messages "${KAFKA_CONTAINER}" "${KAFKA_BROKER}" "${KAFKA_TOPIC_OLR}" "COUNT" 12

finish
