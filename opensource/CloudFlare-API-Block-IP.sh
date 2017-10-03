#!/bin/bash


apikey='*************'
zone='*************'
email='*************@hotmail.com'

mkdir -p /vddos/layer4-mapping/cf/block/
iplist_willblock='/vddos/layer4-mapping/cf/block/iplist-willblock.txt'
iplist_blocked='/vddos/layer4-mapping/cf/block/iplist-blocked.txt'

################### Chặn IP:
ten_file_chua_list=$iplist_willblock
echo "`cat $ten_file_chua_list | grep .`" > $ten_file_chua_list
so_dong_file_chua_list=`cat $ten_file_chua_list | grep . | wc -l`
dong=1

while [ $dong -le $so_dong_file_chua_list ]
do
ipblock_hientai=$(awk " NR == $dong " $ten_file_chua_list)
(curl -sSX POST "https://api.cloudflare.com/client/v4/zones/$zone/firewall/access_rules/rules" \
-H "X-Auth-Email: $email" \
-H "X-Auth-Key: $apikey" \
-H "Content-Type: application/json" \
--data "{\"mode\":\"block\",\"configuration\":{\"target\":\"ip\",\"value\":\"$ipblock_hientai\"},\"notes\":\"Block by vDDoS Proxy Protection\"}" >/dev/null 2>&1 & )&
echo "Da block IP $ipblock_hientai"
dong=$((dong + 1))
done
#echo > $iplist_willblock
#echo > $iplist_blocked

