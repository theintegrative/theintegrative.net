---
title: How I setup this self-hosted markdown website using docker, hugo and obsidian
description: I am going to breakdown in this post how I setup this self-hosted website.
image: picture-this-blog.jpg
categories:
  - Projects
tags:
  - docker
  - hugo
  - scripting
  - git
  - nginx
  - certbot
  - ubuntu
  - vim
  - obsidian
date: 2022-08-20 16:25:37
---

Hey, integrative! I am going to breakdown in this post how I setup this self-hosted website.  We all have to start somewhere. Happy to take you with me on my public learning journey.

## TL;DR

I created a few content management scripts that automate development with hugo and obsidian. It generates the website, makes a backup before it deploys the new website into production by restarting the nginx-certbot container with the new content. You can get code from this [repository](https://github.com/theintegrative/hugo-depoyment). Updates will follow.

## Foreword

For explanatory reasons I've filtered out irrelevant files and folders so that we can focus on the automation that is important. To see the files that are ignored go [here](https://github.com/theintegrative/theintegrative.net). In this breakdown I will not go into detail about how I configured my nginx-certbot.

## Software used in this project

- Obsidian - Markdown editor
- Vim -  Text editor
- Shell Scripting
- Docker - Containerisation
- Hugo - Static Website Generator
- Ubuntu Desktop + Ubuntu Server
- Nginx - webserver
- Git - version control
- Certbot - automates Let's encrypt certificates for security through https

## The development environment my machine

Let's take a look by listing these scripts in a tree like format:

```bash
integrative@home:~/website/hugo/doks$ tree
.
├── backups
│   └── backup.sh
├── development.sh
└── production.sh

1 directory, 3 files
```

We start by developing our website.

This is what the script development.sh contains inside:

```bash
#! /bin/bash

# Start your browser
brave-browser http://localhost:1313/

# With flatpak start obsidian and open the vault "en" 
# that is the content folder through the obsidian URI in the background
flatpak run md.obsidian.Obsidian obsidian://open?vault=en &

# Starting development server with hugo doks theme for more https://getdoks.org/ 
# For hugo use: hugo server
npm run start
```

Running development.sh will give me an open browser and markdown editor. From there I can start writing blog posts like this. In a future post I will show you more on workflows, setting up obsidian and more. When done, I simply do Ctrl-C that shuts down the running server. Then commit it to the repository.

Now, we are going to take a look into the production.sh file:

```bash
#! /bin/bash

# first check for updates
npm update

# build the website
npm run build

# make backup of the production site before deployment
bash ./backups/backup.sh

# update files
rsync -ruzv --delete ./public/ theintegrative.net:/home/integrative/public/

# restart docker container with new files
ssh theintegrative.net "docker-compose down --remove-orphans && docker-compose up -d"

# start up browser of choice, to see the results
brave-browser https://theintegrative.net/
```

Here there are two things we are going to focus on in order to explain them both.

We take backup.sh first:

```bash
#! /bin/bash

DATE=`date +%Y-%m-%d_%H`
remote='theintegrative.net:~/public/'
destination="~/website/hugo/doks/backups/backup_${DATE}/"

# check if backup folder does not exist, create it and sync files in archive mode 
if [[ ! -d ${destination} ]]
        then
                echo "Create directory ${destination}"
                mkdir -p ${destination}
fi
rsync -rauz --delete ${remote} ${destination} && echo "Succes!" || echo "Failure"
```

As you can see here this script checks if the folder for this hour does not exist and if it does updates it. This is a good solution to begin with. But as workloads will increase so will the demand for a more elegant solution. Updates on that solution will apear in this [repository](https://github.com/theintegrative/hugo-depoyment).

Next I will expain shortly what the flags mean within rsync:

- -a archive
- -z compress file data during the transfer
- -r recurse into directories
- -u skip files that are newer on the receiver
- -v increase verbosity
- --delete deletes files from the destination directory that do not exist in the source directoy

After backing up and pushing the new site with rsync, the docker container wil be restarted using docker-compose.  In the next part we will go over it quickly before closing this post.

## The production environment on my server

The nice thing about docker files is that's very readable and explains a fair bit by itself. The internal configurations of the nginx-certbot container will not be covered here.

This is what the folder looks like on the server:

```bash
integrative@theintegrative.net:~/$ ls
Dockerfile  conf.d  docker-compose.yaml  nginx-certbot.env  nginx_secrets  public
```

Dockerfile

```dockerfile
FROM jonasal/nginx-certbot:latest
COPY conf.d/* /etc/nginx/conf.d/
```

With the Dockerfile you pull the latest jonasal/nginx-certbot container from the docker.io hub and copy over the nginx configuration files in the correct directory.

For that I will manually use this command:

```bash
sudo docker build -t jonasal/nginx-certbot:site .
```

Definitely check for a stable version before using a container like this one. If you are not sure, increment a number after your build tag.

Like this for instance:

```bash
sudo docker build -t jonasal/nginx-certbot:site-0 .
```

docker-compose.yaml

```yaml
version: '3'

services:
  webserver:
    image: jonasal/nginx-certbot:site
    restart: unless-stopped
    ports:
      - 80:80
      - 443:443
    volumes:
      - nginx_secrets:/etc/letsencrypt
      - ./public/:/usr/share/nginx/html:ro
    environment:
      - CERTBOT_EMAIL=example@example.com
    env_file:
      - ./nginx-certbot.env

volumes:
  nginx_secrets:
```

Here you see this docker-compose file will use the container that you created and runs the image stored from the local repository. It will restart unless manually stopped. It also binds the volumes to the container from local storage and uses the environment variables given to it.

## Closing thoughs

This I my first time writing a technical document like this. So feedback is much appreciated. Stay tuned for more integrated in the future.
