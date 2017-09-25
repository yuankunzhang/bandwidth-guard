#!/usr/bin/env perl
use strict;

my $limit = 500;                        # 500G / month
my $proc_name = 'ss-server';            # process name
my $srv_name = 'shadowsocks-libev';     # service name

# Current time, used for logging.
my $now = `date +"%x %X" | tr -d '\n'`;

# Abort if process not running.
`pgrep $proc_name`;
if ($? != 0) {
  print STDOUT "$now: $srv_name not running\n";
  exit;
}

# Retrieve monthly statistics from vnstat.
my $statistics = `vnstat -m`;
# $month is used to do the regex match.
my $month = `date +%b | tr -d '\n'`;

if ($statistics =~ /$month[^\|]+\|[^\|]+\|\s+(\d+)\s+(\w+)/s) {
  print STDOUT "$now: bandwidth usage: $1 $2\n";
  if ($2 == 'GiB' and $1 >= $limit) {
    `systemctl stop $srv_name`;
    print STDERR "$now: bandwidth exceeded, force stop $srv_name\n";
  }
} else {    # Oops, vnstat output seems invalid.
  print STDERR "$now: could not parse vnstat output\n";
}
