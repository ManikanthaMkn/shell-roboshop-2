#!/bin/bash

source ./0-common.sh
app_name=frontend

dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "Disabling default Nginx"

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "Enabling Nginx version:1.24"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing Nginx"

systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE
VALIDATE $? "Starting the Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "Removing the default content for Nginx"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
VALIDATE $? "Downoading the Forntend Content"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "Unzipping the Frontend file"

rm -rf /etc/nginx/nginx.conf
VALIDATE $? "Remove Nginx default conf content"

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Replicating nginx.conf"

systemctl restart nginx
VALIDATE $? "Restarting the Nginx"

print_time