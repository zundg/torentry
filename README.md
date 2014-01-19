This is some files I use to create a Tor "entry" node.

It runs on a Tor anonymizing middle box [0] and offers free wlan after accepting some disclaimer.

The files provided are for
- setting up an accesspoint
- running a dhcp server
- running a very basic and incomplete DNS server to give answers to any A questions asked
- running some web server to display a disclaimer and change the handling of IPs that accept it
- configuring netfilter to to the apropriate redirects to the local dns/web server or to the Tor services

Perl modules and binaries like hostapd and dhcpd are needed.

Some german words on it are on [1]

[0] https://trac.torproject.org/projects/tor/wiki/doc/TransparentProxy#AnonymizingMiddlebox
[1] http://glumpundzeug.wordpress.com/2014/01/19/tor-entry-node/


Licensed under GPLv2 or later.
