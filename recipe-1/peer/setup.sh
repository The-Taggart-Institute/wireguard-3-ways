#!/bin/bash

WG_CONF=/etc/wireguard/recipe-1.conf

# Enter proper context
pushd /peer
privkey=$(wg genkey)
pubkey=$(echo $privkey | wg pubkey)
cp ./peer.conf $WG_CONF
sed -i "s|<<PRIVATE_KEY>>|$privkey|" $WG_CONF
sed -i "s|<<PUBLIC_KEY>>|$pubkey|" $WG_CONF
popd

