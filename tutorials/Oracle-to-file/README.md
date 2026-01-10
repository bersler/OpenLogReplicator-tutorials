# Read from Oracle 21.3 XE and write changes to a file.

## Create Docker images:

The following images are required for this tutorial:
- Oracle Database 21.3 XE (`oracle/database:21.3.0-xe`)
- OpenLogReplicator (`bersler/openlogreplicator:tutorial`)

Refer to [Docker images](../../images/README.md) for image creation scripts.

## Containers names. 

The default container names are:
- `ORA1` - Oracle Database 21.3 XE
- `OLR1` - OpenLogReplicator

Container names are defined `cfg.sh` script.

## Folders used by this tutorial

All files for the database devices and redo log files are placed outside the containers.
The folders are created in step 2 and cleaned up in step 6.

## Run test

1. Check if images are correct.

Run:

    ./1.check.sh
2. Create the database and run all schema scripts.

This step represents the state that is usually present in the enterprise.
The database is created, some applications are installed.
Run:

    ./2.db-start.sh

3. Create and start OpenLogReplicator in offline mode.

This step represents the state when replication is added to the database.
Run:

    ./3.olr-start.sh

After this step, the container with OpenLogReplicator should be up and running. 
Replication is active.

4. Run SQL and check results

This step represents a business event when the database is changed and changes are captured by OpenLogReplicator.
Run:

    ./4.test.sh

The expected result would be that the output dir has `results.txt` file with the JSON representation of the transaction run from the `sql/test.sql` script

5. Drop OpenLogReplicator

All tests are finished.
Replication can be removed.
Run:

   ./5.olr-drop.sh

After this step, you may repeat steps 3 and 4 to see that OpenLogReplicator can be started and stopped multiple times.

6. Drop the database

Run:

    ./6.db-drop.sh
