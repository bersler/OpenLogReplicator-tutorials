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

export DB_IMAGE=${DB_IMAGE:=oracle/database:21.3.0-xe}
export DB_CONTAINER=${DB_CONTAINER:=ORA1}
export KAFKA_VERSION=3.4.0.Final
export KAFKA_IMAGE=${KAFKA_IMAGE:=quay.io/debezium/kafka:${KAFKA_VERSION}}
export KAFKA_CLUSTER=${KAFKA_CLUSTER:=KAFKA1}
export KAFKA_CONTAINER=${KAFKA_CONTAINER:=KAFKA1}
export KAFKA_BROKER=${KAFKA_BROKER:=kafka:9092}
export KAFKA_TOPIC_OLR=${KAFKA_TOPIC_OLR:=oracle_olr.USRTBL.ADAM1}
export KAFKA_TOPIC_CONFIGS=${KAFKA_TOPIC_CONFIGS:=topic_configs}
export KAFKA_TOPIC_OFFSETS=${KAFKA_TOPIC_OFFSETS:=topic_offsets}
export KAFKA_TOPIC_STATUSSES=${KAFKA_TOPIC_STATUSSES:=topic_statuses}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:tutorial}
export OLR_CONTAINER=${OLR_CONTAINER:=OLR1}
export OLR_CUSTOM=${OLR_CUSTOM:=}
export DEBEZIUM_VERSION=3.4.0.Final
export DEBEZIUM_IMAGE=${DEBEZIUM_IMAGE:=quay.io/debezium/connect:${DEBEZIUM_VERSION}}
export DEBEZIUM_CONTAINER=${DEBEZIUM_CONTAINER:=DEBEZIUM1}
export JDBC_FILE=ojdbc8.jar
export JDBC_URL=https://download.oracle.com/otn-pub/otn_software/jdbc/2326/ojdbc8.jar
export INSTANT_CLIENT_FILE=instantclient-basic-linux.x64-23.26.0.0.0.zip
export INSTANT_CLIENT_URL=https://download.oracle.com/otn_software/linux/instantclient/2326000/instantclient-basic-linux.x64-23.26.0.0.0.zip
export INSTANT_CLIENT_DIR=instantclient_23_26
export DUMP_LOGS=${DUMP_LOGS:=0}
