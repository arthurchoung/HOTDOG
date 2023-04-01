#!/usr/bin/perl

$count = 0;
foreach $elt (@ARGV) {
    $count++;
    print sprintf('mv -i "%s" aaainstallation-macplatinum-%.2d.png', $elt, $count);
    print "\n";
}

