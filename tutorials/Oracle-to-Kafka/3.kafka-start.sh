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

echo "3. creating and starting Kafka container"

echo "- creating directories"
mkdir kafka
chmod 777 kafka

echo "- starting Kafka"
docker compose --profile kafka up --detach --wait

echo "- create Kafka topic ${KAFKA_TOPIC}"
docker exec ${KAFKA_CONTAINER} /kafka/bin/kafka-topics.sh \
  --bootstrap-server ${KAFKA_BROKER} \
  --create \
  --topic ${KAFKA_TOPIC} \
  --partitions 1 \
  --replication-factor 1

echo "- listing Kafka topics"
docker exec ${KAFKA_CONTAINER} /kafka/bin/kafka-topics.sh \
  --bootstrap-server ${KAFKA_BROKER} \
  --list

echo "- all OK"
