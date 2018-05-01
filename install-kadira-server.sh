#!/bin/bash
sudo adduser kadira
sudo usermod -aG sudo kadira
echo -e 'kadira ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/90-cloud-init-users
su - kadira
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y git nano mongodb-org nodejs
curl https://install.meteor.com/ | sh
sudo systemctl enable mongod
sudo systemctl start mongod
echo -e 'replication:\n  replSetName: "rs0"' | sudo tee -a /etc/mongod.conf
sudo systemctl restart mongod
mongo admin --eval 'rs.initiate({_id: "rs0", members:[{_id : 0, host : "localhost:27017"},]})'
mongo admin --eval 'rs.slaveOk()'
git clone https://github.com/giordanocardillo/kadira-server
cd kadira-server/kadira-rma
npm i --production
cd ../kadira-engine
npm i --production
cd ../kadira-ui
meteor npm r --save bcrypt
meteor npm i --save bcrypt
meteor npm i
cd ..
sudo cp kadira-rma.service /usr/systemd/system
sudo cp kadira-ui.service /usr/systemd/system
sudo cp kadira-engine.service /usr/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable kadira-rma
sudo systemctl enable kadira-ui
sudo systemctl enable kadira-engine
sudo systemctl start kadira-rma
sudo systemctl start kadira-ui
sudo systemctl start kadira-engine
