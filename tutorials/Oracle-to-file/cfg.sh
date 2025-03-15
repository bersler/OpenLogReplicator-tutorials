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

export DB_IMAGE=${DB_IMAGE:=oracle/database:21.3.0-xe}
export DB_CONTAINER=${DB_CONTAINER:=ORA1}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:tutorial}
export OLR_CONTAINER=${OLR_CONTAINER:=OLR1}

sql() {
    docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus / as sysdba <<EOF
set echo off
set verify off
set heading off
set termout off
set showmode off
set linesize 5000
set pagesize 0
ALTER SESSION SET CONTAINER = XEPDB1;
spool ${2}
@${1}
spool off
EOF
chmod a+r ${2}
" 1>/dev/null 2>&1
}
