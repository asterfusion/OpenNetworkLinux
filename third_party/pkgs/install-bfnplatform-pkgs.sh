# A plugin to intergrate bfnplatform components to ONL.
#
# This script is called by $ONL/third_party/install-extra-pkgs.sh.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-bfnpltform-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-bfnplatform-pkgs.sh will disable the intergration.
#

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/bfnplatform
INSTALL_ONLINE=false

# install sde mainly pkgs
dpkg -i $PKGS/bsp-8.9.x_22.11-rc4-20221125-sde9u3_generic_amd64.deb
dpkg -i $PKGS/sde-9.7.4_1.00-all_generic_amd64.deb
dpkg -i $PKGS/p4c-9.7.4_1.00-all_generic_amd64.deb
dpkg -i $PKGS/kdrv-9.7.4_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb
# install deps
dpkg -i $PKGS/thrift_0.13.0_generic_amd64.deb
dpkg -i $PKGS/grpc_1.17.0-r1_generic_amd64.deb
dpkg -i $PKGS/protobuf-cpp_3.6.1_generic_amd64.deb
dpkg -i $PKGS/nct6779d_1.03-cme3000_4.14.151-OpenNetworkLinux_amd64.deb
dpkg -i $PKGS/cgos_1.06-congatech-d15xx_4.14.151-OpenNetworkLinux_amd64.deb
