#!/usr/bin/perl

$total = undef;

$output = `du -ksc .`;

if ($output =~ m/([0-9]+)\s+total/) {
    $total = $1;
}

print "total:$total\n";

