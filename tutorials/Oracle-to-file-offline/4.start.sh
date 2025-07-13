#!/bin/bash
# Copyright (C) 2018-2025 Adam Leszczynski (aleszczynski@bersler.com)
#
# This file is part of OpenLogReplicator-tutorials
#
# Open Log Replicator is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# Open Log Replicator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Open Log Replicator; see the file LICENSE.txt  If not see
# <http://www.gnu.org/licenses/>.
set -e

. cfg.sh
OLR_VERSION=${OLR_VERSION:=1.8.5}

echo "4. creating and starting olr container"

echo "- creating database schema"
sql /opt/sql/schema.sql /opt/sql/schema.out

echo "- creating OpenLogReplicator configuration"
curl https://raw.githubusercontent.com/bersler/OpenLogReplicator/refs/tags/v${OLR_VERSION}/scripts/gencfg.sql -o sql/gencfg.sql
cat sql/gencfg.sql | sed "s/'DB'/'ORA1'/g" | sed "s/'USR1', 'USR2'/'USR2'/g" > sql/gencfg-ORA1.sql
sql /opt/sql/gencfg-ORA1.sql /opt/sql/gencfg-ORA1.out

SCN=`cat sql/gencfg-ORA1.out | egrep "^SCN:" | sed "s/SCN: //g"`
RESETLOGS=`cat sql/gencfg-ORA1.out | egrep "^{\"incarnation" | grep "\"status\":\"CURRENT\"" | sed "s/^.*\"resetlogs\"://g" | sed "s/\,.*$//g"`
ACTIVATION=`cat sql/gencfg-ORA1.out | egrep "^{\"database" | sed "s/^.*activation\"://g" | sed "s/\,.*$//g"`
cat sql/gencfg-ORA1.out \
    | grep -v "PL/SQL procedure successfully completed." \
    | egrep -v "^SQL\>" \
    | egrep -v "SCN: " \
    | egrep -v "^CONTENT OF: " \
    | egrep -v "^$" \
    > checkpoint/ORA1-chkpt-${SCN}.json

cat <<EOF >checkpoint/ORA1-chkpt.json
{"database":"ORA1","scn":${SCN},"resetlogs":${RESETLOGS},"activation":${ACTIVATION}}
EOF

echo "- starting OpenLogReplicator from SCN ${SCN}"
docker start ${OLR_CONTAINER}

echo "- waiting for olr to start"
timeout 1800s grep -q 'processing redo log' <(tail -n100 -f log/OpenLogReplicator.err)

echo "- all OK"
