# A plugin to intergrate bfnplatform components to ONL.
#
# This script is called by $ONL/third_party/install-extra-pkgs.sh.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-bfnpltform-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-bfnplatform-pkgs.sh will disable the intergration.
#
# Last Updated on 14 Apr. 2025
# Last Updated on 08 Mar. 2024
# Last Updated on 30 Aug. 2023
# Created by Hang Tsi <tsihang@asterfusion.com> on 02 Nov. 2022
#

#!/bin/bash

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/bfnplatform
INSTALL_ONLINE=false
INSTALL_DIR=$HOME/bfnplatform
# from 4.14.151-OpenNetworkLinux
KERNEL_RELEASE="5.15.180-OpenNetworkLinux"
onl_kernel=`echo $KERNEL_RELEASE | cut -b 1-4`

# Also keep bsp for SDE lower than 9.9.x
# uart.c is used to detect platform
debs_bfnplatform_default=("$PKGS/uart.c" 
"$PKGS/bsp-lts_25.03-sde9u9_generic_amd64.deb" 
"$PKGS/bsp-lts_25.03-sde9u3_generic_amd64.deb")

# sde-x.y.z_1.**.deb for tof1 only
# sde-x.y.z_2.**.deb for tof2 only
debs_bfnsdk_default=("$PKGS/sde-9.13.3_1.00-all_generic_amd64.deb" 
"$PKGS/sde-9.13.3_2.00-2.4E0-4-all_generic_amd64.deb")

# Debs which suitable to $debs_bfnsdk_default
debs_common_default=("$PKGS/thrift_0.14.1_generic_amd64.deb" 
"$PKGS/grpc_1.40.0-r1_generic_amd64.deb" 
"$PKGS/protobuf-cpp_3.15.8_generic_amd64.deb")

debs_bfnplatform_legacy308=("$PKGS/bsp-8.9.1_1.04-2-308-20230209-sde9u3_generic_amd64.deb")
debs_bfnsdk_legacy308=("Legacy")
debs_common_legacy308=("Legacy")

friendly_exit() {
    exit 0
}

do_instdebs() {
    if [ $# -lt 1 ]; then
        friendly_exit
    fi
    
    dirs=($*)

    for ((i = 0; i < ${#dirs[*]}; i++))
    do
        deb=${dirs[$i]}
        printf "Copying %-32s\n" $deb
        dpkg -i $deb > /dev/null 2>&1
        unset deb
    done
}

do_copydebs() {
    if [ $# -lt 1 ]; then
        friendly_exit
    fi
    
    dirs=($*)

    for ((i = 0; i < ${#dirs[*]}; i++))
    do
        deb=${dirs[$i]}
        printf "Copying %-32s\n" $deb
        cp $deb $INSTALL_DIR/
        unset deb
    done
}

do_copydrv() {
    deb=$PKGS/nct6779d_1.04-cme3000_${KERNEL_RELEASE}_amd64.deb
    printf "Copying %-32s\n" $deb
    cp $deb $INSTALL_DIR/

    deb=$PKGS/cgos_1.06-congatech-d15xx_${KERNEL_RELEASE}_amd64.deb
    printf "Copying %-32s\n" $deb
    cp $deb $INSTALL_DIR/

    deb=$PKGS/kdrv-9.13.3_1.00-all_${KERNEL_RELEASE}_amd64.deb
    printf "Copying %-32s\n" $deb
    cp $deb $INSTALL_DIR/

    deb=$PKGS/onl-kernel-${onl_kernel}-lts-x86-64-all_1.0.0_amd64.deb
    printf "Copying %-32s\n" $deb
    cp $deb $INSTALL_DIR/

    # For intel ICE E800 Serials
    deb=$PKGS/intel-ice-1.3.16.0.tgz
    printf "Copying %-32s\n" $deb
    cp $deb $INSTALL_DIR/
}

#
# Warm Tips:
#
# /mnt/onl/images almost reaches its up limit so it would rather install them later
# than do it during making ONL image.
# All these debs are located in /root/bfnplatform/ and you will optionally install
# them by excuting quick_start.sh after boot.
#
# by Hang Tsi, 2023/08/30.
#

echo "$INSTALL_DIR"
mkdir -p $INSTALL_DIR

################################################################
# Step 1 Install SDE mainly pkgs
################################################################
do_copydebs ${debs_bfnsdk_default[*]}

# Skip installation due to the Warm Tips
#do_instdebs ${debs_bfnsdk_default[*]}

################################################################
# Step 2 Install BSP bfnplatform for X-T Programmable Bare Metal.
#
# For SDE <= 9.1.x
#    - install bsp-lts_Y.M_generic_amd64.deb
# For SDE >= 9.9.x
#    - install bsp-lts_Y.M-sde9u9_generic_amd64.deb
# For 9.3.x <= SDE <= 9.7.x
#    - install bsp-lts_Y.M-sde9u3_generic_amd64.deb
#
################################################################
do_copydebs ${debs_bfnplatform_default[*]}
#do_copydebs ${debs_bfnplatform_legacy308[*]}

# Skip installation due to the Warm Tips
#do_instdebs ${debs_bfnplatform_default[*]}
#do_instdebs ${debs_bfnplatform_legacy308[*]}


################################################################
# Step 3 Install dependencies
#
# cgos and nct6779d depend on the kernel of the installed system.
# Since bf-sde-8.9.x
#    thrift-0.11.0
#    protobuf-cpp-3.6.1
#    grpc-1.17.0
# Since bf-sde-9.5.x
#    thrift-0.13.0
#    protobuf-cpp-3.6.1
#    grpc-1.17.0
# Since bf-sde-9.9.x
#    thrift-0.14.1
#    protobuf-cpp-3.6.1
#    grpc-1.17.0
# Since bf-sde-9.11.x
#    thrift-0.14.1
#    protobuf-cpp -3.15.8
#    grpc-1.40.0
################################################################
do_copydebs ${debs_common_default[*]}

do_copydrv

# Skip installation due to the Warm Tips
#do_instdebs ${debs_common_default[*]}

# List all pkgs
echo $INSTALL_DIR
ls -la $INSTALL_DIR/
echo "Exit ..."

