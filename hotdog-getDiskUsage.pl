#!/usr/bin/perl

$output = `df .`;
if ($output =~ m/([0-9]+)\%/) {
    $pct = $1 / 100.0;
    print "pct:$pct\n";
}

