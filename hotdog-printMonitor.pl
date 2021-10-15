#!/usr/bin/perl

$|=1;

print "\n";

open FH, 'hotdog-monitorMonitors |' or die('unable to run hotdog-monitorMonitors');
while ($line = <FH>) {
    system('hotdog-setupMonitors.pl');
}
close FH;

