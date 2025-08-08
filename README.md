# Wireguard 3 Ways: Cooking Up Security in a Surveillance State

This repository contains instructions and support files for the [HOPE](https://hope.net) workshop.

## Learning Objectives

We break learning objectives into **Skills** and **Concepts**.

### Skills

By the end of this workshop, participants will be able to:

- Create Wireguard peers and servers
- Establish Wireguard networks across NAT boundaries

### Concepts

By the end of this workshop, participants will understand:

- Wireguard tunnel design
- Wireguard asymmetric cryptography usage
- Wireguard networking strategies
- Basic mesh networking principals

## Requirements

### Technical Requirements

This workshop uses [Podman](https://podman.io) for its demonstrations. It can be installed on Linux, Windows or macOS. On Windows, Podman Desktop will require either [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) or Hyper-V to virtualize a small Linux kernel. We will also use Podman Compose, which is a package install for Linux, but [Podman Desktop](https://podman-desktop.io/docs/compose) can support this function as well.

The workshop will also use [Zellij](https://zellij.dev) for easy terminal control of the containers. If not participating with the provided resources, I recommend installing it.

The containers will have several terminal-based text editors installed (Vim, Nano, Helix) to suit your preference. But you will be editing text in the terminal.

### Prerequisites

Familiarity with the Linux command line will be extremely helpful in this workshop. As will familiarity with basic networking concepts such as subnets and firewall rules.

## Usage

Here are provided 3 "recipes" for creating Wireguard networks, in increasing complexity—and utility. Each is comprised of [Podman](https://podman.io) containers, networked together. They can be run on any platform that Podman supports, but for the HOPE workshop, a cloud VM will be provided for participants.

## The Recipes

I know it says "3 ways" on the box, but actually we need to start with a fundamental dish before moving on to the real recipes.

### 0. A Simple Mesh

In this recipe, all our peers live on the same network. That could make Wireguard redundant, but it will establish an additional layer of encryption on top of all peer-to-peer communications. This recipe is more about learning the concepts of Wireguard configurations. Each peer connects to every other peer via manual point-to-point connections. This works, but doesn't exactly scale.

### 1. The Lighthouse

If we want to connect multiple hosts across networks, but we don't want to open inbound ports, we need to use a public server that all our peers can see. This "lighthouse" server will be the one to which all the others connect.

### 2. The Lighthouse + Subnet Router

What if we want access to an entire home network without wanting to configure Wireguard on all of those devices? That's where "subnet routers" come in. This configuration allows a (Linux) Wireguard host to provide access to its neighbors through the Wireguard tunnel.

### 3. The Coordinated Mesh

One of the shortcomings of the "lighthouse" model is that the lighthouse becomes a termination point for the Wireguard encrypted tunnel. If we have doubts about our cloud service provider, then any otherwise unencrypted traffic may be sniffed with access to this server. But we need a central point that everyone can see to guarantee connection. How to square this circle?

[Tailscale](https://tailscale.com) solves this problem by using multiple strategies to show peers how to connect, and then allows the peers to connect directly to each other, eliminating the machine-in-the-middle. And it's all built on top of Wireguard, so you get the same security with much less hassle.

But Tailscale is a cloud service. So suppose you didn't want to entrust your data there either? Luckily, the core of Tailscale is open source—both client daemon and server. [Headscale](https://headscale.net) is a way to self-host a Tailscale server and network. The setup for Headscale is *considerably* easier than raw Wireguard.

## How to Use This Repo



## Instructions

See individual folders for specific instructions

- [Recipe 0](./recipe-0/README.md)
- [Recipe 1](./recipe-1/README.md)
- [Recipe 2](./recipe-2/README.md)
- [Recipe 3](./recipe-3/README.md)
