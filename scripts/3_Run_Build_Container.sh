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

image_name="pesa1234-builder"
volume_name="pesa1234-build"

echo ">> Running docker container..."
echo ""
docker run -it --mount type=volume,source="$volume_name",target=/home/user --rm --name "$image_name" "$image_name"
