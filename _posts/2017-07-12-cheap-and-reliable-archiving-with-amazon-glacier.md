---
layout: post
title: "Cheap and reliable archiving with Amazon Glacier"
date: 2017-07-12
excerpt: How to make reliably archive your personal files with Amazon Glacier, a very cheap alternative to popular Dropbox and Google Drive backups
comments: true
tags: [backup, amazon, glacier, english]
eye_catch: https://blog.guilhermegarnier.com/images/glacier.jpg
---
Incidents like [WannaCry ransomware](https://en.wikipedia.org/wiki/WannaCry_ransomware_attack) expose the importance of doing backups, which is usually forgotten by many people.

When someone talks about backing up our personal files, we usually think about services like [Dropbox](https://www.dropbox.com) and [Google Drive](https://drive.google.com). But they have a reasonable cost if you have more than a couple of GB of data. There are a lot of other solutions available. Most of them are cheaper, but not always reliable - imagine if you backup all your personal data to a small and unknown service, and a few months later, the company breaks. Or a security flaw exposes all your personal data! Of course this could also happen with Dropbox and Google Drive, but it's much less likely, being two large and serious companies.

One alternative to them is [Amazon Glacier](https://aws.amazon.com/glacier/). It's a not so popular Amazon service for data archiving. You should notice it works differently from the usual backup solutions. When you sign up to Dropbox, for instance, you can install an app to your computer or mobile phone, or use the web interface to instantly access your files and upload new ones. Glacier is much more low level. It doesn't have a web interface, app or even command line tool! There's only an API, which you use to check your files, download or upload.

And there's more: the download and upload rates are very slow. And to download a file, you first have to ask for a file retrieval job; the download will be available in a couple of hours!!!

This seems like a terrible service, so why use it? Because it's very, very cheap! You only pay US$ 0.004 per GB per month for storage, besides [additional costs](https://aws.amazon.com/glacier/pricing/) for requests. And even being slow and hard to use, it's a service offered by Amazon, which gives you confidence it won't suddenly disappear.

Having said that, Glacier isn't a service to keep data you may need immediately. But it's ideal for something you probably won't need to access anytime soon. Think about your family pictures: when you want to access them, you probably doesn't need them right away; you're fine waiting a couple of hours for that.

Glacier is also a great option for "backups of backups". If you want to be neurotic about backups (and you should!), you can archive a copy of your backups there.

## Usage

The easiest way to use Glacier is with a third party client. I like [amazon-glacier-cmd-interface](https://github.com/uskudnik/amazon-glacier-cmd-interface). After setting up the basic configuration, you can create a vault and upload you files:

```
glacier-cmd mkvault my-disaster-backup
glacier-cmd upload my-disaster-backup my-file1 my-file2 ...
```

To list archives in a vault:

```
glacier-cmd inventory <vaultname>
```

The inventory retrieval job takes a couple of hours to be processed. You can check its status with:

```
glacier-cmd listjobs <vaultname>
```

And to download a file:

```
glacier-cmd download <vaultname> <filename>
```
