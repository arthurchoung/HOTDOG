#!/usr/bin/perl

$result = `echo "Restart?" | hotdog confirm Restart`;
chomp $result;
if ($result eq 'Restart') {
    system("sudo -A reboot");
}

