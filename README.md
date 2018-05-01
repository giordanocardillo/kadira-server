# Disclaimer
This repository is a fork of [lampe/kadira-server](https://github.com/lampe/kadira-server)


## What's this for
This repo aims to make a 'ready-to-deploy' kadira server on an EC2 Ubuntu 16.04 instance.

## How to use?
1. Create a new EC2 Ubuntu 16.04 server
2. SSH-in
3. `git clone https://github.com/giordanocardillo/kadira-server`
4. `cd kadira-server`
5. `./install-kadira-server.sh`

The script will install three services and MongoDB 3.4:
1. kadira-ui (listens on port 4000)
2. kadira-rma
3. kadira-engine (listens on port 11011)

The default administrator user is `kadira@kadira.com` with password `kadira`


## Troubleshooting

**Q.** The UI is stuck in "loading..." state (Red loading labesl everywhere)

**A.** `sudo systemctl restart kadira-ui`

