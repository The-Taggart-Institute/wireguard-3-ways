---
title: Wireguard 3 Ways
description: Cooking up Security in a Surveillance State
author: Michael Taggart
theme: default
class:
  - invert
paginate: true
style: |
  p:has(>img) {
    text-align: center;
  }
headingDivider: 1
---

# Wireguard 3 Ways

**Cooking up Security in a Surveillance State**

**Michael Taggart**

![width:30px](https://www.pinclipart.com/picdir/big/16-161177_big-image-mastodon-red-social-logo-clipart.png) @mttaggart@infosec.exchange
![width:30px](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Bluesky_Logo.svg/600px-Bluesky_Logo.svg.png) @taggart-tech.com

15 August 2025

Hackers on Planet Earth
Queens, New York, NY, USA

# Whoami

- Michael Taggart
  - Just call me Taggart
- Senior Cybersecurity Researcher at UCLA Health

![width:250px](uclah_logo.png)

- Founder of The Taggart Institute
  - We make low-cost, high-value tech training
  - taggartinstitute.org

![width:100px](logo.png)

# Learning Objectives: Skills

By the end of this workshop, participants will be able to:

- Create Wireguard peers and servers
- Establish Wireguard networks across NAT boundaries

# Learning Objectives: Concepts

By the end of this workshop, participants will understand:

- Wireguard tunnel design
- Wireguard asymmetric cryptography usage
- Wireguard networking strategies
- Basic mesh networking principals

# Prerequisites

- Command line comfort is a plus
- Basic networking (IP addresses, subnets)

# Materials

- A computer (the kind with a keyboard)
  - Web browser
  - SSH Client (Windows has one, don't worry)
  - Tailscale (https://tailscale.com/download)
- If you want to run it all yourself:
  - Zellij (https://zellij.dev)
  - Podman (https://podman.io)
    - Must be v5.0+
  - Windows: strongly recommend using the managed lab
    - Or another VM you have!

# Not-Free Stuff

The end of the workshop has an optional paid component: you setting up your own server for private networking!

This requires:

- A cloud VM (AWS, Azure, Digital Ocean, Hetzner, Vultr)
- A domain name (Namecheap, Porkbun)


# The Book

### https://w3w.taggartinstitute.org

# Joined Matrix?

- Cinny >>> Element: https://app.cinny.in
- I'm `@taggart:taggart.social`
- We have a Room!
- DMs will be useful in a bit

# Today's Agenda

1. About Wireguard
2. Why use it?
3. Lab setup
4. Break
4. Recipe 0: A Simple Mesh
5. Recipe 1: The Lighthouse
6. Recipe 2: Lightouse + Subnet Router
7. Recipe 3: Coordinated Mesh with Headscale
8. Break
9. Going Live: Your Own Headscale Server


# About Wireguard

![](wireguard.png)

# Why Use Wireguard?

- Trust and Risk
- What is the Threat Model
- The Wireguard Value Proposition:
  - Simplicity
  - Ubiquity
  - Performance
  - Cryptography
- Fun

# Lab Setup: Managed Lab

1. Install Tailscale
2. Don't use the GUI, Windows people!

```bash
tailscale login --login-server=https://hs.taggartinstitute.org
```

3. Visit the URL you see
4. Send me a Matrix DM with the `--key` value
5. Save the `key`. It's now a password for something
5. I send you a username
6. `ssh $username@hope-w3w`
7. Welcome to the lab!

# Lab Setup: BYO

1. Podman (and `podman-compose`, *Nix people) installed.
2. Git installed
3. Zellij Installed
4. `git clone https://codeberg.org/The-Taggart-Institute/wireguard-3-ways`
5. `cd wireguard-3-ways`

# Break

# Recipe 0: A Simple Mesh

# Recipe 1: The Lighthouse

# Recipe 2: Lightouse + Subnet

# Recipe 3: Coordinate Mesh

# Break

# Going Live

## Your Personal Private Networking Server

# Thank you!

## Questions?

![width:30px](https://www.pinclipart.com/picdir/big/16-161177_big-image-mastodon-red-social-logo-clipart.png) @mttaggart@infosec.exchange
![width:30px](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Bluesky_Logo.svg/600px-Bluesky_Logo.svg.png) @taggart-tech.com
