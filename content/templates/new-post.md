---
title: 
description: 
slug: 
date:  <% tp.file.last_modified_date("YYYY-MM-DD HH:mm:ss") %>
image: cover.jpg
categories:
    - -new
tags:
    - 
---
<% tp.file.rename("index") %>
<% tp.file.move("/post/new/index") %>
