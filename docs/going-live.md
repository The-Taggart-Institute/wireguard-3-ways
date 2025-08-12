# Going Live: Leaving the Test Kitchen

Our recipes so far have demonstrated the concepts behind Wireguard networking in a safe, contained (and containerized) environment. But now it's time to start building our real private network. In this section, we walk through creating a real-deal Headscale server in the cloud.

> "But Taggart, you can't trust the cloud!"

You can use a thing without trusting it. The value proposition of the cloud VM is its visibility from everywhere. But if we do this right (e.g. a proper Headscale setup), we won't be trusting it for too much. Its job will be to negotiate the initial connection between peers, and then let the Tailscale "magic" establish peer-to-peer connections, keeping the lighthouse out of the picture entirely.

Let's get going.

## Required Materials

This is the part of the workshop that costs some money. To complete this setup as we've done it, you'll need:

1. A registered domain name that you can control
2. A cloud VM

The cloud VM doesn't have to be huge. Entry-level VMs on all major VPSes will be just fine.

## Create the Cloud VM

It all starts with the cloud VM. I'm going to use [Digital Ocean](https://digitalocean.com) to demo the process, but if you're comfortabel with `AWS|Azure|Vultr|Hetzner`, go for it.

For commonality's sake, we'll use Ubuntu 24.04 LTS as our base. However, this choice means we'll need to manually install a newer version of Podman than is available directly from the package manager.

Different cloud providers have different methods of securing their VMs, but I strongly recommend the following best practices:

- Use SSH Key authentication
- Use firewall rules to limit SSH access to certain source IP addresses

Log in to the VM via SSH (or cloud console, if appropriate).

### Housekeeping

We want to perform the following housekeeping measures, as needed:

1. Create a new, non-root user
2. Make sure our SSH Keys are present on the new user and that we can log in with it
3. Disable root login
4. Add firewall rules to allow HTTP/HTTPS traffic (80/tcp, 443/tcp)

> Hey if you wanna get extra sneaky, change the ports you're using for SSH and HTTPS, but for now we'll leave these default.

## Install Headscale

Head to the [Headscale Releases](https://github.com/juanfont/headscale/releases/latest) and download the latest Headscale version.

For our server, we want the `linux_amd64.deb` version. Copy that link's URL and then use it like so:

```bash
wget https://github.com/juanfont/headscale/releases/download/v0.26.1/headscale_0.26.1_linux_amd64.deb
sudo dpkg -i headscale*.deb
```

If all goes well, you'll see some instructions to enable and start the `headscale` service. Let's do so.

```bash
sudo systemctl enable headscale
sudo systemctl start headscale
```

Now comes the configuration part. We'll start with the users.

## Create Headscale users

For now, we'll just create one user, but for your real network, you can make as many as you need. Remember that machines are associated with users, so think about how you want to link those conceptually.

```bash
sudo headscale users create hope -d hope-demo
```

And right away we'll create a preauthkey for use when we're ready to connect a client.

```bash
sudo headscale preauthkeys create -u 1
```

Copy that and save it for later.

## Configure Headscale Server

Now we need to edit the Headscale config to match our domain. Got the domain you intend to use? Great. We don't need to modify the DNS records _yet_, but it's coming up. For now, use Nano, Vim, or Helix (`sudo snap install helix --classic`). With any of those, open up `/etc/headscale/config.yaml` with `sudo`.

Change `server_url` to `https://the-domain-you-chose.com:443`

Change `listen_addr` to `0.0.0.0:443`

Change `acme_email` to an email address you feel comfortable giving to LetsEncrypt.

Change `tls_letsencrypt_hostname` to `the-domain-you-chose.com`

And that's all we need to change for now. If you looked closely at the setup for Headscale in our recipes, you saw we configured a custom certificate for Headscale on startup. But now that we're on the internet proper, we can use [LetsEncrypt](https://letsencrypt.org) to grab a certificate.

Save and quit.

## Configure DNS

Time to head to your DNS registrar! Create a new `A` record for the domain name you've selected and point it at the IP address of your cloud VM. 

Give it a few minutes for the record to propagate. You can test it with `nslookup the-domain-you-chose.com`.

Once it's ready, head back to your server and restart Headscale.

```bash
sudo systemctl daemon-reload
sudo systemctl restart headscale
```

## Connect a Client Or Two

Now comes the fun part. Using the Tailscale Client, connect to the Headscale server. Here's how it looks on Linux:

```bash
sudo tailscale up --login-server=https://the-domain-you-chose.com --auth-key=the-authkey-you-created --accept-routes
```

Congratulations! You've created a Headscale network.

## Going Further

Now that you have a way of connected trusts endpoints and networks together for secure communications, you can explore using some of these endpoints as [exit nodes](https://tailscale.com/kb/1103/exit-nodes) to alter where your internet traffic comes from. You can also explore [DNS](https://tailscale.com/kb/1054/dns) for your network to make it easier to reference endpoints.

You can also explore [access control](https://headscale.net/stable/ref/acls/) for more granular control of your hosts.

But for now, take a moment and congratulate yourself. You've just taken a big step toward owning your digital privacy. You're using the cloud, but on your terms.
