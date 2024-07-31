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

repo_version="next-r3.1.0.mtk"
build_version="2024.07.27_r27011_6.6.41_${repo_version}"

echo ">> Cloning pesa1234's repo into the container. This will take a bit..."
echo ""
git clone -b "$repo_version" https://github.com/pesa1234/openwrt.git /home/user/openwrt/

cd /home/user/openwrt/ || exit

wget "https://raw.githubusercontent.com/pesa1234/MT6000_cust_build/main/${build_version}/targets/mediatek/filogic/config.buildinfo" -O .config

echo ""
echo ">> You can now build Pesa's default build by following the steps here: https://github.com/Fail-Safe/openwrt-pesa1234-build?tab=readme-ov-file#next-steps"
