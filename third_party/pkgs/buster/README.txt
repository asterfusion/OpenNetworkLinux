# A plugin to intergrate extra offline pkgs to ONL.
#
# Putting below files here, they will be installed by install-os-buster-pkgs.sh during ONL build time.
# Or modify install-os-buster-pkgs.sh to add or delete customized components if reuqired.
# Comment all entries in install-os-buster-pkgs.sh will disable the intergration.
#
#
# Last Updated on 07 Mar. 2024
# Last Updated on 30 Aug. 2023
# Created by Hang Tsi <tsihang@asterfusion.com> on 02 Nov. 2022
#

root@localhost:$ONL/third_party/pkgs/buster$ ls -l
total 99296
-rw-r--r-- 1 root root 27722966 Nov  3 00:29 containerd.io_1.6.9-1_amd64.deb.txt
-rw-r--r-- 1 root root 20437242 Nov  3 00:29 docker-ce_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt
-rw-r--r-- 1 root root 41496026 Nov  3 00:29 docker-ce-cli_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt
-rw-r--r-- 1 root root  8390172 Nov  3 00:29 docker-ce-rootless-extras_5%3a20.10.21~3-0~debian-buster_amd64.deb.txt
-rw-r--r-- 1 root root  3621840 Nov  3 00:29 docker-scan-plugin_0.21.0~debian-buster_amd64.deb.txt

root@localhost:$ONL/third_party/pkgs/buster$

