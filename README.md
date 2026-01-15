# OpenLogReplicator-tutorials

This repository contains tutorials for [OpenLogReplicator](https://github.com/bersler/OpenLogReplicator).

## Requirements

All tutorials are based on Docker containers and created and tested on a Debian-based Linux distribution.

Due to differences in Docker installation on different operating systems, the scripts require sudo privileges for creating folders and changing file and folder attributes.

The following folder names are used:
- `oradata` - Oracle database files
- `fra` - Oracle database files
- `sql` - SQL scripts used for tests
- `checkpoint` - OpenLogReplicator checkpoint files
- `log` - OpenLogReplicator log files
- `scripts` - OpenLogReplicator configuration scripts
- `setup` - SQL scripts used to setup the database
- `kafka` - Kafka data files

## Containers

The following custom [Docker images](images/README.md) are required to run tutorials:

- `oracle/database:21.3.0-xe` - Oracle Database 21.3 XE
- `bersler/openlogreplicator:tutorial` - OpenLogReplicator

Before running the tutorials, create the necessary Docker images.
Not all images are required for all tutorials.
Refer to the particular tutorial for the list of required images.

## Tutorials

### 1. [Oracle-to-file](tutorials/Oracle-to-file/README.md)

Goal: demonstrate capturing transactional changes from a database and writing them to a file, covering setup, a test change that produces the output, and cleanup.

### 2. [Oracle-to-file-offline](tutorials/Oracle-to-file-offline/README.md)

Goal: demonstrate capturing transactional changes from a database and writing them to a file without a direct database connection, covering setup, a test change that produces the output, and cleanup.

### 3. [Oracle-to-Kafka](tutorials/Oracle-to-Kafka/README.md)

Goal: demonstrate capturing transactional changes from a database and writing them to a Kafka topic, covering setup, a test change that produces the output, and cleanup.

## Support OpenLogReplicator-tutorials

If you feel that I should receive some feedback from the world to continue with my hard work - feel free to make a `donation` or become a `sponsor`.

I am very grateful for any amount you donate.

[![Sponsor via GitHub](https://img.shields.io/badge/Sponsor-GitHub-brightgreen)](https://github.com/sponsors/bersler)
[![Librepay](https://img.shields.io/badge/Donate-Librepay-orange)](https://liberapay.com/bersler)
[![Buy Me a Coffee](https://img.shields.io/badge/Donate-Coffee-yellow)](https://www.buymeacoffee.com/bersler)
