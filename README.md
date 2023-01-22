# The Integrative website

Hey Integrative, You found one of my repositories. This is mostly a readme for myself to get up and running. Let's get into it.

## Getting started

This particular setup is created with [hugo](https://gohugo.io/) and [obsidian](https://obsidian.md/).

Github:
```shell
git clone git@gitlab.com:theintegrative/theintegrative-net.git
```

Gitlab:
```shell
git clone git@github.com:theintegrative/theintegrative.net.git
```
First time in obsidian:
1. Open folder as fault
2. Select the content folder

Other times: (CLI ubuntu)
```shell
obsidian obsidian://open?vault=content &
```

## Local development
```shell
obsidian obsidian://open?vault=content &
hugo server
firefox http://localhost:1313/
```

## Pushing to website (gitlab ci/cd pipeline)
```shell
git push upstream
```
