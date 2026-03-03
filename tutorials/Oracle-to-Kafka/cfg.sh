#!/bin/bash
# Copyright (C) 2018-2026 Adam Leszczynski (aleszczynski@bersler.com)
#
# This file is part of OpenLogReplicator-tutorials
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License along with this program; see the file LICENSE;
# If not, see <http://www.gnu.org/licenses/>.

export DB_IMAGE=${DB_IMAGE:=oracle/database:21.3.0-xe}
export DB_CONTAINER=${DB_CONTAINER:=ORA1}
export KAFKA_VERSION=3.4.0.Final
export KAFKA_IMAGE=${KAFKA_IMAGE:=quay.io/debezium/kafka:${KAFKA_VERSION}}
export KAFKA_CLUSTER=${KAFKA_CLUSTER:=KAFKA1}
export KAFKA_CONTAINER=${KAFKA_CONTAINER:=KAFKA1}
# the broker address is also hardcoded in the OLR configuration file
export KAFKA_BROKER=${KAFKA_BROKER:=kafka:9092}
# the topic name is also hardcoded in the OLR configuration file
export KAFKA_TOPIC=${KAFKA_TOPIC:=topic_txns}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:tutorial}
export OLR_CONTAINER=${OLR_CONTAINER:=OLR1}
export OLR_CUSTOM=${OLR_CUSTOM:=}
export DUMP_LOGS=${DUMP_LOGS:=0}
