# OpenLogReplicator-tutorials

This repository contains tutorials for [OpenLogReplicator](https://github.com/bersler/OpenLogReplicator).

## Requirements

All tutorials are based on Docker containers and created and tested using a Linux operating system using Debian distribution. 

Due to differences in Docker installation on different operating systems, the scripts require sudo privileges for creating folders and changing file and folder attributes.

The following folder naming is used:
- `oradata` - Oracle database files
- `fra` - Oracle database files
- `sql` - SQL scripts used for tests
- `checkpoint` - OpenLogReplicator checkpoint files
- `log` - OpenLogReplicator log files
- `scripts` - OpenLogReplicator configuration scripts
- `setup` - SQL scripts used to setup the database

## [Containers](images/README.md) 

The following containers are available:
1. Oracle Database 21.3 XE (`oracle/database:21.3.0-xe`)
2. OpenLogReplicator (`bersler/openlogreplicator:tutorial`)

Not all containers are required for all tutorials. 
Refer to particular tutorial for the list of required containers.

## Tutorials

### 1. [Docker compose: Oracle to file](tutorials/Oracle-to-file/README.md)

Read from an Oracle 21.3 XE database and write changes to a file.

## Support OpenLogReplicator-tutorials

If you feel that I should receive some feedback from the world to continue with my hard work - feel free to make a **donation** or become a **sponsor**.

I am very grateful for any amount you donate.

[![Sponsor via GitHub](https://img.shields.io/badge/Sponsor-GitHub-brightgreen)](https://github.com/sponsors/bersler)
[![Librepay](https://img.shields.io/badge/Donate-Librepay-orange)](https://liberapay.com/bersler)
[![Buy Me a Coffee](https://img.shields.io/badge/Donate-Coffee-yellow)](https://www.buymeacoffee.com/bersler)
