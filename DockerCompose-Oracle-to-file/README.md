# Read from Oracle 21.3 XE and write changes to a file.

## Create Docker images:

The following images are required for this tutorial:
* oracle/database:21.3.0-xe
* bersler/openlogreplicator:tutorial

Refer to [Docker images](../Docker-images) for image creation scripts.

## Set containers names. 

Configure names in cfg.sh

## Run test

1. Check if images are correct:

    ./1.check.sh

2. Setup folders for database tablespaces and scripts

    ./2.setup.sh

3. Create containers

    ./3.create.sh

4. Run SQL and check results

    ./4.test.sh

The expected result would be that the output dir has resuts.txt file with the JSON representation of the transaction run from the sql/test.sql script

5. Cleanup

    ./5.cleanup.sh
