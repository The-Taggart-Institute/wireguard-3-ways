# Recipe 2: The Lighthouse + Subnet Router

This one is a minor modification of the Lighthouse from the last recipe, but an important one. The lighthouse as we defined it works great to connect Wireguard clients together, but what about devices that can't run Wireguard? What if you just _have_ to have access to that sweet, sweet Brother printer in your home office? Or more modernly, what if you want to access your local-only security cameras?

In this recipe, one of our Peers connecting to the lighthouse has a trick up its sleeve. Despite being an ordinary Linux box, it serves as a router, allowing Wireguard peers to access the networks it can access. This "subnet router" provides Wireguard clients access to an entire home network through a single node.

```mermaid
flowchart TD
 subgraph s1["Home network"]
        n2["Home Node"]
        n4["Printer"]
        n5["Camera"]
  end
 subgraph s2["Roaming network"]
        n3["Roaming Node"]
  end
 subgraph s3["Internet"]
        n1["Lighthouse"]
  end
    n2 <---> s3
    s2 <---> s3
    n2 <---> n4 & n5

    n2@{ shape: rounded}
    n3@{ shape: rounded}
    n1@{ shape: rounded}
    style n2 stroke:#2962FF
    style n3 stroke:#AA00FF
    style n1 stroke:#D50000
    style s1 fill:#BBDEFB
    style s2 fill:#E1BEE7
```
