#!/bin/bash/

source ./0-common.sh
app_name=shipping

check_root
echo "Please enter the root passowrd to srtup"
read -s MYSQL_ROOT_PASSWORD

app_setup
maven_setup
systemd_setup

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing MySQL"

mysql -h mysql.arohvya.online -u root -p$MYSQL_ROOT_PASSWORD -e 'use cities' &>>$LOG_FILE  #While writing this script I forgot to mention "$" in front of MYSQL_ROOT_PASSWORD after checking lot of things, then after I become calmly I checked each line and I found
if [ $? -ne 0 ]
then
    mysql -h mysql.arohvya.online -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h mysql.arohvya.online -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql &>>$LOG_FILE
    mysql -h mysql.arohvya.online -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "Loading data into Database"
else
    echo -e "Data is already loaded into MySQL ... $Y Skipping $N"
fi

systemctl restart shipping
VALIDATE $? "Restart the Shipping"

print_time