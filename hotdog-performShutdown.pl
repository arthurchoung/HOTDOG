#!/usr/bin/perl

$result = `echo "Shutdown?" | hotdog confirm Shutdown`;
chomp $result;
if ($result eq 'Shutdown') {
    system("sudo -A poweroff");
}

