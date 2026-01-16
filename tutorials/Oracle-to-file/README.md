# Replicating Oracle transactions to Kafka with OpenLogReplicator

Goal: demonstrate capturing transactional changes from a database and writing them to a file, covering setup, a test change that produces the output, and cleanup.

## Create Docker images

The following images are required for this tutorial:
- `oracle/database:21.3.0-xe` - Oracle Database 21.3 XE
- `bersler/openlogreplicator:tutorial` - OpenLogReplicator

Refer to [Docker images](../../images/README.md) for image creation scripts.

## Container names

The default container names are:
- `ORA1` - Oracle Database 21.3 XE
- `OLR1` - OpenLogReplicator
- `KAFKA1` - Kafka broker
- `DEB

Container names are defined in the `cfg.sh` script.

## Folders used by this tutorial

All files for the database devices and redo log files are placed outside the containers.
The folders are created in steps 2-3 and cleaned up in steps 5-6.
The folders created by `*start.sh` scripts are removed by `*drop.sh` scripts.

## Run test

### 1. Check if images are correct.

Run:

----
    ./1.check.sh
----

### 2. Create the database and run all schema scripts.

This step represents the state that is usually present in the enterprise.
The database is created and some applications are installed.

Run:

----
    ./2.db-start.sh
----

### 3. Create and start OpenLogReplicator in offline mode.

This step represents the state when replication is added to the database.

Run:

----
    ./3.olr-start.sh
----

After this step, the container with OpenLogReplicator should be up and running and replication should be active.

### 4. Run SQL and check results

This step represents a business event when the database is changed and changes are captured by OpenLogReplicator.

Run:

----
    ./4.test.sh
----

The expected result is that the output directory contains `results.txt` with the JSON representation of the transaction executed by `sql/test.sql`.

### 5. Drop OpenLogReplicator

All tests are finished and replication can be removed.

Run:

----
    ./5.olr-drop.sh
----

After this step you may return to step 3 and repeat the process.

### 6. Drop the database

Run:

----
    ./6.db-drop.sh
----
