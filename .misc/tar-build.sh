#!/bin/bash
set -e

# This script builds the Unreal Tournament 99 server package for Linux.
#
# The `./sources/` directory should contain:
#
# * `ut99server436_goty_bp4_linuxfix.tar.zst`
#    This archive should be optimized for linux and contain:
#    - ut-server-linux-436.tar.gz
#    - bonus-pack1.zip
#    - bonus-pack2_(de_pack).zip
#    - bonus-pack3_(inoxx_pack).zip
#    - bonus-pack4_(happy_holidays).zip
# * `OldUnreal-UTPatch469e-rc9-Linux-x86.tar
#    The latest patch for UT99 from OldUnreal (https://github.com/OldUnreal/UnrealTournamentPatches)


#
# check dependencies
#
command -v sha256sum &> /dev/null || { echo "Error: sha256sum is not installed."; exit 1; }
command -v unzstd &> /dev/null || { echo "Error: unzstd is not installed."; exit 1; }
command -v tar &> /dev/null || { echo "Error: tar is not installed."; exit 1; }
command -v xz &> /dev/null && echo "xz is available" || echo "xz is not installed"

#
# Prepare server contents
#
rm -rf ./build
mkdir --parents ./build

tar --use-compress-program=unzstd -xvf ./sources/ut99server436_goty_bp4_linuxfix.tar.zst -C ./build
rm -f ./buildReadme.txt

tar --overwrite -xjvf ./sources/OldUnreal-UTPatch469e-rc9-Linux-x86.tar.bz2 -C ./build

#
# Create
#
rm -f ./ut99-server-469e-linux.tar
find ./build -printf "%P\n" | tar -cf ut99-server-469e-linux.tar --no-recursion -C ./build -T -

rm -f ./ut99-server-469e-linux.tar.xz
xz -zv ./ut99-server-469e-linux.tar

#
# Clean up
#
rm -rf ./build

sha256sum ./ut99-server-469e-linux.tar.xz
