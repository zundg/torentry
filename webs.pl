#!/usr/bin/perl

use strict;
use warnings;
use HTTP::Daemon;
use File::Slurp;

fork && exit;

my $d = HTTP::Daemon->new(
        LocalAddr => '0.0.0.0',
        LocalPort => 81,
        ReuseAddr => 1
);

while (my $c = $d->accept) {
    my $pid = fork();

    if(!defined $pid || $pid == 0 ) {
        $c->close;
        next;
    }

        while (my $request = $c->get_request) {
		my ($cont) = $request->content;
	 	if ($request->content eq "ok=Ich+stimme+obigen+Bedingungen+zu+und+will+jetzt+surfen"){
			my ($host) = $request->header("Host");
			my ($url) = $request->url;
			my $ip = $c->peeraddr;
			$ip = join('.', unpack('C4', $ip));	
			`iptables -t nat -I PREROUTING -i wlan0 -p udp -s $ip --dport 53 -j REDIRECT --to-ports 53`;	
			`echo 'iptables -t nat -D PREROUTING -i wlan0 -p udp -s $ip --dport 53 -j REDIRECT --to-ports 53' | at now +6 hours`;	
			`iptables -t nat -I PREROUTING -i wlan0 -p tcp -s $ip --syn -j REDIRECT --to-ports 9040`;
			`echo 'iptables -t nat -D PREROUTING -i wlan0 -p tcp -s $ip --syn -j REDIRECT --to-ports 9040' | at now +6 hours`;
			sleep 1;
			$c->send_redirect("http://".$host.$url)
		} else {
	                my $response = HTTP::Response->new( 200, 'OK');
			my $index = read_file("/root/index.html");	
	                $response->header('Content-Type' => 'text/html'),
	                $response->content($index);
	                $c->send_response($response);
		}
        }
        $c->close;
        undef($c);
	exit;
}


