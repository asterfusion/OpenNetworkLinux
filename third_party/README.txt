Open Network Linux
==================

We have several files in ONL /root filesystem:
root@localhost:~# tree
.
├── bfnplatform
│   ├── bsp-lts_25.03-sde9u9_generic_amd64.deb
│   ├── grpc_1.40.0-r1_generic_amd64.deb
│   ├── nct6779d_1.04-cme3000_`uname -r`_amd64.deb
│   ├── cgos_1.06-congatech-d15xx_`uname -r`_amd64.deb
│   ├── kdrv-9.13.3_1.00-all_`uname -r`_amd64.deb
│   ├── protobuf-cpp_3.15.8_generic_amd64.deb
│   ├── sde-9.13.3_1.00-all_generic_amd64.deb
│   ├── sde-9.13.3_2.00-2.4E0-4-all_generic_amd64.deb
│   ├── thrift_0.14.1_generic_amd64.deb
│   └── uart.c
├── quick-start.sh
└── README.txt

1 directory, 16 files

The /root/quick-start.sh is a tool, which will automatically
get all requried debs from /root/bfnplatform and then install
them. It will also configure the networks and SSH for deivce.
Besides, it will also write SDE enviroment variables to ~/.bashrc.
You can freely run it for first use, OR you'd have to install
them and then finish the following sections by hands to before
getting started with X-T Programmable Bare Metal Switch.




1. LAN and Remote access
1.1. LAN
root@localhost:~# vi /etc/network/interfaces
auto ma1
iface ma1 inet static
address 192.168.4.50
netmask 255.255.255.0
gateway 192.168.4.1
dns-nameserver 8.8.8.8

1.2. Remote access
root@localhost:~# vi /etc/ssh/sshd_config
PermitRootLogin yes

1.3. Restart the network to make the above configuration effect
root@localhost:~# /etc/init.d/networking restart

2. Setting environment variables for bfnsdk runtime
root@localhost:~# vi ~/.bashrc
export SDE=/usr/local/sde/bf-sde-9.7.4
export SDE_INSTALL=/usr/local/sde
export PATH=$SDE_INSTALL/bin:$PATH
export LD_LIBRARY_PATH=$SDE_INSTALL/lib:$LD_LIBRARY_PATH

root@localhost:~# source ~/.bashrc

3. Load required kernel drivers and generate /etc/platform.conf. It will be done by /usr/local/sde/bin/xt-cfgen.sh. 
And make sure at least execute /usr/local/sde/bin/xt-cfgen.sh once after a reboot.
root@localhost:~# rm /etc/platform.conf
root@localhost:~# xt-cfgen.sh 
/usr/local/sde/bin/uart_util
bmc_version is 1.1.0
Platform : X532P-T-S
It looks like x532p-t detected.
COMe     : CG1508


 We found that the /etc/platform.conf already exists and no new configuration file will be generated.
 The purpose of this prompt is to take into account that your system may have worked fine in the past.
 If you want to generate a new configuration file, delete the old one first.

Press any key to exit.

4. Run intergrated diag.p4
root@localhost:~# run_switchd.sh [--arch=tf2] -p diag

5. Compile a new p4 source
root@localhost:~# p4_build-9.x.y.sh /usr/local/sde/bf-sde-9.7.4/pkgsrc/p4/9.7.x/tna_exact_match.p4
root@localhost:~# run_switchd.sh -p tna_exact_match
...
bfshell> bfrt_python 
cwd set to: /usr/local/sde/

We've found 1 p4 programs:
tna_exact_match

Loading the tables ... 


Python 3.4.8+ (default, Jul  7 2022, 13:23:42) 
Type 'copyright', 'credits' or 'license' for more information
IPython 6.5.0.dev -- An enhanced Interactive Python. Type '?' for help.

bfrt_root>

