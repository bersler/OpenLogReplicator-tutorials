This tutorial shows how to run OpenLogReplicator on Docker reading from Oracle Database 21.3 XE running on Docker.

Pre-requisites:

1. Create Docker images:
- oracle/database:21.3.0-xe
- bersler/openlogreplicator:tutorial

Refer to Docker-images folder to creation scripts.

2. Docker containers names. 

Configure names in cfg.sh


Run: 

1. Check if images are correct:

./1.check.sh

2. Setup folders for database tablespaces and scripts

./2.setup.sh

3. Create containers

./3.create.sh

4. Run SQL and check results

./4.test.sh

Expected result would be that the output dir has resuts.txt file with the JSON representation of the transaction run from the sql/test.sql script

5. Cleanup

./5.cleanup.sh


