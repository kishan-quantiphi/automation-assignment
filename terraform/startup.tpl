#!/bin/bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y mariadb-server
mysql -u kishandb -p${db_password} -h ${endpoint} -P 3306 -D myDB --execute='CREATE TABLE IF NOT EXISTS kishantable(`id` INTEGER PRIMARY KEY AUTO_INCREMENT,`name` VARCHAR(100))'
mysql -u kishandb -p${db_password} -h ${endpoint} -P 3306 -D myDB --execute='INSERT INTO todos (`name`) VALUES("kishan")'
mysql -u kishandb -p${db_password} -h ${endpoint} -P 3306 -D myDB --execute='SELECT * FROM kishandb' > /home/ec2-user/output.txt