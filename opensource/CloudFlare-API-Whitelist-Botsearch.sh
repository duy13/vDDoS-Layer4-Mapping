#!/bin/bash


apikey='*************'
zone='*************'
email='*************@hotmail.com'

mkdir -p /vddos/layer4-mapping/cf/whitelist/
iplist_willwhitelist='/vddos/layer4-mapping/cf/whitelist/iplist-willwhitelist.txt'
iplist_whitelisted='/vddos/layer4-mapping/cf/whitelist/iplist-whitelisted.txt'

################### Chặn IP:
ten_file_chua_list=$iplist_willwhitelist
echo "`cat $ten_file_chua_list | grep .`" > $ten_file_chua_list
so_dong_file_chua_list=`cat $ten_file_chua_list | grep . | wc -l`
dong=1

while [ $dong -le $so_dong_file_chua_list ]
do
ipwhitelist_hientai=$(awk " NR == $dong " $ten_file_chua_list)
(curl -sSX POST "https://api.cloudflare.com/client/v4/zones/$zone/firewall/access_rules/rules" \
-H "X-Auth-Email: $email" \
-H "X-Auth-Key: $apikey" \
-H "Content-Type: application/json" \
--data "{\"mode\":\"whitelist\",\"configuration\":{\"target\":\"ip_range\",\"value\":\"$ipwhitelist_hientai\"},\"notes\":\"Whitelist by vDDoS Proxy Protection\"}" >/dev/null 2>&1 & )&
echo "Da Whitelist IP $ipwhitelist_hientai"
dong=$((dong + 1))
done
#echo > $iplist-willwhitelist
#echo > $iplist-whitelisted

