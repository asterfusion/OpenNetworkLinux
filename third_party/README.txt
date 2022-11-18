Open Network Linux
==================

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
root@localhost:~# run_switchd.sh -p diag

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


6. Compile SDE sources
Put your SDE sources to devices, let's take /root/bf-sde-9.7.4.tgz as an example.
root@localhost:~# tar -xvf bf-sde-9.7.4.tgz
root@localhost:~# cd bf-sde-9.7.4/
root@localhost:~/bf-sde-9.7.4# mkdir -p install/lib
root@localhost:~/bf-sde-9.7.4# mkdir -p install/include
root@localhost:~/bf-sde-9.7.4# mkdir -p install/bin
root@localhost:~# cd bf-sde-9.7.4/p4studio
root@localhost:~/bf-sde-9.7.4/p4studio# ./p4studio packages extract
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/lib/libproto* ../install/lib/
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/lib/libgrpc* ../install/lib/
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/include/google/ ../install/include/ -rf
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/include/grpc* ../install/include/ -rf
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/bin/protoc ../install/bin/
root@localhost:~/bf-sde-9.7.4/p4studio# cp /usr/local/sde/bin/grpc_* ../install/bin/
root@localhost:~/bf-sde-9.7.4/p4studio# ./p4studio configure
root@localhost:~/bf-sde-9.7.4/p4studio# ./p4studio build
