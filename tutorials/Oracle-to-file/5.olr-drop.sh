#!/bin/bash
# Copyright (C) 2018-2026 Adam Leszczynski (aleszczynski@bersler.com)
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

echo "5. dropping OpenLogReplicator container"

echo "- dropping container:"
docker rm -f ${OLR_CONTAINER} 1>/dev/null 2>&1 || true

echo "- dropping OpenLogReplicator schema"
sql /opt/sql/drop-usrolr.sql /opt/sql/drop-usrolr.out

echo "- cleaning up files:"
sudo rm -rf sql/drop-usrolr.out sql/schema-usrolr.out sql/test.out checkpoint log output 1>/dev/null 2>&1 || true

echo "- all OK"
