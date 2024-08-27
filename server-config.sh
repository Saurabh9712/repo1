#! /bin/bash

sudo yum install git -y
sudo yum install maven -y
sudo yum install java-1.8.0-openjdk-devel -y 

if [ -d "repo1" ]
then
   echo "repo is already cloned and exists"
   cd /home/ec2-user/repo1
   git pull origin c1
else
   git clone https://github.com/Saurabh9712/repo1.git
   cd repo1
   git checkout c1
fi

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-1.amzn2.0.1.x86_64
export PATH=$JAVA_HOME/bin:$PATH
source /etc/profile
mvn package
