---
title: How my main driver is setup with ansible
description: >-
  Learning happens when stuff breaks. That is when you learn the importance of
  making backups frequently. From recovering and fixing systems you will get
  very comfortable using the commandline
date: 2022-09-21T16:27:15
image: ansible-main-driver-playbook.jpg
categories:
  - Projects
tags:
  - automation
  - ansible
  - devops
---

Welcome back again! This time learned a new tool called Ansible and want to share it with you.  Maybe you want to integrate it into your process? Let's dive in!

## Introduction

Learning happens when stuff breaks. That is when you learn the importance of making backups frequently. From recovering and fixing systems, you will get very comfortable using the command line.

This eventually will become an obstacle that will cost you. You want to be resilient and quickly get your system "back up" when it goes down. Maybe you don't have that fresh ISO of fedora that you like. But you have a portable drive with openSUSE on it. Ansible makes this and more very easy to set up and configure.

As you develop your skills, the need for automation increases with the complexity. This in turn creates more space to transfer your experience and behavioral skills to a more advanced level.

## What I am using right now

```bash
me@home-lab 
---------------- 
OS: Ubuntu 22.04.1 LTS x86_64 
Host: 80E5 Lenovo G50-80 
Resolution: 1920x1080 
CPU: Intel i5-5200U (4) @ 2.700GHz 
GPU: Intel HD Graphics 5500 
Memory: 2748MiB / 3838MiB                                                                                       
```

## Installing the requirements

This assumes you have a fresh install, in this case Ubuntu desktop.

- Python3
- Pip
- Ansible

If you already have these installed, skip [here](#reconfiguring-my-main-driver)

### Steps

First install pip using apt:

```bash
sudo apt install python3-pip
```

Next install Ansible using pip

```bash
pip3 install ansible
```

Check if the installation was successful

```bash
ansible --version
```

Now you are ready to go use Ansible and its tools.

## (Re)configuring my main driver.

This playbook is executed against a fresh installation of Ubuntu desktop 22. There will be updates following in the future when I set up my server lab environment.  From there, I will be testing variations and conditions that will be added to the [playbook here](https://github.com/theintegrative/main-driver-setup).

Let's take a look at the configure-main.yml file:

```yaml
---
- hosts: localhost

  tasks:
  - name: Install the packages that you mainly use with the available package manager
    package:
      name:
       - keepassxc
       - vim
       - remmina
       - sudo
       - tmux
       - nmap
       - neofetch
       - imagemagick
       - docker.io
       - obs-studio
       - virt-manager
       - ansible
       - python3-pip
       - flatpak
       - git
      state: latest
  
  - name: Install python-pip packages
    pip:
      name:
        - docker
        - docker-compose
        - ansible

  - name: Add the flathub flatpak repository remote for current user
    flatpak_remote:
      name: flathub
      state: present
      flatpakrepo_url: https://flathub.org/repo/flathub.flatpakrepo
      method: user
  
  - name: Install the obsidian package from flathub for current user
    flatpak:
      name: md.obsidian.Obsidian
      state: present
      method: user
```

You can describe the state how you want your infrastructure to be in. Because of that, the YAML file is very easy to read for everyone. Even those that are not, or are becoming technical.

This is the command to run the playbook:

```bash
me@home-lab: ansible-playbook configure-main.yml -b -K
```

Ansible is agentless. This means that execute a playbook against an array of remote servers without having to install it on those.

Now I will explain shortly what the flags mean within ansible-playbook command:

- -b run operations as this user you become (default is root)
- -K ask for privilege escalation password of the user you become

You will be asked to fill in the password -K of become with the -b flag, that is root by default. Then create the state on the machine that you described in your play as "localhost".

## Closing thoughts

Now you have a playbook that you can get [here](https://github.com/theintegrative/main-driver-setup) from the git repo. Edit it how you like it and quickly set up your own setup within a few moments. Learning and using Ansible is a valuable in your Linux DevOps engineering tool and skill set.
