# A plugin to intergrate extra components to ONL.
#
# This script is called by $ONL/tools/onlrfs.py.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-extra-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-extra-pkgs.sh will disable the intergration.
#

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/$OS
INSTALL_ONLINE=false

echo "Current OS -> $OS"

# Install sde pkgs
source $ROOTDIR/install-bfnplatform-pkgs.sh

if [ "$OS"X = "stretch"X ]; then
    # For docker-ce
    source $ROOTDIR/install-os-stretch-docker-pkgs.sh
    # For sde running
    source $ROOTDIR/install-os-stretch-pkgs.sh
fi

if [ "$OS"X = "buster"X ]; then
    # For docker-ce
    source $ROOTDIR/install-os-buster-docker-pkgs.sh
    # For sde running
    source $ROOTDIR/install-os-buster-pkgs.sh
fi
