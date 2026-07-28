# Replicating Oracle transactions to Kafka with Debezium

Goal: reference replication with Debezium by capturing transactional changes from a database and delivering them to a Kafka topic, covering environment setup, enabling replication, executing a test change that produces the output, and cleanup.
Uses OpenLogReplicator as the capture method.

## Create Docker images

The following images are required for this tutorial:
- `oracle/database:21.3.0-xe` - Oracle Database 21.3 XE
- `quay.io/debezium/kafka` - Kafka 
- `quay.io/debezium/connect` - Debezium connector

Refer to [Docker images](../../images/README.md) for image creation scripts.

## Container names

The default container names are:
- `ORA1` - Oracle Database 21.3 XE
- `KAFKA1` - Kafka broker
- `DEBEZIUM1` - Debezium connector

For ease of use, a Zookeeper container is not created separately, since a newer Kafka version is used which relies on KRaft.
Container names are defined in the `cfg.sh` script.

## Folders used by this tutorial

All files for the database devices and redo log files are placed outside the containers.
The folders are created in steps 2-3-4 and cleaned up in steps 6-7-8.
The folders created by `*start.sh` scripts are removed by `*drop.sh` scripts.

## Run test

### 1. Check if images are correct.

Run:

----
    ./1.check.sh
----

### 2. Create the database and run all schema scripts.

This step represents the state that is usually present in the enterprise.
The database is created, and some applications are installed.

Run:

----
    ./2.db-start.sh
----

### 3. Create Kafka container and topic.

During this step, the Kafka container is created and started.
Also, the topic for OpenLogReplicator is created.

Run:

----
    ./3.kafka-start.sh
----

### 4. Create and start Debezium using OpenLogReplicator.

This step represents the state when replication is added to the database.

Run:

----
    ./4.debezium-start.sh
----

After this step, the container with Debezium using OpenLogReplicator should be up and running.
Transactions are being read from the database and sent to Kafka.
Replication is active.

### 5. Run SQL and check results

This step represents a business event when the database is changed and changes are captured by OpenLogReplicator and published by Debezium connector.

Run:

----
    ./5.test.sh
----

The expected result is that the Kafka topic contains messages with the JSON representation of the transaction executed by the `sql/test.sql` script.

### 6. Drop Debezium

All tests are finished.
Replication can be removed.

Run:

----
    ./6.debezium-drop.sh
----

### 7. Drop Kafka

Run:

----
    ./7.kafka-drop.sh
----

After this step, you may go back to step 3 and repeat the process.

### 8. Drop the database

Run:

----
    ./8.db-drop.sh
----
