#!/bin/bash


apikey='*************'
zone='*************'
email='*************@hotmail.com'


################### Cho ra full thông tin:

fullrawinfo=`curl --silent -X GET "https://api.cloudflare.com/client/v4/zones/$zone/firewall/access_rules/rules?match=all" \
     -H "X-Auth-Email: $email" \
     -H "X-Auth-Key: $apikey" \
     -H "Content-Type: application/json"`
fullinfo=`echo "$fullrawinfo"|jq .`

################### Cho ra tổng số rule:
numberrule=`echo "$fullinfo"| grep "total_count"|awk {'print $2'}`
echo "Tong rule la: $numberrule"
################### Cho ra full ID Rules:
idrulelist=`echo "$fullinfo" | grep '"id":' |sed "/.*$zone.*/d" | awk {'print $2'}| tr -d ','|tr -d '"'`
echo "Danh sach ID la:
$idrulelist"

