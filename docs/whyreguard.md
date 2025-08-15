# Why...reguard?

Why do this at all? Why bother setting up a custom private network when there are so many services that will do it for you? And why choose Wireguard when other turnkey technologies like OpenVPN have been around for so long?

Let's get into it.

## Trust and Risk

If you're reading this, odds are you have a slightly different perspective on "the cloud" than most of the population. After all, it's just someone else's computer, right? Whenever you entrust your data to a third-party service, you are accepting some degree of risk to your data's confidentiality, integrity, and availability in that transaction. The service could go down due to demand, misconfiguration, or equipment failure (availability). Something could go catastrophically wrong with their infrastructure, leading to corrupting of data (integrity). Intentionally or otherwise, the service may enable others to view your data, even data intended to be secret (confidentiality).

These risks are hardly theoretical; we see the reality play out time and again.

Now imagine you're building a community that the government deems subversive. We don't even have to explore illegal activity, just activity that those in power don't like so much. Further imagine that you've entrusted your confidential data to a cloud service. In order to feel safe, you need the following guarantees:

1. The service is doing everything securely on the technical level.
2. There are no existing compromises to the service or technologies used by the service.
3. The service will be less than eager to cooperate with a subpoena or a warrant.

Despite the marketing, the use of most commercial VPNs is an act of transferring risk not mitigating it. You've moved the need to trust your internet service provider to the need to trust your VPN—in some cases, due to common misconfigurations, data actually ends up going both to the ISP _and_ the VPN, meaning you've now increased your risk profile.

But either way, you still have to trust those services. Some are probably trustworthy, but a system that relies on only a few good actors is a fragile system indeed. Instead, I'd like to build a private networking landscape in which many individuals can and do create the networks they require.

## The Threat Model

What exactly are we defending against here? This isn't really about criminals stealing your identity, much less machine-in-the-middle attacks at the coffee shop. What we're talking about here concerns community safety. Maybe you're organizing for political action. Maybe you're sharing media that those in power would rather not be shared. Maybe you're trying to run an independent news organization. Many forms of community have good reason to be concerned about an overzealous state attempting to monitor their communications and data archives. Entrusting all of this data to third parties who have more interest in cooperating with the state than protecting your privacy is a dicey situation.

## Examples Use Cases

Outside of normal VPN uses, why might you use a private Wireguard network in this climate?

- Political activism/organizing
- Secure dissemination of "subversive" materials
- Zero-cloud access to remote compute resources

## Wireguard

Wireguard offers the ability to create the kind of private network you _need_, not the one being sold to you. The tradeoff, at least in the more elementary setups, is knowing how the technology works. In this coming age, that knowledge is precious.

But what makes Wireguard so special as a technology? Four aspects make me very confident in networks built on Wireguard:

1. Simplicity
2. Ubiquity
3. Performance
4. Cryptography

### Simplicity

Compared to other VPN technologies like OpenVPN or IPSec, Wireguard is extremely simple at its core. As this workshop demonstrates, a basic mesh is hardly more than a few lines of config—and that's before we get to the rich ecosystem of tools built on Wireguard, some of which we'll explore during this workshop.

### Ubiquity

Wireguard is a Linux kernel module. That means every modern Linux machine has the capability of being a Wireguard node, and its residence in the kernel ensures a speedy pipeline to the networking hardware. But that's not all. Wireguard clients exist of Windows and macOS, as well as iOS and Android mobile operating systems. And because the Wireguard technology is licensed entirely under free and open source licenses, I don't expect it to disappear anytime soon.

### Performance

Wireguard [routinely outperforms](https://www.wireguard.com/performance/) other private networking technologies in throughput benchmarks. Anecdotally, I have experienced this reality. I have run full RDP sessions from conferences back to my lab at home over Wireguard, without a moment's hiccucp. If Wireguard can achieve [line rate](https://netseccloud.com/understanding-line-rate-in-networking-a-comprehensive-guide) on a gigabit card, that means your VPN layer is not a bottleneck in the communication.

### Cryptography

I encourage you to review the [cryptographic details](https://www.wireguard.com/protocol/) of the Wireguard protocol, if you're so inclined. I will never call myself a cryptography expert, but the ciphers in use and how they're used have been independently tested and attested. I'm confident in the cryptographic strength of the protocol.

## Fun

This seems like it shouldn't matter, but it kind of does. If you've done any kind of network engineering, you know what an utter slog it can be. I shudder when I think of the nights I spent reconfiguring VLANs on Cisco switches a lifetime ago.

Wireguard doesn't feel like that. Setting up Wireguard networks is, dare I say it, pretty fun! Yes it's technical, but straightforward enough to make sense to most curious users. And because Wireguard itself is so simple, making it work often reveals other surprises in your network topology.

So that's why Wireguard.
