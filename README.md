# sentry-sample deployment with Terraform
This repository contains the automation scripts to setup a Sentry environment running in Docker.
The sample will create the following components:
1. Sentry Website
1. Sentry Service (cron)
1. Sentry worker (1)
1. Redis
1. Postgres DB

## Pre-reqs
The scripts have been tested in the following environment:
1. Ubuntu 16.04 Xenial LTS
1. Provisioned with at least 2 vCPU and 4 GB Memory
1. User needs to be a sudoer

## Quick steps
On a bash terminal in your environment run the following commands to stand up the service

```bash
cd ~
git clone https://github.com/rafamunozg/sentry-sample.git
cd sentry-sample
./init/docker.sh
su -l $USER
cd sentry-sample
./init/terraform.sh
cd terraform
terraform init
terraform apply -auto-approve
```
*If prompted, respond with yes and hit enter*

## Step by step and some troubleshooting

### Initialize the environment

1. Clone this repository on a VM with Ubuntu 16.04 Xenial Xerus
  
`git clone https://github.com/rafamunozg/sentry-sample.git`
 
_If Git is missing, follow the recommendation to install it, or simply use:_
  
`sudo apt-get install -y git `
  
Then try to clone the repository again ... it should work this time.
  
2. cd into the sentry-sample folder

`cd sentry-sample`

3. Install Docker

`./init/docker.sh`

4. login again as yourself for the group permissions to be picked up

`su -l $USER`

5. cd into the proper folder and install Terraform

```bash
cd sentry-sample

./init/terraform.sh
```

6. cd into the terraform folder and run the appropriate scripts

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

7. At the end of the execution, you will receive the information needed to login to the site
    * URL 
    * User
    * Password 

8. Login and provide the final setup info required and you'll get access to your Sentry service

* If errors occur, please report them and I'll get them fixed

## Next steps
1. Split sensitive data into a security controlled .tfvars file
1. Deploy these containers on ECS cluster
1. Split code in nodes: Postgres, Redis should be their own nodes
1. Add a couple of workers to the cluster
1. Deploy a sample Flask application to see Sentry in action
