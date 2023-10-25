#!/bin/sh
set -e

# port=$(jq '.inbounds[] | select(.tag == "transparent") | .port' /etc/clash/config.json)
port=9999

if [[ x"$port" == x"" ]];then
    exit 1
fi

#代理局域网设备
if [ $# -lt 1 ];
then
    nft list table clash > /dev/null 2>&1 && exit 0 || true
    # 添加路由
    ip rule show table 100 | grep -q 'fwmark 0x1' || ip rule add fwmark 1 table 100
    ip route show table 100 | grep -q 'local.*dev lo' || ip route add local 0.0.0.0/0 dev lo table 100
    # 添加clash表
    nft add table clash

    # Tproxy转发
    nft add chain clash prerouting { type filter hook prerouting priority mangle \; }
    nft add rule clash prerouting iif {nrpodman0, virbr0} counter return
    nft add rule clash prerouting ip daddr { 0.0.0.0/32, 10.0.0.0/8, 127.0.0.0/8, 172.0.0.0/8, 192.168.0.0/16, 255.255.255.255/32 } counter return
    nft add rule clash prerouting meta l4proto { tcp, udp } mark set 1 tproxy to 127.0.0.1:$port counter accept # 转发至 V2Ray 9999 端口

    # 转发53端口到1053
    nft add chain clash dns { type nat hook prerouting priority dstnat \; }
    nft add rule clash dns iif {nrpodman0, virbr0} counter return
    nft add rule clash dns meta l4proto { tcp, udp } @th,16,16 53 counter redirect to :1053 # 取消dns转发

    # 转发本地流量到1053
    nft add chain clash dnsout { type nat hook output priority 0 \; }
    nft add rule clash dnsout ip daddr { 117.50.11.11,52.80.66.66 } return
    nft add rule clash dnsout socket cgroupv2 level 2 "system.slice/system-clash.slice" counter return
    nft add rule clash dnsout socket cgroupv2 level 2 "system.slice/libvirtd.service" counter return || true
    nft add rule clash dnsout meta l4proto { tcp, udp } @th,16,16 53 counter redirect to :1053 # 取消dns转发

    # 代理网关本机
    nft add chain clash output { type route hook output priority mangle \; }
    nft add rule clash output ip daddr { 0.0.0.0/32, 10.0.0.0/8, 127.0.0.0/8, 172.0.0.0/8, 192.168.0.0/16, 224.0.0.0/4, 255.255.255.255/32 } counter return
    nft add rule clash output socket cgroupv2 level 2 "system.slice/system-clash.slice" counter return
    nft add rule clash output socket cgroupv2 level 2 "system.slice/libvirtd.service" counter return || true
    nft add rule clash output meta l4proto { tcp, udp } mark set 1 counter # 重路由至 prerouting

    # DIVERT 规则
    nft add chain clash divert { type filter hook prerouting priority -150 \; }
    nft add rule clash divert meta l4proto tcp socket transparent 1 meta mark set 1 counter accept
else
    ruleids=($(ip rule show table 100 | grep fwmark | awk '{sub(":","",$1);printf $1" "}'))
    for ruleid in ${ruleids[@]}
    do
        ip rule del prio ${ruleid}
    done
    ip route del 0.0.0.0/0 table 100 2> /dev/null || true
    nft delete table clash 2> /dev/null || true
fi
