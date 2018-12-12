# sentry-sample repository
This repository contains the automation scripts to setup a Sentry environment running in Docker.
The sample will create the following components:
1. Sentry server
1. Sentry workers (2)
1. Python application using Sentry (Flask)

## Quick steps
On a bash terminal run the following commands to init the environment

```bash
cd ~
git clone https://github.com/rafamunozg/sentry-sample.git
cd sentry-sample
./init/docker.sh
su -l $USER
cd sentry-sample
./init/terraform.sh
```

## Now step by step and some troubleshooting
### Initialize the environment

1. Clone this repository on an Ubuntu 16.04 Xenial Xerus
  
`git clone https://github.com/rafamunozg/sentry-sample.git`
  
> _If Git is missing, follow the recommendation to install it, or simply use:_
  
`sudo apt-get install -y git `
  
Then try to clone the repository again ... it should work this time.
  
1. CD into the sentry-sample folder

`cd sentry-sample`

1. Install Docker

`./init/docker.sh`

1. Install Terraform

`./init/terraform.sh`

...
