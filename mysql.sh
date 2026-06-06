#!/bin/bash

source ./common.sh

check_root()

echo "please enter DB Password:"
read -s mysql_root_password

dnf install mysql-server -y &>>LOGFILE
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>LOGFILE
VALIDATE $? "Enabling Mysql server"

systemctl start mysqld &>>LOGFILE
VALIDATE $? "Starting Mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>LOGFILE
# VALIDATE $? "Setting up root Password"

#Below code will be useful for idempotent nature
 mysql -h db.devopsvinay.online -uroot -p${mysql_root_password} -e 'show databases;' &>>LOGFILE
 if [ $? -ne 0 ]
 then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>LOGFILE
    VALIDATE $? "MYSQL Root Password Setup"
else 
    echo -e "Mysql Root Password is already setup...$Y SKIPPING $N"
fi