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

## Sponsoring the Project

If you (or your company) are benefiting from the project and would like to support the contributor, kindly support the project.

<a href="https://www.buymeacoffee.com/bersler" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 40px !important;width: 160px !important;" ></a>
