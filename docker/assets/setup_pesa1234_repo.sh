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

# Set the repo version and config for a specific build branch
repo_version="next-r4.4.6.mtk"
config="https://raw.githubusercontent.com/pesa1234/MT6000_cust_build/refs/heads/main/2024-12-29_r28663-83f150fb3f_next-r4.4.6.mtk/targets/mediatek/filogic/config.buildinfo"
# Alternatively, use the following config for the default build
# config="https://raw.githubusercontent.com/pesa1234/MT6000_cust_build/main/config_file/.config"


echo ">> Cloning pesa1234's repo into the container. This will take a bit..."
echo ""
# Pull the repo if it exists, otherwise clone it
git -C /home/user/openwrt/ pull || git clone -b "$repo_version" https://github.com/pesa1234/openwrt.git /home/user/openwrt/

cd /home/user/openwrt/ || exit

wget "$config" -O .config

# Replace the empty CONFIG_BPF_TOOLCHAIN_HOST_PATH with the value in LLVM_HOST_PATH
sed -i -e 's|CONFIG_BPF_TOOLCHAIN_HOST_PATH=""|CONFIG_BPF_TOOLCHAIN_HOST_PATH="'$LLVM_HOST_PATH'"|' .config

# Check if files in /home/user/extra/ should be copied to the openwrt directory
if [ -d /home/user/extra/ ] && [ "$(ls -A /home/user/extra/ | grep -v '^\.gitkeep$')" ]; then
    echo ">> Copying extra files to /home/user/openwrt/..."
    cp -r /home/user/extra/ /home/user/openwrt/
fi

# Merge diffconfig if supplied
if [ -f /home/user/extra/diffconfig ]; then
    echo ">> Merging diffconfig..."
    cat /home/user/extra/diffconfig >> .config
fi

echo ""
echo ">> You can now build Pesa's default build by following the steps here: https://github.com/Fail-Safe/openwrt-pesa1234-build?tab=readme-ov-file#next-steps"
