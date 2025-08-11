# Recipe 2: The Lighthouse + Subnet Router

This one is a minor modification of the Lighthouse from the last recipe, but an important one. The lighthouse as we defined it works great to connect Wireguard clients together, but what about devices that can't run Wireguard? What if you just _have_ to have access to that sweet, sweet Brother printer in your home office? Or more modernly, what if you want to access your local-only security cameras?

In this recipe, one of our Peers connecting to the lighthouse has a trick up its sleeve. Despite being an ordinary Linux box, it serves as a router, allowing Wireguard peers to access the networks it can access. This "subnet router" provides Wireguard clients access to an entire home network through a single node.

```mermaid
flowchart TD
 subgraph s1["Home network"]
        n2["Home Node"]
        n4["Webserver"]
  end
 subgraph s2["Roaming network"]
        n3["Roaming Node"]
  end
 subgraph s3["Internet"]
        n1["Lighthouse"]
  end
    n2 <---> s3
    s2 <---> s3
    n2 <---> n4

    n2@{ shape: rounded}
    n3@{ shape: rounded}
    n1@{ shape: rounded}
    style n2 stroke:#2962FF
    style n3 stroke:#AA00FF
    style n1 stroke:#D50000
    style s1 fill:#BBDEFB
    style s2 fill:#E1BEE7
```

## Lab Setup

In the `recipe-2` folder, run the `start.sh` script. As before, this will initialize the Podman containers. This lab starts 4 containers:

1. The home router
2. A non-Wireguard webserver on the home network
3. A roaming Wireguard client on a separate network
4. The lighthouse server

To save a little time, this lab setup automates the assignment of Wireguard IP addresses in the config files.

## Router Config

To see how this works, take a look at `home-router/home-router.conf`. It's a Wireguard config, similar to the ones we've seen previously, but this one has a whole mess of `PostUp` and `PostDown` commands. Wireguard allows you to execute arbitrary commands upon startup aand shutdown. These commands set up firewalls rules to forward IP traffic from the Wireguard interface to the router's local interface, and "masquerade" the IP address—that is, pretend the packet is from the route rinternally, but translate it back to the original source once a response is received.

> The commands here use [nftables](https://wiki.nftables.org/wiki-nftables/index.php/Main_Page) to create the firewall rules. NFTables is the successor to iptables, but the syntax is way more arcane. In your own configs, if you prefer iptables or firewalld commands, that's just fine.

This works in conjunction with the IP forwarding configuration on the lighthouse. Not much changes from the last configuration, save for the `AllowedIPs` field of the `[Peer]` config for our home router. While every other peer connecting to the lighthouse has a single IP in this field, the home router has a single IP, _and_ the whole home subnet. That looks like:

```
AllowedIPs = 172.16.100.2/32, 192.168.99.0/24
```

When a request for a home network address comes over the lighthouse tunnel, the lighthouse will use its routing rules (created by Wireguard) to send the traffic down to the home router. The home router, in turn, handles the traffic with its firewall rules. And that's how we present an entire home network to Wireguard via one—well two—peers.

That same `AllowedIPs` pattern is necessary on all the clients we want to access the home network via the Wireguard tunnel. Remember that on clients, `AllowedIPs` amounts to a routing rule for the Wireguard tunnel. So our roaming client's `Peer` entry for the lighthouse, the `AllowedIPs` section looks like:

```
AllowedIPs = 172.16.100.0/24, 192.168.99.0/24     
```

## Lab Exercises

### Tracepath

We can use `tracepath` to confirm that traffic to the `192.168.99.0/24` network is being routed over Wireguard. From the roaming client, run:

```bash
tracepath 192.168.99.10
```

The hops you see should be all `172.16.100.0/24` addresses until the very end.

### cURL

We went to the trouble of setting up a webserver in the home network. Can you use `cURL` to access it from the roaming Wireguard client?

```bash
curl http://192.168.99.10
```

Yay! Web traffic!

### The Dirty Secret

The lighthouse is doing its job, but there's a subtle flaw in this which, depending on your threat model, might be a dealbreaker.

Let's think about what happens with that HTTP request to our home webserver. The roaming client sends the HTTP request over the Wireguard tunnel, up to the lighthouse server, which forwards it on to the home router, which in turn forwards it to the webserver.

See the problem? Like I said, it's subtle.

The issue lies in the first forward. In order for the lighthouse server to determine how to route the incoming packets, the traffic must _exit_ the Wireguard tunnel and be handled by the lighthouse's routing rules. And there's the rub: at that moment, as the traffic exits one Wireguard tunnel before being sent over another, the traffic is not encrypted by Wireguard. That means anyone who can listen to our lighthouse's traffic can read the raw traffic. And because our request was unencrypted HTTP, the request is fully visible.

We can demonstrate this by capturing packets on the lighthouse during the HTTP request. All the tools have been included in the containers to make this happen.

Start the capture on the lighthouse this way:

```bash
tcpdump -i recipe-2 tcp port 80 -w curl.pcapng
```

This will listen to the Wireguard interface for HTTP traffic. Then on the roaming client:

```bash
curl http://192.168.99.10?key=supersecretkey
```

Use `Ctrl+C` to stop the packet capture on the lighthouse. You can then use `tshark` (or `termshark` if you're feeling brave) to review the traffic. With `tshark`, the command would be:

```bash
tshark -r curl.pcapng
```

See anything interesting?

### Why This Matters

We discussed in the rationale for Wireguard that many VPNs are just a shifting of risk from the ISP to the VPN. In this case, we have also introduced some potential risk. If someone besides us is snooping on the cloud virtual machine, we've lost our guarantee of confidentiality. Some cloud providers are more trustworthy than others. Personally, for the providers I use, I'm less concerned about that than I am with any potential compromises of home routers. Still, this is not a perfect end-to-end encryption solution.
But don't worry—we can do better.

When you're done exploring, stop the containers with `stop.sh` in the `recipe-2` folder.
