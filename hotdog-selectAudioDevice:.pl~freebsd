#!/usr/bin/env perl

$device = shift @ARGV;
if ($device !~ m/^\d+$/) {
    die('specify audio device number');
}

system('sysctl', "hw.snd.default_unit=$device");

$baseDir = `hotdog configDir`;
print "$baseDir\n";

system('touch', "$baseDir/Config/menuBar.csv");

