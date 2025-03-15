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

if [[ "$(docker images -q ${DB_IMAGE} 2> /dev/null)" == "" ]]; then
    echo "Docker image ${DB_IMAGE} not found. Please build it first."
    exit 1
fi

if [[ "$(docker images -q ${OLR_IMAGE} 2> /dev/null)" == "" ]]; then
    echo "Docker image ${OLR_IMAGE} not found. Please build it first."
    exit 1
fi

echo "all OK"
