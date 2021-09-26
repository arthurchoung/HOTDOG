#!/usr/bin/perl

$result = undef;

if ($ENV{'HOTDOG_MODE'} eq 'amiga') {
    $result = `hotdog show "'AmigaAlert'|asInstance|setValue:'Restart?' forKey:'text'|setValue:'Restart' forKey:'okText'|setValue:'Cancel' forKey:'cancelText'"`;
} else {
    $result = `echo "Restart?" | hotdog confirm Restart`;
}

chomp $result;
if ($result eq 'Restart') {
    system("sudo -A reboot");
}

