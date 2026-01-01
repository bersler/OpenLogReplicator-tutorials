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

if [ "$(docker ps -a -q -f name=${OLR_CONTAINER})" ]; then
    docker rm -f ${OLR_CONTAINER}
fi

if [ "$(docker ps -a -q -f name=${DB_CONTAINER})" ]; then
    docker rm -f ${DB_CONTAINER}
fi

if [ -d fra ]; then
    sudo rm -rf fra
fi

if [ -d oradata ]; then
    sudo rm -rf oradata
fi

if [ -r sql/test.out ]; then
    sudo rm -rf sql/test.out
fi

if [ -d checkpoint ]; then
    sudo rm -rf checkpoint
fi

if [ -d log ]; then
    sudo rm -rf log
fi

if [ -d output ]; then
    sudo rm -rf output
fi

sudo rm -f sql/gencfg-ORA1.*
sudo rm -f sql/*.out
rm -f sql/gencfg.sql
# 1>/dev/null 2>&1
