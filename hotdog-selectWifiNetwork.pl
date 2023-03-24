#!/usr/bin/perl

$interface = shift @ARGV;
if (not $interface) {
    die('specify interface');
}

$choice = `hotdog-generateWifiNetworksPanel.pl | hotdog show Panel`;
chomp $choice;
if (not $choice) {
exit 0;
}

if ($choice !~ m/\bessid:(\S+)/) {
    die('essid not found');
}
$essid = $1;
$essid =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;

if ($choice =~ m/\bencryption:on/) {
    $password = `hotdog input OK Cancel 'Enter wifi password:'`;
    chomp $password;
    if ($password) {
        system('hotdog-runWPASupplicantForInterface:essid:password:.pl', $interface, $essid, $password);
    }
} else {
    system('sudo', '-A', 'iwconfig', $interface, 'essid', $essid);
}

