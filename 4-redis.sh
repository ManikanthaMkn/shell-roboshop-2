#!/bin/bash

source ./0-common.sh
app_name=redis

check_root


dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling the Redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling the Redis version 7"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "Installing the Redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Edited redis.conf to accept remote connections"

# sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
# VALIDATE $? "Editing Redis conf file for remote connection"

# sed -i 's/yes/no/g' /etc/redis/redis.conf
# VALIDATE $? "Editing Redis conf file for remote connection"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "Enabled the Redis services"

systemctl start redis &>>$LOG_FILE
VALIDATE $? "Started the Redis services"

print_time