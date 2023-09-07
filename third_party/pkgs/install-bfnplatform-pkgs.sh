# A plugin to intergrate bfnplatform components to ONL.
#
# This script is called by $ONL/third_party/install-extra-pkgs.sh.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-bfnpltform-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-bfnplatform-pkgs.sh will disable the intergration.
#
# Created by Hang Tsi <tsihang@asterfusion.com> on 02 Nov. 2022
# Last Updated on 30 Aug. 2023
#

#!/bin/bash

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/bfnplatform
INSTALL_ONLINE=false
INSTALL_DIR=$HOME/bfnplatform

#debs_bfnsdk_default=("$PKGS/sde-9.7.4_1.00-all_generic_amd64.deb" 
#"$PKGS/p4c-9.7.4_1.00-all_generic_amd64.deb" 
#"$PKGS/kdrv-9.7,4_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb")
debs_bfnsdk_default=("$PKGS/sde-9.7.4_1.00-all_generic_amd64.deb" 
"$PKGS/kdrv-9.7.4_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb")

debs_bfnplatform_default=("$PKGS/bsp-8.9.x_23.08-rc2-sde9u3_generic_amd64.deb")
debs_bfnplatform_legacy308=("$PKGS/bsp-8.9.1_1.04-2-308-20230209-sde9u3_generic_amd64.deb")

debs_bfnsdk_jdonl=("$PKGS/sde-9.1.1_1.08-all_generic_amd64.deb" 
"$PKGS/p4c-9.1.1_0-all_generic_amd64.deb" 
"$PKGS/kdrv-9.1.1_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb")

debs_bfnplatform_jdonl=("$PKGS/bsp-8.9.x_23.08-rc2_generic_amd64.deb")

debs_common=("$PKGS/thrift_0.13.0_generic_amd64.deb" 
"$PKGS/grpc_1.17.0-r1_generic_amd64.deb" 
"$PKGS/protobuf-cpp_3.6.1_generic_amd64.deb" 
"$PKGS/nct6779d_1.04-cme3000_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/cgos_1.06-congatech-d15xx_4.14.151-OpenNetworkLinux_amd64.deb")

friendly_exit() {
    exit 0
}

do_instdebs() {
    if [ $# != 1 ] ; then
        friendly_exit
    fi

    dirs=$1
    for ((i = 0; i < ${#dirs[@]}; i++))
    do
        printf "Installing %-32s\n" ${dirs[$i]}
        dpkg -i ${dirs[$i]} > /dev/null 2>&1
    done
}

do_copydebs() {
    if [ $# != 1 ] ; then
        friendly_exit
    fi

    dirs=$1
    for ((i = 0; i < ${#dirs[@]}; i++))
    do
        printf "Copying %-32s\n" ${dirs[$i]}
        #cp ${dirs[$i]} $INSTALL_DIR/ > /dev/null 2>&1
        cp ${dirs[$i]} $INSTALL_DIR/
    done
}

# Warm Tips:
#
# /mnt/onl/images almost reaches its up limit so it would rather install them later
# than do it during making ONL image.
# All these debs are located in /root/bfnplatform/ and you will optionally install
# them by excuting quick_start.sh after boot.
#
# by tsihang, 2023/08/30.
#

echo "$INSTALL_DIR"
mkdir -p $INSTALL_DIR

################################################################
# Step 1 Install SDE mainly pkgs
################################################################
do_copydebs "${debs_bfnsdk_default[*]}"
#do_copydebs "${debs_bfnsdk_jdonl[*]}"

# Skip installation due to the Warm Tips
#do_instdebs "${debs_bfnsdk_default[*]}"
#do_instdebs "${debs_bfnsdk_jdonl[*]}"

################################################################
# Step 2 Install BSP bfnplatform for X-T Programmable Bare Metal.
#
# For SDE <= 9.1.x
#    - install bsp-8.9.x_Y.M_generic_amd64.deb
# For SDE >= 9.9.x
#    - install bsp-8.9.x_Y.M-sde9u9_generic_amd64.deb
# For 9.3.x <= SDE <= 9.7.x
#    - install bsp-8.9.x_Y.M-sde9u3_generic_amd64.deb
#
################################################################
do_copydebs "${debs_bfnplatform_default[*]}"
#do_copydebs "${debs_bfnplatform_jdonl[*]}"
#do_copydebs "${debs_bfnplatform_legacy308[*]}"

# Skip installation due to the Warm Tips
#do_instdebs "${debs_bfnplatform_default[*]}"
#do_instdebs "${debs_bfnplatform_legacy308[*]}"
#do_instdebs "${debs_bfnplatform_jdonl[*]}"


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
do_copydebs "${debs_common[*]}"

# Skip installation due to the Warm Tips
#do_instdebs "${debs_common[*]}"

echo $INSTALL_DIR
ls -la $INSTALL_DIR/
echo "Exit ..."

