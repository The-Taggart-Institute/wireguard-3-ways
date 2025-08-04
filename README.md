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

## Usage

Here are provided 3 "recipes" for creating Wireguard networks, in increasing complexity—and utility. Each is comprised of [Podman](https://podman.io) containers, networked together. They can be run on any platform that Podman supports, but for the HOPE workshop, a cloud VM will be provided for participants.

## The Recipes

### 0. A Simple Mesh

In this recipe, all our peers live on the same network. That could make Wireguard redundant, but it will establish an additional layer of encryption on top of all peer-to-peer communications. This recipe is more about learning the concepts of Wireguard configurations. Each peer connects to every other peer via manual point-to-point connections. This works, but doesn't exactly scale.

### 1. The Road Warrior

Here we introduce the notion of traversing networks. The "Road Warrior" opens a door to a home network, allowing roaming Wireguard clients to connect back home and access assets there.

This is the most direct way to access local resources remotely, but also one that exposes a port on your home router to allow the Wireguard connection.

### 2. The Lighthouse

If we want to connect multiple hosts across networks, but we don't want to open inbound ports, we need to use a public server that all our peers can see. This "lighthouse" server will be the one to which all the others connect. Since we don't want every device in our home network to have to connect to the lighthouse, we set up a "subnet router" that can provide access to the home network. This is just another peer, with some extra Linux firewall rules assigned.

### 3. The Coordinated Mesh

One of the shortcomings of the "lighthouse" model is that the lighthouse becomes a termination point for the Wireguard encrypted tunnel. If we have doubts about our cloud service provider, then any otherwise unencrypted traffic may be sniffed with access to this server. But we need a central point that everyone can see to guarantee connection. How to square this circle?

[Tailscale](https://tailscale.com) solves this problem by using multiple strategies to show peers how to connect, and then allows the peers to connect directly to each other, eliminating the machine-in-the-middle.
