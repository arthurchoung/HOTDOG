#!/usr/bin/perl

$interface = shift @ARGV;
if (not $interface) {
    die('specify interface');
}

$essid = `hotdog-generateWifiNetworksPanel.pl | hotdog show Panel`;
#$essid = `sudo -A hotdog-scanNetworks.pl | hotdog choose '#{essid|percentDecode} #{quality}/70' 'Wireless Network' '\nChoose a network ESSID:\n\n' | hotdog-allValuesForKey:.pl essid | hotdog-percentDecode.pl | hotdog-quotedString.pl`;
chomp $essid;
if (not $essid) {
exit 0;
}

$essid =~ s/\\/\\\\/g;
$essid =~ s/"/\\"/g;

`sudo -A iwconfig $interface essid "$essid"`;

