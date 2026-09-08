#!/bin/bash/

source ./0-common.sh
app_name=rabbitmq

check_root

echo "Please enter the RabbitMQ passowrd to startup" #The password should be "roboshop123"
read -s RABBITMQ_PASSWD

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Adding rabbitmq repo"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing RabbitMQ"

systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Enabling RabbitMQ"

systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Starting RabbitMQ"

rabbitmqctl add_user roboshop $RABBITMQ_PASSWD &>>$LOG_FILE  #roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE

print_time