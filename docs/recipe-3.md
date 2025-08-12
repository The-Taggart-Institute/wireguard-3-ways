# Recipe 3: Coordinate Mesh with Headscale

We've learned that the lighthouse model, while convenient, has a potentially critical shortcoming: the relay exposes traffic as it crosses from one Wireguard tunnel to another. That means if the underlying protocol (HTTPS, SSH, etc.) is not encrypted, the traffic is perfectly readable by another with `root` access to the lighthouse. This isn't a problem in a direct mesh network, since the traffic is sent directly to a given peer. Unfortunately, we can't easily do that with _just_ Wireguard when we're traversing multiple routers and the internet.

Ideally we'd want the lighthouse to negotiate some sort of pathfinding for peers to connect directly to each other, and let the peer-to-peer traffic remain encrypted.

That's exactly what [Tailscale](https://tailscale.com) does.

## Tailscale

Tailscale is a networking product built on Wireguard and designed for the exact use case we're describing: building custom secure networks across multiple NAT layers.

I'll let you dive into the details of [how Tailscale operates](https://tailscale.com/blog/how-tailscale-works), but essentially Tailscale adds a coordination component to the Wireguard network that allows peers connecting to the "coordination server" to discover the best way to directly connect to each other—even behind NAT. Tailscale adds a few other handy features, like mature authentication/authorization and access control.

Still, the Tailscale service is yet another service. Trustworthy? Probably, but I don't like needing to rely on third party services. Luckily, I don't have to, because Tailscale open sources almost all of its core code. The client and coordination server bases are available, and there is indeed an open source implementation of the coordination server known as [Headscale](https://headscale.net)

## Headscale

Headscale allows us to spin up our own mini-Tailscale, using the Tailscale client for connection and authentication. The Tailscale client is also cross-platform (including mobile).

Headscale is shockingly easy to get going. The [server installation documentation](https://headscale.net/stable/setup/install/official/) is extremely clear, as are the [configuration options](https://github.com/juanfont/headscale/blob/main/config-example.yaml) available.

This recipe shows Headscale in action in a safe, containerized environment. But if you're interested in "going live" in this workshop, it will be Headscale that we deploy to the cloud.

## Lab Setup

Navigate to `recipe-3` in your terminal.

Before starting the lab, you might want to review the config file at `headscale/config/config.yaml`. Here you can see how we configure Headscale for listening. What you won't see in this configuration is any concept of a user. For that, you might want to look at how we spin things up in `start.sh`. But you'll also have a chance to do this yourself in the lab.

As before, fire up the lab with `./start.sh`. Your Zellij session will show three terminals, but only two containers: the home and roaming clients. What's up with that? The leftmost terminal is still on the host, because all of the commands for the Headscale server are run _outside_ the terminal. That's just how Headscale decided to set it up. We'll work with it.

## Lab Exercises

### Run Headscale Commands

On the left-hand terminal, we can run commands against our Headscale server with `podman container exec`. Let's check the status of our nodes with:

```bash
podman container exec recipe-3_headscale headscale nodes list
```

We should see two online nodes.

### Access the Home Webserver

We once again have a home network webserver set up to test route advertisement. From the roaming client, run:

```bash
tracepath 192.168.99.10
```

You should see hops that represent Tailscale nodes. That tells us that the `192.168.99.0/24` subnet is being properly routed across Tailscale.

You can of course then use `curl` to confirm it works.


### Tailscale Hostnames

From either client, run `tailscale status` to see the hostnames Tailscale associates with the IP addresses. Try using `ping` or `nc` to establish network connections using hostnames.

