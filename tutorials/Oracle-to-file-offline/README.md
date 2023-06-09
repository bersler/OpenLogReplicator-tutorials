# Read from Oracle 21.3 XE and write changes to a file.

## Create Docker images:

The following images are required for this tutorial:
- Oracle Database 21.3 XE (`oracle/database:21.3.0-xe`)
- OpenLogReplicator (`bersler/openlogreplicator:tutorial`)

Refer to [Docker images](../images/README.md) for image creation scripts.

## Containers names. 

The default container names are:
- `ORA1` - Oracle Database 21.3 XE
- `OLR1` - OpenLogReplicator

Container names are defined `cfg.sh` script.

## Folders used by this tutorial

All files for the database devices and redo log files are placed outside the containers. 
Refer to 
The folders are created in step 2 and cleaned up in step 5.

## Run test

1. Check if images are correct:

Run:

    ./1.check.sh

2. Setup folders for database tablespaces and scripts

Run:

    ./2.setup.sh

3. Create containers

Run:

    ./3.create.sh

After this step, the container with OpenLogReplicator should be in stopped state. This is intentional.  

4. Start offline replicator 

    ./4.start.sh

After this step, the container with OpenLogReplicator should be running.

5Run SQL and check results

Run:

    ./5.test.sh

The expected result would be that the output dir has resuts.txt file with the JSON representation of the transaction run from the sql/test.sql script

5. Cleanup

Run:

    ./6.cleanup.sh
