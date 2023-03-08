#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward

nftconfig=/home/zhao/.config/xray/nftables.nft 
start() {
  ip route add local default dev lo table 100 
  ip rule add fwmark 1 table 100
  nft -f $nftconfig
}

stop() {
  ip rule del fwmark 1 table 100
  ip route del local 0.0.0.0/0 dev lo table 100
  nft delete table ip xray
}

status() {
    echo "==== nftables rules ===="
    nft list ruleset
    echo
    # echo "==== DNS Sever===="
    # grep "^server=" $DNSCONF
}


case $1 in
start)
    start
    ;;
stop)
    stop
    ;;
status)
    status
    ;;
*)
    echo "$0 start | stop | status"
    ;;
esac
