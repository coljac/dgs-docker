#!/bin/bash

# DATASTORE_FOLDER is null for some reason

DGS=/root/dragongoserver-dgs-main
cd /root

/bin/bash -c "/usr/bin/mysqld_safe > /dev/null &" 
sleep 5 
mysql -u root < setup.sql 
mysql -u dragon_admin -D dragondb -pdragonadmin < dragongoserver-dgs-main/specs/db/dragon-ddl.sql
mysql -u dragon_admin -D dragondb -pdragonadmin < dragongoserver-dgs-main/specs/db/dragon-data.sql
cat $DGS/include/config.php | sed "s/SEND_ACTIVATION_MAIL', true/SEND_ACTIVATION_MAIL', false/" | sed "s/'MYSQLPASSWORD', ''/'MYSQLPASSWORD', 'dragon'/" | sed "s/.*MYSQLHOST.*/define('MYSQLHOST', 'localhost');/" > $DGS/include/config-local.php

# chgrp www-data $DGS/include/config-local.php
chmod 640 $DGS/include/config-local.php
cd $DGS

rm -rf /var/www/html
mv $DGS /var/www/html

mkdir -p /var/www/data-store /var/www/data-store/rss /var/www/data-store/wap  /var/www/data-store/wap
chmod 777 /var/www/data-store

chown -R root.root /var/www/html
chmod -R 755 /var/www/html/include/*
cd /var/www/html
mkdir translations && chmod 775 translations/ && cd scripts && php make_all_translationfiles.php

# cp -r $DGS/* /app
mysqladmin -uroot shutdown 
echo "apachectl start; mysqld_safe" > /go.sh
chmod +x /go.sh
