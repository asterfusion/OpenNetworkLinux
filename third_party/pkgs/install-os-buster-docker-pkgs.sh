# A plugin to intergrate docker components to ONL.
#
# This script is called by $ONL/third_party/install-extra-pkgs.sh.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-os-buster-docker-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-os-buster-docker-pkgs.sh will disable the intergration.
#

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/$OS
INSTALL_ONLINE=false

# For docker-ce
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
#apt update -y
#apt install -y docker-ce

if [ "$OS"X = "buster"X ]; then
    echo "Install ..."
    #cp $PKGS/containerd.io_1.6.9-1_amd64.deb.txt $PKGS/containerd.io_1.6.9-1_amd64.deb
    #dpkg -i $PKGS/containerd.io_1.6.9-1_amd64.deb
    #cp $PKGS/docker-ce-cli_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt $PKGS/docker-ce-cli_5%3a20.10.21~3-0~debian-buster_amd64.deb
    #dpkg -i $PKGS/docker-ce-cli_5%3a20.10.21~3-0~debian-buster_amd64.deb
    #cp $PKGS/docker-scan-plugin_0.21.0~debian-buster_amd64.deb.txt $PKGS/docker-scan-plugin_0.21.0~debian-buster_amd64.deb
    #dpkg -i $PKGS/docker-scan-plugin_0.21.0~debian-buster_amd64.deb
    #cp $PKGS/docker-ce-rootless-extras_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt $PKGS/docker-ce-rootless-extras_5%3a20.10.21~3-0~debian-buster_amd64.deb
    #dpkg -i $PKGS/docker-ce-rootless-extras_5%3a20.10.21~3-0~debian-buster_amd64.deb
    #cp $PKGS/docker-ce_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt $PKGS/docker-ce_5%3a20.10.21~3-0~debian-buster_amd64.deb
    #dpkg -i $PKGS/docker-ce_5%3a20.10.21~3-0~debian-buster_amd64.deb
fi

