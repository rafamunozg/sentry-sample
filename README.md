# sentry-sample repository
This repository contains the automation scripts to setup a Sentry environment running in Docker.
The sample will create the following components:
1. Sentry server
1. Sentry workers (2)
1. Python application using Sentry (Flask)

## Quick steps
1. Initialize the environment (Bash scripts provided)

  1. Clone this repository on an Ubuntu 16.04 Xenial Xerus
  
  `git clone https://github.com/rafamunozg/sentry-sample.git`
  
  _If Git is missing, follow the recommendation to install it, or simply use:_
  
  `sudo apt-get install -y git `
  
  Then clone the repository with the instruction
  
  1. CD into the sentry-sample folder
  `cd sentry-sample`
  1. Install Docker
  `./init/docker.sh`
  1. Install Terraform
  `./init/terraform.sh`

...
