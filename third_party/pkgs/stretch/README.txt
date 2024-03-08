# A plugin to intergrate extra offline pkgs to ONL.
#
# Putting below files here, they will be installed by install-os-stretch-pkgs.sh during ONL build time.
# Or modify install-os-stretch-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-os-stretch-pkgs.sh will disable the intergration.
#
#
# Last Updated on 07 Mar. 2024
# Last Updated on 30 Aug. 2023
# Created by Hang Tsi <tsihang@asterfusion.com> on 02 Nov. 2022
#


root@localhost:$ONL/third_party/pkgs/stretch$ ls -l
total 95760
-rw-r--r-- 1 root root    82780 Nov  3 00:29 click-7.1.2-py2.py3-none-any.whl
-rw-r--r-- 1 root root     6587 Nov  3 00:29 click_logging-1.0.1-py2.py3-none-any.whl
-rw-r--r-- 1 root root    19222 Nov  3 00:29 cmakeast-0.0.18.tar.gz
-rw-r--r-- 1 root root 28102422 Nov  3 00:29 containerd.io_1.4.3-1_amd64.deb.txt
-rw-r--r-- 1 root root     9631 Nov  3 00:29 crc16-0.1.1.tar.gz
-rw-r--r-- 1 root root    89670 Nov  3 00:29 crcmod-1.7.tar.gz
-rw-r--r-- 1 root root   441251 Nov  3 00:29 ctypesgen-1.0.1-py2.py3-none-any.whl
-rw-r--r-- 1 root root 22736144 Nov  3 00:29 docker-ce_5%3a19.03.15~3-0~debian-stretch_amd64.deb.txt
-rw-r--r-- 1 root root 44185130 Nov  3 00:29 docker-ce-cli_5%3a19.03.15~3-0~debian-stretch_amd64.deb.txt
-rw-r--r-- 1 root root     4536 Nov  3 00:29 doxypy-0.4.1.tar.gz
-rw-r--r-- 1 root root    24278 Nov  3 00:29 getmac-0.8.2-py2.py3-none-any.whl
-rw-r--r-- 1 root root    18159 Nov  3 00:29 ipaddress-1.0.23-py2.py3-none-any.whl
-rw-r--r-- 1 root root    21015 Nov  3 00:29 jsl-0.2.4.tar.gz
-rw-r--r-- 1 root root    39524 Nov  3 00:29 jsonschema-2.6.0-py2.py3-none-any.whl
-rw-r--r-- 1 root root    10722 Nov  3 00:29 libi2c-dev_3.1.2-3_all.deb.txt
-rw-r--r-- 1 root root    32674 Nov  3 00:29 netifaces-0.11.0-cp35-cp35m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
-rw-r--r-- 1 root root    40870 Nov  3 00:29 packaging-20.9-py2.py3-none-any.whl
-rw-r--r-- 1 root root    26450 Nov  3 00:29 pkginfo-1.8.2-py2.py3-none-any.whl
-rw-r--r-- 1 root root    49567 Nov  3 00:29 ply-3.11-py2.py3-none-any.whl
-rw-r--r-- 1 root root   150750 Nov  3 00:29 ply-3.9.tar.gz
-rw-r--r-- 1 root root   479757 Nov  3 00:29 psutil-5.9.2.tar.gz
-rw-r--r-- 1 root root    67842 Nov  3 00:29 pyparsing-2.4.7-py2.py3-none-any.whl
-rw-r--r-- 1 root root    20920 Nov  3 00:29 pyperclip-1.8.2.tar.gz
-rw-r--r-- 1 root root    51169 Nov  3 00:29 pysubnettree-0.35.tar.gz
-rw-r--r-- 1 root root   269377 Nov  3 00:29 PyYAML-5.3.1.tar.gz
-rw-r--r-- 1 root root        0 Nov  3 01:14 README.txt
-rw-r--r-- 1 root root    16116 Nov  3 00:29 scapy_helper-0.14.8-py2.py3-none-any.whl
-rw-r--r-- 1 root root   583493 Nov  3 00:29 setuptools-44.1.1-py2.py3-none-any.whl
-rw-r--r-- 1 root root    77953 Nov  3 00:29 simplejson-3.10.0.tar.gz
-rw-r--r-- 1 root root    83134 Nov  3 00:29 simplejson-3.17.6.tar.gz
-rw-r--r-- 1 root root    11053 Nov  3 00:29 six-1.16.0-py2.py3-none-any.whl
-rw-r--r-- 1 root root    29068 Nov  3 00:29 tabulate-0.8.10-py3-none-any.whl
-rw-r--r-- 1 root root   206776 Nov  3 00:29 Tenjin-1.1.1.tar.gz
-rw-r--r-- 1 root root     5557 Nov  3 00:29 xmlrunner-1.7.7.tar.gz

root@localhost:$ONL/third_party/pkgs/stretch$
