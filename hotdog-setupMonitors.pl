#!/usr/bin/perl

$baseDir = `hotdog configDir`;
chomp $baseDir;
chdir $baseDir;

system('hotdog-generateSetupMonitorsScriptForCSVFile:.pl Temp/monitors.csv | sh');
if (not -d 'Temp') {
    system('mkdir', 'Temp');
    system('chmod', '1777', 'Temp');
}

system('hotdog-listMonitors.pl >Temp/listMonitors.csv');

