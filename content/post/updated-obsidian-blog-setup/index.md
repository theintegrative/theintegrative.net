---
title: Updated obsidian blog setup
description: In the recent months I've been getting a lot of experience in the IT industry. I've landed the job I wanted as linux DevOps engineer. So now with my new skills, it is time to give you an update on my blog.
date:  2023-01-24 19:19:41
image: cheng-feng-obsidian.jpg
categories:
    - Projects
tags:
    - obsidian
    - hugo
    - gitlab
---

I wish you a happy new year!  The first month (almost!) went by like nothing. The good news is that I plan to create a lot more content about things that hopefully interest you too. This year's theme is all about awakening creativity. Enough about that, I love to talk about that more "here" in the future. 

## Key lesson learned
It is always good to go over the lessons you have learned. My main goal was to get better at writing good content. With that skill also be able to get my ideas and insights as quickly as I can online. One goal that I proposed to myself was writing minimally one post a week.

As you see that didn't happen. Persistence, especially for goals you have a hard time integrating will have a good effect when used wisely.

Why didn't it happen?
- Too much friction in the process of pushing updates to my website
- Not coding or engineering enough projects
- Not enough structure in my content vault in obsidian
- Site design didn't inspire me to work on it (yes, I will explain :) 
- Insecurities about exposing ideas
- Actually, getting settled at your new job

### Reduce friction

Creating a new post inside obsidian was a lot of metadata, that I manually copied. I reduced that with the [templater plugin](https://github.com/SilentVoid13/Templater) for Obsidian.  I use the markdown editor every day and will share the things I create and learn using it.

Also, there were many redundant sections on the website that I didn't use. This created a false expectation that I needed to somehow fill this gap. Sound familiar? Well, that needed to change. I decided to switch the Hugo theme to one that is minimal. It only uses the things that I want to create. 

Pushing the website to github, testing, generating, and deploying the website were too many steps and failed a lot. Many things were manual that needed to be automated. It is easy to over-engineer when you just want an open-source combination of tools that can publish content on your website.

Coding every day by being assertive with your craft reduces a lot of friction. What also helped is doing type training for 15 minutes every day. If you were to approach coding as an entrepreneur would inside a virtual machine that is built in a test environment. That is the mental state I am describing. I love IT. 

## The more technical part

You maybe expected the technical part.

I use Hugo as the website generator. For content creation and management I use obsidian with its community plugins for example templater. Github for version control that is publicly available [here](https://github.com/theintegrative/theintegrative.net) and Gitlab as a pipeline to deploy the website to my web server. The server runs an Nginx Certbot container using docker-compose.

The steps for working on my website are easy. 

First I need to navigate to the folder where my website is and run these commands:
```shell
obsidian obsidian://open?vault=content &
firefox http://localhost:1313/
hugo server
```
> This assumes you already opened the folder "content" as vault the first time in obsidian

This opens the vault named content using the obsidian [uri](https://help.obsidian.md/Advanced+topics/Using+obsidian+URI), which are commonly used for cross-app automation workflows like these.  After that, open Firefox on localhost where the  `Hugo server` will start your development site.  

From there I create my website inside obsidian and check how it is being displayed. If I am done with writing then I want to get it online. 

When I am inside the website repository, I will do this:
``` shell
git add content/post/example
git commit -m "Definitely subscribe and learn from the integrative"
hugo
git push
git push upstream
```

The Hugo command generates the website so that I can use it with my Nginx webserver. Git push upstream is the second remote added that goes to my Gitlab project pipeline. 

## Closing thoughts
I am very motivated to create more. There are some things to say about persistence in combination with simplicity and patience. These things will be said in practice and words in the coming year because for me it seems exciting to share this journey with you all.