#!/bin/bash
####PharusNMS Install
####For Ubuntu

apt install software-properties-common -y
add-apt-repository universe -y
apt update -y
apt install -y acl curl composer fping git graphviz imagemagick mariadb-client mariadb-server mtr-tiny nginx-full nmap php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-json php7.4-mbstring php7.4-mysql php7.4-snmp php7.4-xml php7.4-zip rrdtool snmp snmpd whois unzip python3-pymysql python3-dotenv python3-redis python3-setuptools python3-systemd python3-pip
### Add USER
useradd pharus -d /opt/pharus -M -r -s "$(which bash)"
### GitHub
cd /opt
git clone https://github.com/aryait/pharus.git
### Permission
chown -R pharus:pharus /opt/pharus
chmod 771 /opt/pharus
setfacl -d -m g::rwx /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/
setfacl -R -m g::rwx /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/
### Composer
sudo -u pharus bash << EOF
/opt/pharus/scripts/composer_wrapper.php install --no-dev
wget https://getcomposer.org/composer-stable.phar
mv composer-stable.phar /usr/bin/composer
chmod +x /usr/bin/composer
python3 /opt/pharus/scripts/check_requirements.py
pip3 install --user -r /opt/pharus/requirements.txt
:
EOF
### Time
cat /opt/pharus/arya_data/Settings/fpm/php.ini > /etc/php/7.4/fpm/php.ini
cat /opt/pharus/arya_data/Settings/cli/php.ini > /etc/php/7.4/cli/php.ini
timedatectl set-timezone Europe/Istanbul

### Database
cat /opt/pharus/arya_data/Settings/mariadb/50-server.cnf >  /etc/mysql/mariadb.conf.d/50-server.cnf

systemctl enable mariadb
systemctl start mariadb
/usr/bin/mysqladmin -u root password 'Pharus8912!'
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -pPharus8912! -Dmysql
mysql -u root -pPharus8912! </opt/pharus/arya_data/Settings/mariadb/sql1.sql

cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/pharusnms.conf
cat /opt/pharus/arya_data/Settings/fpm/pharus.conf > /etc/php/7.4/fpm/pool.d/pharusnms.conf
cat /opt/pharus/arya_data/Settings/nginx/pharus.conf > /etc/nginx/conf.d/pharusnms.conf
rm -rf /etc/nginx/sites-enabled/default
systemctl restart nginx
systemctl restart php7.4-fpm

ln -s /opt/pharus/lnms /usr/bin/lnms
cp /opt/pharus/misc/lnms-completion.bash /etc/bash_completion.d/
cp /opt/pharus/snmpd.conf.example /etc/snmp/snmpd.conf
cat /opt/pharus/arya_data/Settings/snmp/snmpd.conf > /etc/snmp/snmpd.conf

curl -o /usr/bin/distro https://raw.githubusercontent.com/pharus/pharus-agent/master/snmp/distro
chmod +x /usr/bin/distro
systemctl enable snmpd
systemctl restart snmpd

cat /opt/pharus/arya_data/Settings/cron/pharusnms > /etc/cron.d/pharusnms
cp /opt/pharus/arya_data/Settings/log/librenms /etc/logrotate.d/pharus
chown pharus:pharus /opt/pharus/config.php
cd /opt/pharus/
sudo -u pharus bash << EOF
./daily.sh
./adduser.php admin password 10
EOF

mysql -u root -pPharus8912! </opt/pharus/arya_data/Settings/mariadb/sql2.sql

sudo cp /opt/pharus/misc/librenms.logrotate /etc/logrotate.d/librenms
sudo chown -R pharus:pharus /opt/pharus
sudo setfacl -d -m g::rwx /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/
sudo chmod -R ug=rwX /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/

#Plugins
sudo apt-get install rrdcached -y
cat /opt/pharus/arya_data/Settings/rrdcache/rrdcached > /etc/default/rrdcached
chown pharus:pharus /var/lib/rrdcached/journal/
systemctl restart rrdcached.service
systemctl enable rrdcached.service
#####NAgios
#####Oxidized
add-apt-repository universe -y
apt-get install ruby ruby-dev libsqlite3-dev libssl-dev pkg-config cmake libssh2-1-dev libicu-dev zlib1g-dev g++ -y
gem install oxidized
gem install oxidized-script oxidized-web
useradd oxidized
oxidized
cat /opt/pharus/arya_data/Settings/oxidized/config > /root/.config/oxidized/config
echo ###API Create Unutma###

chmod 771 /opt/pharus
chmod 755 /opt/pharus/html/ -R
mkdir -p /opt/oxidized/output/

### Pharus-Post-Installer
sudo bash /opt/pharus/arya_data/Settings/Pharus-Post-Installation.sh

sleep 2m


chown -R pharus:pharus /opt/pharus
setfacl -d -m g::rwx /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/
chmod -R ug=rwX /opt/pharus/rrd /opt/pharus/logs /opt/pharus/bootstrap/cache/ /opt/pharus/storage/

echo "Installation Complete."
