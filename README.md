# initscripts profiling

```shell
./set_ifcfg_debug
echo 'DEVICE=br0
TYPE=Bridge
IPADDR=192.168.1.1
NETMASK=255.255.255.0
ONBOOT=yes
BOOTPROTO=none
NM_CONTROLLED=no
DELAY=0' > /etc/sysconfig/network-scripts/ifcfg-br0
ifup br0 2>&1 | ./profile | less
ifdown br0 2>&1 | ./profile | less
rm -f /etc/sysconfig/network-scripts/ifcfg-br0
./reset_ifcfg_debug
```
