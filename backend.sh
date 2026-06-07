#!/bin/bash
source ./common.sh

#check_root

echo "please enter DB Password:"
read -s mysql_root_password

# dnf module disable nodejs -y &>>$LOGFILE


# dnf module enable nodejs:20 -y &>>$LOGFILE


# dnf install nodejs -y &>>$LOGFILE

# id expense &>>$LOGFILE
# if [ $? -ne 0 ]
# then
#     useradd expense &>>$LOGFILE
    
# else
#     echo -e "Expense user already created...$Y SKIPPING $N"
# fi

# mkdir -p /app &>>$LOGFILE


# curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE


# cd /app
# rm -rf /app/*
# unzip /tmp/backend.zip &>>$LOGFILE


# npm install &>>$LOGFILE


# cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE


# systemctl daemon-reload &>>$LOGFILE


# systemctl start backend &>>$LOGFILE


# systemctl enable backend &>>$LOGFILE


# dnf install mysql -y &>>$LOGFILE


# mysql -h db.devopsvinay.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE



# systemctl restart backend &>>$LOGFILE

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling nodejs"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Installing nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>LOGFILE
VALIDATE $? "Downloading backend code"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracted backend code"

npm install &>>$LOGFILE
VALIDATE $? "Installing nodejs dependencies"

cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Starting backend"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling backend"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing Mysql client"

mysql -h db.devopsvinay.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restart backend"



