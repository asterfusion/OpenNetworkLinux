# A plugin to intergrate additional components to ONL.
#
# This script is called by $ONL/third_party/install-extra-pkgs.sh.
# And the value of $PKGS is a path to ONL host defined in $ONL/tools/onlrfs.py.
# Modify install-os-stretch-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-os-stretch-pkgs.sh will disable the intergration.
#

ROOTDIR=/pkgs
OS=`lsb_release -cs`
PKGS=$ROOTDIR/$OS
INSTALL_ONLINE=false

# For running
# libi2c-dev has been installed by apt-get but the /usr/include/linux/i2c-dev.h is overwrite again by linux-headers.
dpkg -r libi2c-dev
cp $PKGS/libi2c-dev_3.1.2-3_all.deb.txt $PKGS/libi2c-dev_3.1.2-3_all.deb
dpkg -i $PKGS/libi2c-dev_3.1.2-3_all.deb

# Install online.
# pip3 install -r $PKGS/requirements.txt

# For p4studio tools
pip3 install $PKGS/click-7.1.2-py2.py3-none-any.whl
pip3 install $PKGS/click_logging-1.0.1-py2.py3-none-any.whl
pip3 install $PKGS/cmakeast-0.0.18.tar.gz
pip3 install $PKGS/PyYAML-5.3.1.tar.gz
pip3 install $PKGS/jsonschema-2.6.0-py2.py3-none-any.whl

# For SDE sources building
pip3 install $PKGS/Tenjin-1.1.1.tar.gz
pip3 install $PKGS/crc16-0.1.1.tar.gz
pip3 install $PKGS/crcmod-1.7.tar.gz
pip3 install $PKGS/ctypesgen-1.0.1-py2.py3-none-any.whl
pip3 install $PKGS/getmac-0.8.2-py2.py3-none-any.whl
pip3 install $PKGS/ipaddress-1.0.23-py2.py3-none-any.whl
pip3 install $PKGS/jsl-0.2.4.tar.gz
pip3 install $PKGS/netifaces-0.11.0-cp35-cp35m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pip3 install $PKGS/packaging-20.9-py2.py3-none-any.whl
pip3 install $PKGS/pyparsing-2.4.7-py2.py3-none-any.whl
pip3 install $PKGS/psutil-5.9.2.tar.gz
pip3 install $PKGS/pysubnettree-0.35.tar.gz
pip3 install $PKGS/tabulate-0.8.10-py3-none-any.whl
pip3 install $PKGS/pyperclip-1.8.2.tar.gz
pip3 install $PKGS/scapy_helper-0.14.8-py2.py3-none-any.whl
pip3 install $PKGS/setuptools-44.1.1-py2.py3-none-any.whl
pip3 install $PKGS/simplejson-3.10.0.tar.gz
pip3 install $PKGS/six-1.16.0-py2.py3-none-any.whl
pip3 install $PKGS/xmlrunner-1.7.7.tar.gz
pip3 install $PKGS/doxypy-0.4.1.tar.gz
pip3 install $PKGS/pkginfo-1.8.2-py2.py3-none-any.whl
