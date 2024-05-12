#!/usr/bin/env perl

$result = `hotdog confirm Shutdown Cancel 'Shutdown?'`;
chomp $result;

if ($result eq 'Shutdown') {
    system("sudo -A poweroff");
}

