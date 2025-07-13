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

echo "2. creating directories"

mkdir oradata
chmod 755 oradata
sudo chown 54321:54321 oradata

mkdir fra
chmod 755 fra
sudo chown 54321:54321 fra

chmod a+x+r+w sql
chmod a+r sql/*.sql

mkdir checkpoint
chmod 777 checkpoint

mkdir log
chmod 777 log

mkdir output
chmod 777 output

chmod 777 scripts
chmod 644 scripts/OpenLogReplicator.json

chmod 777 setup
chmod 644 setup/config.sql

echo "- all OK"
