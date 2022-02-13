#!/bin/bash

# sudo bash Pharus-Post-Installation.php ile kullanılması gerek.
echo "Pharus Post Installation ..."

# ifconfig kullanılabilmesi için net-tools'un yüklenmesi.
apt install net-tools -y

# Host Ip'nin ifconfig ten alınması.
HostIP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

# Nginx Confiğindeki Server Name in alınması
# NginxURL=$(awk '$1=="server_name"{sub(/;/,""); print $2; exit}' /etc/nginx/conf.d/pharusnms.conf)

# Nginx Confiğindeki 2. Satırın Regex için alınması.
Nginx2ndln=$(cat /etc/hosts | sed -n 2p)

while :
do
echo -n "NginxURL : "
read -e NginxURL
echo -n "SNMPLocation : "
read -e SNMPLocation
echo -n "Notification Email : "
read -e Email
echo -n "Email Password : "
read -e mailpass
echo "-----------------------------------------------------"
echo "NginxURL : $NginxURL"
echo "SNMPLocation : $SNMPLocation"
echo "Notification Email : $Email"
echo "Email Password : $mailpass"
echo "-----------------------------------------------------"
echo -n "Configure above URL for your base URL (y/Y yes) : "
read -e VAR1
  if [ "$VAR1" == "y" ] || [ "$VAR1" == "Y" ]; then
    break
  fi
done

echo "-----------------------------------------------------"
echo "Host IP : $HostIP"
echo "Nginx Server Name : $NginxURL"
echo "SNMP Location : $SNMPLocation"
echo "Notification Email : $Email"
echo "Email Password : $mailpass"
echo "-----------------------------------------------------"
echo "The above information will be used for Post Installation ..."

# Host ip nin config.php deki RRDCached ip sine atanması.
sudo -u pharus sed -i "s/\\$config[‘rrdcached’] = '10.255.255.254:42217';/$config[‘rrdcached’] = '${HostIP}:42217';/" /opt/pharus/config.php

# Nginx Server Name'in Base Url olarak eklenmesi.
sudo -u pharus sed -i "s|//\$config|\$config|" /opt/pharus/config.php
sudo -u pharus sed -i "s/\\$config['base_url'] = 'https:\\/\\/pharus.arya-it.com';/\\$config['base_url'] = 'http:\\/\\/${NginxURL}';/" /opt/pharus/config.php

# Oxidized IP set
sudo -u pharus sed -i "s|\$config\['oxidized'\]\['url'\] = 'http:\/\/10.255.255.254:8888';|\$config\['oxidized'\]\['url'\] = 'http:\/\/${HostIP}:8888';|" /opt/pharus/config.php

# Discovery Modullerinin Açılması.
discovery_conf=$(cat << EOF
\$config['discovery_modules']['applications'] = true;\n\$config['discovery_modules']['bgp-peers'] = true;\n\$config['discovery_modules']['cisco-cbqos'] = true;\n\$config['discovery_modules']['cisco-cef'] = true;\n\$config['discovery_modules']['cisco-mac-accounting'] = true;\n\$config['discovery_modules']['cisco-pw'] = true;\n\$config['discovery_modules']['cisco-otv'] = true;\n\$config['discovery_modules']['cisco-vrf-lite'] = true;\n\$config['discovery_modules']['slas'] = true;\n\$config['discovery_modules']['cisco-qfp'] = true;\n\$config['discovery_modules']['discovery-arp'] = true;\n\$config['discovery_modules']['discovery-protocols'] = true;\n\$config['discovery_modules']['entity-physical'] = true;\n\$config['discovery_modules']['entity-state'] = true;\n\$config['discovery_modules']['fdb-table'] = true;\n\$config['discovery_modules']['hr-device'] = true;\n\$config['discovery_modules']['ipv4-addresses'] = true;\n\$config['discovery_modules']['ipv6-addresses'] = true;\n\$config['discovery_modules']['junose-atm-vp'] = true;\n\$config['discovery_modules']['libvirt-vminfo'] = true;\n\$config['discovery_modules']['loadbalancers'] = true;\n\$config['discovery_modules']['mef'] = true;\n\$config['discovery_modules']['mempools'] = true;\n\$config['discovery_modules']['mpls'] = true;\n\$config['discovery_modules']['ntp'] = true;\n\$config['discovery_modules']['os'] = true;\n\$config['discovery_modules']['ports'] = true;\n\$config['discovery_modules']['ports-stack'] = true;\n\$config['discovery_modules']['processors'] = true;\n\$config['discovery_modules']['route'] = true;\n\$config['discovery_modules']['sensors'] = true;\n\$config['discovery_modules']['services'] = true;\n\$config['discovery_modules']['storage'] = true;\n\$config['discovery_modules']['stp'] = true;\n\$config['discovery_modules']['printer-supplies'] = true;\n\$config['discovery_modules']['ucd-diskio'] = true;\n\$config['discovery_modules']['vlans'] = true;\n\$config['discovery_modules']['vmware-vminfo'] = true;\n\$config['discovery_modules']['vrf'] = true;\n\$config['discovery_modules']['wireless'] = true;\n\$config['discovery_modules']['isis'] = true;
EOF
)

sudo -u pharus sed -i "0,/\$config\['discovery_modules'\]\['applications'\] = true;/ s|\$config\['discovery_modules'\]\['applications'\] = true;|${discovery_conf}|" /opt/pharus/config.php


# Poller Modullerinin Açılması.
pollar_conf=$(cat << EOF
\$config['poller_modules']['applications'] = true;\n\$config['poller_modules']['aruba-controller'] = true;\n\$config['poller_modules']['bgp-peers'] = true;\n\$config['poller_modules']['unix-agent'] = true;\n\$config['poller_modules']['availability'] = true;\n\$config['poller_modules']['stp'] = true;\n\$config['poller_modules']['ntp'] = true;\n\$config['poller_modules']['services'] = true;\n\$config['poller_modules']['cipsec-tunnels'] = true;\n\$config['poller_modules']['cisco-ace-loadbalancer'] = true;\n\$config['poller_modules']['cisco-ace-serverfarms'] = true;\n\$config['poller_modules']['cisco-asa-firewall'] = true;\n\$config['poller_modules']['cisco-cbqos'] = true;\n\$config['poller_modules']['cisco-cef'] = true;\n\$config['poller_modules']['cisco-ipsec-flow-monitor'] = true;\n\$config['poller_modules']['cisco-mac-accounting'] = true;\n\$config['poller_modules']['cisco-otv'] = true;\n\$config['poller_modules']['cisco-qfp'] = true;\n\$config['poller_modules']['cisco-remote-access-monitor'] = true;\n\$config['poller_modules']['slas'] = true;\n\$config['poller_modules']['cisco-voice'] = true;\n\$config['poller_modules']['cisco-vpdn'] = true;\n\$config['poller_modules']['entity-physical'] = true;\n\$config['poller_modules']['entity-state'] = true;\n\$config['poller_modules']['hr-mib'] = true;\n\$config['poller_modules']['ipSystemStats'] = true;\n\$config['poller_modules']['ipmi'] = true;\n\$config['poller_modules']['junose-atm-vp'] = true;\n\$config['poller_modules']['loadbalancers'] = true;\n\$config['poller_modules']['mef'] = true;\n\$config['poller_modules']['mempools'] = true;\n\$config['poller_modules']['mpls'] = true;\n\$config['poller_modules']['nac'] = true;\n\$config['poller_modules']['netscaler-vsvr'] = true;\n\$config['poller_modules']['netstats'] = true;\n\$config['poller_modules']['os'] = true;\n\$config['poller_modules']['ports'] = true;\n\$config['poller_modules']['processors'] = true;\n\$config['poller_modules']['sensors'] = true;\n\$config['poller_modules']['storage'] = true;\n\$config['poller_modules']['stp'] = true;\n\$config['poller_modules']['printer-supplies'] = true;\n\$config['poller_modules']['ucd-diskio'] = true;\n\$config['poller_modules']['ucd-mid'] = true;\n\$config['poller_modules']['unix-agent'] = true;\n\$config['poller_modules']['wifi'] = true;\n\$config['poller_modules']['wireless'] = true;\n\$config['poller_modules']['isis'] = true;\n
EOF
)
 
sudo -u pharus sed -i "0,/\$config\['poller_modules'\]\['services'\] = true;/ s|\$config\['poller_modules'\]\['services'\] = true;|${pollar_conf}|" /opt/pharus/config.php

# Oxidized config https -> http & url değişikliği & scheme + delimeter
sudo sed -i "s|url: https://pharus.arya-it.com/api/v0/oxidized|url: http://${NginxURL}/api/v0/oxidized\n    scheme: http\n    delimiter: !ruby/regexp /:/|" ~/.config/oxidized/config

# Oxidized config rest ip değişikliği 
sudo sed -i "s|rest: 127.0.0.1:8888|rest: ${HostIP}:8888|" ~/.config/oxidized/config

# Nginx server name change
sudo sed -i "s|server_name pharustest.arya-it.com;|server_name ${NginxURL};|" /etc/nginx/conf.d/pharusnms.conf 

# Host dosyasına hostip + url in eklenmesi.
sudo sed -i "s|${Nginx2ndln}|${Nginx2ndln}\n${HostIP} ${NginxURL}|" /etc/hosts

sleep 10s
systemctl restart nginx

#Local SNMP
rm -rf /etc/snmp/snmpd.conf
touch /etc/snmp/snmpd.conf
snmp_file=/etc/snmp/snmpd.conf
cat << EOF > $snmp_file
com2sec readonly  default         ARYAsnmp2@!8

group MyROGroup v2c        readonly
view all    included  .1                               80
access MyROGroup ""      any       noauth    exact  all    none   none

syslocation $SNMPLocation
syscontact ARYA-IT <destek@arya-it.com>


dontLogTCPWrappersConnects yes
EOF
sudo systemctl restart snmpd.service

#Oxidized Service File
touch /usr/lib/systemd/system/oxidized.service
service_file=/usr/lib/systemd/system/oxidized.service
cat << EOF > $service_file
# /lib/systemd/system/oxidized.service
[Unit]
Description=Oxidized - Network Device Configuration Backup Tool
After=network-online.target multi-user.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/oxidized
#ExecStart=/opt/rh/rh-ruby23/root/usr/local/bin/oxidized
KillSignal=SIGKILL
User=root

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable oxidized.service
sudo systemctl start oxidized.service

#while :
#do
#echo -n "Notification Email : "
#read -e Email
#echo -n "Email Password : "
#read -e mailpass
#echo -n "Configure above Information (y/Y yes) : "
#read -e VAR1
  #if [ "$VAR1" == "y" ] || [ "$VAR1" == "Y" ]; then
    #break
  #fi
#done

#echo "-----------------------------------------------------"
#echo "Email : $Email"
#echo "Email Password : $mailpass"
#echo "-----------------------------------------------------"
#echo "The above information will be used ..."
#sed -i "s|\['email_smtp_username'\].*|\['email_smtp_username'\] = 'bilgilendirme@arya-it.com';|" /opt/pharus/config.php
#sed -i "s|\['email_smtp_password'\].*|\['email_smtp_password'\] = 'Volcano7854';|" /opt/pharus/config.php
