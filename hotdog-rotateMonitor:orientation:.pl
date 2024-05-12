#!/usr/bin/env perl

$matchName = shift @ARGV;
$orientation = shift @ARGV;
if (not $matchName or not $orientation) {
    die('specify matchName and orientation');
}

$baseDir = `hotdog configDir`;
chomp $baseDir;
chdir $baseDir;

system("cat Temp/listMonitors.txt | hotdog-modifyToRotateMonitor:orientation:.pl $matchName $orientation >Temp/monitors.txt");

system('hotdog-setupMonitors.pl');

