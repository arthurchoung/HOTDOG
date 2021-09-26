#!/usr/bin/perl

$result = undef;

if ($ENV{'HOTDOG_MODE'} eq 'amiga') {
    $result = `hotdog show "'AmigaAlert'|asInstance|setValue:'Shutdown?' forKey:'text'|setValue:'Shutdown' forKey:'okText'|setValue:'Cancel' forKey:'cancelText'"`;
} else {
    $result = `echo "Shutdown?" | hotdog confirm Shutdown`;
}

chomp $result;
if ($result eq 'Shutdown') {
    system("sudo -A poweroff");
}

