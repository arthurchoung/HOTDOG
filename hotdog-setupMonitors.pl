#!/usr/bin/perl

$baseDir = `hotdog execDir`;
chomp $baseDir;
chdir $baseDir;

system('hotdog-generateSetupMonitorsScriptForCSVFile:.pl Temp/monitors.csv | sh');
if (not -d 'Temp') {
    if (not mkdir 'Temp', 1777) {
        print STDERR "Unable to mkdir Temp\n";
        exit(1);
    }
}

system('hotdog-listMonitors.pl >Temp/listMonitors.csv');

