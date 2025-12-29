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

2. Setup folders for database tablespaces and scripts.

Run:

    ./2.setup.sh

3. Create the database and run all schema scripts.

This step represents the state that is usually present in the enterprise.
The database is created, some applications are installed.
Run:

    ./3.db.sh

4. Create and start OpenLogReplicator in online mode

This step represents the state when replication is added to the database.
Run:

    ./4.olr.sh

After this step, the container with OpenLogReplicator should be up and running. 
Replication is active.

5. Run SQL and check results

This step represents a business event when the database is changed and changes are captured by OpenLogReplicator.
Run:

    ./5.test.sh

The expected result would be that the output dir has `results.txt` file with the JSON representation of the transaction run from the `sql/test.sql` script

6. Cleanup

Run:

    ./6.cleanup.sh
