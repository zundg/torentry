#!/usr/bin/perl

use strict;
use warnings;
use Net::DNS::Nameserver;

sub reply_handler {
	my ($qname, $qclass, $qtype, $peerhost,$query,$conn) = @_;
	my ($rcode, @ans, @auth, @add);
	
	my ($ttl, $rdata) = (1, "10.42.23.1");
	my $rr = new Net::DNS::RR("$qname $ttl $qclass $qtype $rdata");
	push @ans, $rr;
	$rcode = "NOERROR";
	
	return ($rcode, \@ans, \@auth, \@add, { aa => 1 });
}

fork && exit;

my $ns = new Net::DNS::Nameserver(
	 LocalPort    => 5353,
	 ReplyHandler => \&reply_handler,
	 ) || die "couldn't create nameserver object\n";

$ns->main_loop;

