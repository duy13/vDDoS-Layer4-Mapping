#!/bin/bash


apikey='*************'
zone='*************'
email='*************@hotmail.com'

mkdir -p /vddos/layer4-mapping/cf/captcha-all-country/
countrylist_willcaptcha='/vddos/layer4-mapping/cf/captcha-all-country/countrylist-willcaptcha.txt'
countrylist_captchated='/vddos/layer4-mapping/cf/captcha-all-country/countrylist-captchated.txt'

################### Captcha cho country:
ten_file_chua_list=$countrylist_willcaptcha
echo "`cat $ten_file_chua_list | grep .`" > $ten_file_chua_list
so_dong_file_chua_list=`cat $ten_file_chua_list | grep . | wc -l`
dong=1

while [ $dong -le $so_dong_file_chua_list ]
do
delaytime=$(( $RANDOM % 9 ))
countrycaptcha_hientai=$(awk " NR == $dong " $ten_file_chua_list)
(sleep $delaytime; curl -sSX POST "https://api.cloudflare.com/client/v4/zones/$zone/firewall/access_rules/rules" \
-H "X-Auth-Email: $email" \
-H "X-Auth-Key: $apikey" \
-H "Content-Type: application/json" \
--data "{\"mode\":\"challenge\",\"configuration\":{\"target\":\"country\",\"value\":\"$countrycaptcha_hientai\"},\"notes\":\"Captcha by vDDoS Proxy Protection\"}" >/dev/null 2>&1 & )&
echo "Da bat captcha country: $countrycaptcha_hientai"
dong=$((dong + 1))
done
#echo > $countrylist_willcaptcha
#echo > $countrylist_captchated

