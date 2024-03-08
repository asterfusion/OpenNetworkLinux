#!
# @file quick-start.sh
# @date 2023/03/09
#
# Environment setup and config for X-T Programmable Bare Metals.
# This script comes from $BSP/platforms/asterfusion-bf/utils/ and
# would be installed to $SDE_INSTALL/bin/
#
# TSIHANG (tsihang@asterfusion.com)
#

#!/bin/bash

# You could get the version of current ONL via 'cat /etc/onl/rootfs/manifest.json'.
# The following VERSION in quick-start.sh should never be changed by user.
VERSION="24.0306"

PKGS=/root/bfnplatform

# Default Variables
default_iface="ma1"
default_iface_ip="192.168.4.50"
default_gateway="192.168.4.1"
install_dir="/usr/local/sde"

# y/Y, n/N
persistent_cfgnet="y"
persistent_cfgsdk="y"

# For tof1 based X5/X3 only
bfnplatform_debs_97x=("$PKGS/sde-9.7.4_1.00-all_generic_amd64.deb" 
"$PKGS/kdrv-9.7.4_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/bsp-lts_24.02-sde9u3_generic_amd64.deb" 
"$PKGS/thrift_0.13.0_generic_amd64.deb" 
"$PKGS/grpc_1.17.0-r1_generic_amd64.deb" 
"$PKGS/protobuf-cpp_3.6.1_generic_amd64.deb" 
"$PKGS/nct6779d_1.04-cme3000_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/cgos_1.06-congatech-d15xx_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/onl-kernel-4.14-lts-x86-64-all_1.0.0_amd64.deb")

# For both tof2 based X732Q-T and tof1 based X5/X3.
bfnplatform_debs_913x=("$PKGS/sde-9.13.2_3.00-all_generic_amd64.deb" 
"$PKGS/kdrv-9.13.2_1.00-all_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/p4c-9.13.2_1.00-all_generic_amd64.deb" 
"$PKGS/bsp-lts_24.02-sde9u9_generic_amd64.deb" 
"$PKGS/thrift_0.14.1_generic_amd64.deb" 
"$PKGS/grpc_1.40.0-r1_generic_amd64.deb" 
"$PKGS/protobuf-cpp_3.15.8_generic_amd64.deb" 
"$PKGS/nct6779d_1.04-cme3000_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/cgos_1.06-congatech-d15xx_4.14.151-OpenNetworkLinux_amd64.deb" 
"$PKGS/onl-kernel-4.14-lts-x86-64-all_1.0.0_amd64.deb")

# Never changed
bfnplatform_debs_breif=("sde-" 
"kdrv-" 
"bsp-" 
"p4c-" 
"thrift" 
"grpc" 
"protobuf-cpp" 
"nct6779d" 
"cgos" 
"onl-kernel-4.14-lts-x86-64-all")

find_iface()
{
    ifaces=(`ifconfig | grep ^[a-z] | awk -F: '{print $1}'`)
    ifaces_ip=(`ifconfig | grep 'netmask' | sed 's/^.*inet //g' | sed 's/ *netmask.*$//g'`)
    for ((i = 0; i < ${#ifaces[@]}; i++))
    do
        if [ "$1"X == "${ifaces[$i]}"X ] || [ "$1"X == "${ifaces_ip[$i]}"X ]; then
            printf "${GREEN}%-19s%-19s${RES}\n" ${ifaces[$i]} ${ifaces_ip[$i]}
        fi
    done
}

# Diff check
further_check()
{
    thrift_pkg_ver=`dpkg -l | grep thrift | awk '{print $3}'`
    if [ "$thrift_pkg_ver"X == "0.11.0"X ] || [ "$thrift_pkg_ver"X == "0.13.0"X ]; then
        # thrift-0.11.0 and thrift-0.13.0 are installed to /usr/local/
        if [[ -f  /usr/local/lib/libthrift-$thrift_pkg_ver.so ]]; then
            if [[ ! -f  $SDE_INSTALL/lib/libthrift-$thrift_pkg_ver.so ]]; then
                ln -s /usr/local/lib/libthrift-$thrift_pkg_ver.so $SDE_INSTALL/lib/libthrift-$thrift_pkg_ver.so
            fi
        fi
    fi
    if [ "$thrift_pkg_ver"X == "0.14.1"X ]; then
        # thrift-0.14.1 is installed to /usr/local/
        if [[ ! -f  $SDE_INSTALL/lib/libthrift-$thrift_pkg_ver.so ]]; then
            echo "No libthrift-$thrift_pkg_ver.so found."
        fi
    fi

    grpc_pkg_ver=`dpkg -l | grep grpc | awk '{print $3}'`
    protobuf_pkg_ver=`dpkg -l | grep protobuf | awk '{print $3}'`

    if [[ ! -f  $SDE_INSTALL/lib/libbfsys.so.0 ]]; then
        ln -s $SDE_INSTALL/lib/libbfsys.so $SDE_INSTALL/lib/libbfsys.so.0
    fi

    # More Check here.
}

do_instdebs() {

    if [ $# -lt 1 ]; then
        exit 0
    fi
    
    dirs=($*)

    for ((i = 0; i < ${#dirs[*]}; i++))
    do
        deb=${dirs[$i]}
        echo "   Installing $deb"
        dpkg -i $deb > /dev/null 2>&1
        if [[ ! -e $deb ]]; then
            echo "              $deb doesn't exist"
	    echo ""
        fi
        unset deb
    done
}

do_uninstdebs() {

    if [ $# -lt 1 ]; then
        exit 0
    fi
    
    dirs=($*)

    for ((i = 0; i < ${#dirs[*]}; i++))
    do
        deb=`dpkg -l | grep ${dirs[$i]} | awk '{print $2}'` 
        if [ "$deb"X != ""X ];then
            echo "   Removing $deb"
            dpkg --purge $deb > /dev/null 2>&1
        fi
        unset deb
    done
}

echo ""
echo ""
echo ""
echo "Uninstalling bfnplatform ..."
echo ""
echo ""
echo ""
do_uninstdebs ${bfnplatform_debs_breif[*]}

if [[ -d  $install_dir ]]; then
    echo "   Removing $install_dir"
    rm -rf $install_dir
fi

unset SDE
unset SDE_INSTALL

echo ""
echo ""
echo ""
echo "Installing bfnplatform   ..."
echo ""
echo ""
echo ""
#dpkg -i /root/bfnplatform/*.deb
do_instdebs ${bfnplatform_debs_913x[*]}

# Link onl-kernel
ln -s \
 /usr/share/onl/packages/amd64/onl-kernel-4.14-lts-x86-64-all/mbuilds/ \
 /lib/modules/4.14.151-OpenNetworkLinux/build > /dev/null 2>&1

echo ""
echo ""
echo ""
echo "Configure SDE Environment Variables ..."
echo ""
echo ""
echo ""
sde=`dpkg -l | grep sde- | awk '{print $2}'`
p4c=`dpkg -l | grep p4c- | awk '{print $2}'`
res=$(cat /root/.bashrc | grep SDE_INSTALL)

if [ "$res"X != ""X ] && [ "$sde"X != ""X ]; then
    source ~/.bashrc
    if [[ -f  $SDE_INSTALL/bin/xt-setup.sh ]]; then
        source xt-setup.sh
    fi
else
    if [ "$sde"X != ""X ]; then
       export SDE=$install_dir/bf-$sde
    fi
    export SDE_INSTALL=/usr/local/sde
    export PATH=$SDE_INSTALL/bin:${PATH}
    export LD_LIBRARY_PATH=$SDE_INSTALL/lib:$LD_LIBRARY_PATH
fi

# At this time, $SDE_INSTALL is ready so loading xt-setup.sh ASAP.
if [[ -f  $SDE_INSTALL/bin/xt-setup.sh ]]; then
    source xt-setup.sh
fi

echo "   Successfully."

if [ "$persistent_cfgsdk"X == "y"X  ] || [ "$persistent_cfgsdk"X == "Y"X  ]; then
    echo -e "   ${YELLOW}Performing(/root/.bashrc) ...${RES}"
    res=$(cat /root/.bashrc | grep SDE_INSTALL)
    if [ "$res"X == ""X ] && [ "$sde"X != ""X ]; then
        echo "" >> /root/.bashrc
        echo "" >> /root/.bashrc
        echo "export SDE=$install_dir/bf-$sde" >> /root/.bashrc
        echo "export SDE_INSTALL=$install_dir" >> /root/.bashrc
        echo 'export PATH=$SDE_INSTALL/bin:${PATH}' >> /root/.bashrc
        echo 'export LD_LIBRARY_PATH=$SDE_INSTALL/lib:$LD_LIBRARY_PATH' >> /root/.bashrc
        echo "" >> /root/.bashrc
        source /root/.bashrc
        echo -e "   ${YELLOW}Successfully.${RES}"
    else
         echo -e "   ${RED}Already configured SDK.${RES}"
    fi
fi

echo ""
echo ""
echo ""
echo "Testing SDE ..."
echo ""
echo ""
echo ""
# Set SDE variable if p4c installed.
if [ "$p4c"X != ""X ]; then
   sdkno=${p4c:4}
   major=`echo $sdkno | awk -F'.' '{print $1}'`
   minor=`echo $sdkno | awk -F'.' '{print $2}'`
   revno=`echo $sdkno | awk -F'.' '{print $3}'`
   echo "   Trying to build an example P4 Prog via SDE $major.$minor.$revno"
   p4_build="p4_build-9.x.y.sh"
   if [ $major -eq 8 ]; then
       p4_build="p4_build.sh"
   fi
   $p4_build $SDE/pkgsrc/p4/$major.$minor.x/tna_exact_match.p4
else
   echo "   No p4c installed"
fi

# Remove previous /etc/platform.conf and generated a new one.
if [[ -f  /etc/platform.conf ]]; then
    rm /etc/platform.conf
fi
# Generate /etc/platform.conf
further_check
#xt-cfgen.sh

echo ""
echo ""
echo ""
echo "Configure Network ..."
echo ""
echo ""
echo ""
# SSH
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

res=$(find_iface $default_iface)
if [ "$res"X == ""X ]; then
    echo -e "   ${RED}No $default_iface found.${RES}"
    exit
fi

if [ "$persistent_cfgnet"X == "n"X  ] || [ "$persistent_cfgnet"X == "N"X  ]; then
    # Network
    res=$(find_iface $default_iface_ip)
    if [ "$res"X != ""X ]; then
        echo -e "   ${RED}Already configured $default_iface $default_iface_ip.${RES}"
    else
        ifconfig $default_iface $default_iface_ip netmask 255.255.255.0
        route add default gw $default_gateway
    fi
else
    echo -e "   ${YELLOW}Performing Network(/etc/network/interfaces) ...${RES}"
    res=$(cat /etc/network/interfaces | grep address | awk '{print $2}')
    if [ "$res"X == ""X ]; then
        echo "" >> /etc/network/interfaces
        echo "" >> /etc/network/interfaces
        echo "# The primary network interface" >> /etc/network/interfaces
        echo "allow-hotplug $default_iface" >> /etc/network/interfaces
        echo "auto $default_iface" >> /etc/network/interfaces
        echo "iface $default_iface inet static" >> /etc/network/interfaces
        echo "address $default_iface_ip" >> /etc/network/interfaces
        echo "netmask 255.255.255.0" >> /etc/network/interfaces
        echo "gateway $default_gateway" >> /etc/network/interfaces
        echo "dns-nameserver 8.8.8.8" >> /etc/network/interfaces
        echo "" >> /etc/network/interfaces
        echo "" >> /etc/network/interfaces
        /etc/init.d/networking restart
        /etc/init.d/ssh restart
        /etc/init.d/resolvconf restart
    else
         echo -e "   ${RED}Already configured $default_iface $res.${RES}"
    fi
fi
echo -e "   ${YELLOW}Successfully.${RES}"

echo ""
echo ""
echo "================================="
echo $SDE
echo $SDE_INSTALL
echo $PATH
echo $LD_LIBRARY_PATH
echo "================================="
echo ""
echo ""

echo "" >> install.log
echo "" >> install.log
echo "`date`" >> install.log
echo "=================================" >> install.log
echo `dpkg -l | grep bsp-`        >> install.log
echo `dpkg -l | grep sde-`        >> install.log
echo `dpkg -l | grep kdrv-`       >> install.log
echo `dpkg -l | grep p4c-`        >> install.log
echo `dpkg -l | grep p4i-`        >> install.log
echo `dpkg -l | grep libboost`    >> install.log
echo `dpkg -l | grep thrift`      >> install.log
echo `dpkg -l | grep protobuf`    >> install.log
echo `dpkg -l | grep grpc`        >> install.log
echo `dpkg -l | grep onl-kernel`  >> install.log
echo "=================================" >> install.log
echo "" >> install.log
echo "" >> install.log


echo ""
echo ""
echo ""
echo -e "Tips:"
echo -e "We're almost approaching after this done and quick-start.sh will exit later."
echo -e "SDE has been installed to $install_dir and environment variables are in ~/.bashrc"
echo -e "Following steps will be helpful to launch X-T Bare Metals."
echo -e ""
echo -e "1. Reload variables via command <source ~/.bashrc>."
echo -e "2. Run xt-cfgen.sh to generate $cfgfile"
echo -e "3. Launch X-T via command <run_switchd.sh -p diag [--arch=tf2]>"
echo ""
echo ""
echo ""

friendly_exit

