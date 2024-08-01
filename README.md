# Sparsh Ramchandani Portfolio with DevOps ([sparshramchandani.me]([url](https://sparshramchandani.me/)))
This repository contains the code and infrastructure setup for my portfolio website. The website is built using Next.js for the frontend and is deployed on Google Kubernetes Engine (GKE) clusters. 

## Overview

- **Frontend Framework:** Next.js
- **Containerization:** Docker
- **Cloud Provider:** Google Cloud Platform (GCP)
- **Infrastructure as Code:** Terraform
- **Kubernetes Management:** Helm
- **CI/CD:** GitHub Actions
- **Domain:** Namecheap
- **SSL Certificate:** ZeroSSL

## Getting Started

### Prerequisites

- Docker
- Google Cloud SDK
- Terraform
- Helm
- Node.js
- Git

### Clone the Repository

```bash
git clone https://github.com/sparshramchandani-NEU/portfolio-devops.git
cd portfolio-devops
```

## Test on local machine
```bash
npm init
npm i
npm run dev
```
You app should be running on localhost:3000

## Building and pushing the docker image to the Google Artifact Registry
- ** Create/ Login to [Google Cloud]([url](https://cloud.google.com/)) account
- ** Create a new project on the console
- ** Copy the project id and run the following commands
```bash
gcloud auth login                                      
gcloud config set project (YOUR_PROJECT_ID}
```

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t {SELECTED_REGION}-docker.pkg.dev/{YOUR_PROJECT_ID}/{IMAGE}:latest --output type=registry .
```

## Setting up the Google Cloud
- Get your domain name from [Namecheap]([url](https://www.namecheap.com/))/ [Godaddy]([url](https://www.godaddy.com/)) or any domain providers
- Create your [Hosted Zone]([url](https://cloud.google.com/dns/docs/zones)) n Google Cloud
- Copy the NS records to your domain providers. (I used [Namecheap]([url](https://www.namecheap.com/support/knowledgebase/article.aspx/434/2237/how-do-i-set-up-host-records-for-a-domain/)))
- Get an SSL certificate (I used [ZeroSSL]([url](https://zerossl.com/)) for my SSL certificate)
- Download your certificate
- Follow the steps listed on [this page]([url](https://help.zerossl.com/hc/en-us/articles/360058295994-Installing-SSL-Certificate-on-Google-App-Engine)).
- Done installing? Click Check Installation to see if your installation was successful.

## Setting up the infrastructure using terraform
```bash
terraform init
terraform apply -auto-approve
```

#Authors
[Sparsh Ramchandani]([url](https://www.linkedin.com/in/sparsh-ramchandani))
