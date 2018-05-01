#!/bin/bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nano mongodb-org nodejs
curl https://install.meteor.com/ | sh
sudo systemctl enable mongod
sudo systemctl start mongod
echo -e 'replication:\n  replSetName: "rs0"' | sudo tee -a /etc/mongod.conf
sudo systemctl restart mongod
cd kadira-rma
npm i --production
cd ../kadira-engine
npm i --production
cd ../kadira-ui
meteor npm i
meteor npm r --save bcrypt
meteor npm i --save bcrypt
cd ..
mongo admin --eval 'rs.initiate({_id: "rs0", members:[{_id : 0, host : "localhost:27017"},]})'
mongo admin --eval 'rs.slaveOk()'
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'1min',provider:'methods',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'1min',provider:'errors',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'1min',provider:'pubsub',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'1min',provider:'system',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'3hour',provider:'methods',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'3hour',provider:'errors',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'3hour',provider:'pubsub',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'3hour',provider:'system',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'30min',provider:'methods',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'30min',provider:'errors',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'30min',provider:'pubsub',shard:'one'}})"
mongo kadiraData --eval "db.mapReduceProfileConfig.insert({lastTime: new Date(), _id:{profile:'30min',provider:'system',shard:'one'}})"
sudo cp kadira-rma.service /lib/systemd/system/kadira-rma.service
sudo cp kadira-ui.service /lib/systemd/system/kadira-ui.service
sudo cp kadira-engine.service /lib/systemd/system/kadira-engine.service
sudo systemctl daemon-reload
sudo systemctl enable kadira-rma
sudo systemctl enable kadira-ui
sudo systemctl enable kadira-engine
sudo systemctl start kadira-rma
sudo systemctl start kadira-ui
sudo systemctl start kadira-engine
