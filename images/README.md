# Docker images

This folder contains scripts to create Docker images used in this project.

## Oracle Database 21.3 XE

Image name is: `oracle/database:21.3.0-xe`

Run:

    ./oracle_database_21.3.0-xe.sh

## OpenLogReplicator

Image name is: `bersler/openlogreplicator:tutorial`

The name `tutorial` is used here to distinguish from other OpenLogReplicator images which might be used on the same host for other purposes.

Run to use prod image (faster, for production):

    ./bersler_openlogreplicator_tutorial_prod.sh

Run to use dev image (10x slower, but contains many sanitizing checks):

    ./bersler_openlogreplicator_tutorial_dev.sh
