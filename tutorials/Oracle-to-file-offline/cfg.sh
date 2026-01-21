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

export DB_IMAGE=${DB_IMAGE:=oracle/database:21.3.0-xe}
export DB_CONTAINER=${DB_CONTAINER:=ORA2}
export OLR_VERSION=${OLR_VERSION:=1.9.0}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:tutorial}
export OLR_CONTAINER=${OLR_CONTAINER:=OLR2}
