vDDoS Layer4 Mapping
===================

vDDoS Layer4 Mapping is a addon support for vDDoS Proxy Protection - Monitor processor logs and block it in Layer 3-4. This tool is product for those people ask me to add "BLOCK & CAPTCHA" on Layer 3-4 (Support Iptables CSF & CloudFlare API) for vDDoS Proxy Protection.

----------

1/ Install vDDoS Proxy Protection:
-------------
To install vDDoS Proxy Protection please visit this site: http://vddos.voduy.com

----------


2/ Install vDDoS Layer4 Mapping:
-------------
```
curl -L https://github.com/duy13/vDDoS-Layer4-Mapping/raw/master/vddos-layer4-mapping -o /usr/bin/vddos-layer4
chmod 700 /usr/bin/vddos-layer4
/usr/bin/vddos-layer4
```

Using vDDoS Layer4 Mapping:
-------------
```

   Welcome to vDDoS, a HTTP(S) DDoS Protection Reverse Proxy. Thank you for using!

        Please choose vDDoS Layer 4 Running Mode:

         CloudFlare Mode:
          1. Enable Captcha-All-Country Mode (Recommend This Mode For Large DDoS Attacks)
          2. Enable Monitor-vDDoS-logs-and-Captcha Mode
          3. Enable Monitor-vDDoS-logs-and-Block Mode
          4. Remove all rules exist on CloudFlare Firewall

         CSF Mode:
          5. Enable Monitor-vDDoS-logs-and-Block Mode
          6. Remove all rules exist on CSF

         End & Exit:
          7. End All Process (Kill all Process Mode Running)
          8. Exit

Enter Your Answer [1, 2, 3... or 8]:
```

If you use CloudFlare:
-------------
Register account on CloudFlare.com > Add Your Website > Overview > View Zone ID

Email > My Setting > API Key > Global API Key > View API Key


If you use CSF:
-------------
Homepage: https://configserver.com/cp/csf.html


Install CSF:
```
cd /usr/src/
wget 'https://download.configserver.com/csf.tgz'
tar -xvf csf.tgz
cd csf
sh install.sh
chkconfig --levels 235 csf on
chkconfig --levels 235 lfd on
```

Config CSF:
```
cd /etc/csf/
sed -i 's/TESTING = "1"/TESTING = "0"/g' /etc/csf/csf.conf
```

Restart CSF:
```
csf -r && csf -q && service lfd restart
```

3/ More Config:
---------------
Document: http://vddos.voduy.com
```
Still in beta, use at your own risk! It is provided without any warranty!
```