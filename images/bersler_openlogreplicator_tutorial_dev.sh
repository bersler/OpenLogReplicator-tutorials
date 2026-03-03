#!/bin/bash
# Copyright (C) 2018-2026 Adam Leszczynski (aleszczynski@bersler.com)
#
# This file is part of OpenLogReplicator-tutorials
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License along with this program; see the file LICENSE;
# If not, see <http://www.gnu.org/licenses/>.
set -e

if [ -d OpenLogReplicator-docker ]; then
    rm -rf OpenLogReplicator-docker
fi

git clone https://github.com/bersler/OpenLogReplicator-docker
cd OpenLogReplicator-docker
export GIDORA=${GIDORA:=54321}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:tutorial}
export OPENLOGREPLICATOR_VERSION=${OPENLOGREPLICATOR_VERSION:=master}
./build-dev.sh
cd ..
