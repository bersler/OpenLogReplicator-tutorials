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
. ../common/functions.sh

echo "5. dropping OpenLogReplicator container"

echo "- dropping container:"
docker_rm "${OLR_CONTAINER}"

echo "- cleaning up files:"
file_rm sql/gencfg-ORA1.sql sql/gencfg-ORA1.out sql/test.out checkpoint log output sql/gencfg.sql

echo "- all OK"
