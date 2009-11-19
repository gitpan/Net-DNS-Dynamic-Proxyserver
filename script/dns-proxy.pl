#!/usr/bin/env perl

use strict;
use warnings;

use Net::DNS::Dynamic::Proxyserver;

use Getopt::Long;
use Pod::Usage;

our $VERSION = '0.02';

my $debug 	= 0;
my $help	= 0;
my $host 	= undef;
my $port	= undef;
my $background	= 0;
my $ask_etc_hosts = undef;

GetOptions(
    'debug|d'	      => \$debug,
    'help|?|h'        => \$help,
    'host=s'          => \$host,
    'port|p=s'        => \$port,
    'background|bg'   => \$background,
	'ttl=s'           => \$ask_etc_hosts,
);

pod2usage(1) if $help;

fork && exit if $background;

my $args = {};

$args->{debug}	= ($debug ? 1 : 0);
$args->{host}	= $host if $host;
$args->{port}	= $port if $port;
$args->{ask_etc_hosts} = { ttl => $ask_etc_hosts } if $ask_etc_hosts;

Net::DNS::Dynamic::Proxyserver->new( $args )->run();

=head1 NAME

dns-proxy.pl - A dynamic DNS proxy server

=head1 SYNOPSIS

dns-proxy.pl [options]

 Options:
   -d  -debug         enable debug mode
   -h  -help          display this help
       -host          host (defaults to all)
   -p  -port          port (defaults to 53)
   -bg -background    run the process in the background
   -ttl               use /etc/hosts to answer DNS queries with specified ttl (seconds)

 See also:
   perldoc Net::DNS::Dynamic::Proxyserver

=head1 DESCRIPTION

This script implements a dynamic DNS proxy server provided
by Net::DNS::Dynamic::Proxyserver. See 

 perldoc Net::DNS::Dynamic::Proxyserver

for detailed information what this server can do for you.

=head1 AUTHOR

Marc Sebastian Jakobs <mpelzer@cpan.org>

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

