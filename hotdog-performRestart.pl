#!/usr/bin/perl

$result = `hotdog confirm Restart Cancel 'Restart?'`;
chomp $result;

if ($result eq 'Restart') {
    system("sudo -A reboot");
}

