#!/usr/bin/env bash

# Copyright (C) 2024  Mark Baker <mark@vpost.net>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo "Copyright (C) 2024  Mark Baker <mark@vpost.net>"
echo "This program comes with ABSOLUTELY NO WARRANTY."
echo "This is free software, and you are welcome to redistribute it"
echo "under certain conditions."
echo ""

volume_name="pesa1234-build"

# Check if the volume already exists
if [[ $(docker volume ls | grep -c "$volume_name") -eq 1 ]]; then
    echo ">> ** Uh oh! The docker volume $volume_name already exists. You likely do not want to be running this again! **"
    exit 1
fi

# Create this only once...
echo ">> Creating docker volume:"
docker volume create "$volume_name"

echo ""
echo ">> Created docker volume $volume_name for your build system."
