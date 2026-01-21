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

echo "3. creating and starting Kafka container"

echo "- creating directories"
mkdir kafka
chmod 777 kafka

echo "- starting Kafka"
docker compose --profile kafka up --detach --wait

echo "- create Kafka topic ${KAFKA_TOPIC}"
kafka_create_topic "${KAFKA_CONTAINER}" "${KAFKA_BROKER}" "${KAFKA_TOPIC}"

echo "- listing Kafka topics"
kafka_list_topics "${KAFKA_CONTAINER}" "${KAFKA_BROKER}"

echo "- all OK"
