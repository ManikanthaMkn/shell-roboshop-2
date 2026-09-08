#!/bin/bash

source ./0-common.sh
app_name=mongodb

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Replicating MongoDB Repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing MongoDB Server"

systemctl enable mongod &>>$LOG_FILE
systemctl start mongod 
VALIDATE $? "Enable and Start the MongoDB Server"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Editing MongoDB conf file for remote connection"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting MongoDB"

print_time