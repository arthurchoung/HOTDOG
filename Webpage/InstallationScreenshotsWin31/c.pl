#!/usr/bin/perl

$count = 0;
foreach $elt (@ARGV) {
    $count++;
    print sprintf('addBlackBorder "%s" installation-win31-%.2d.png', $elt, $count);
    print "\n";
}

