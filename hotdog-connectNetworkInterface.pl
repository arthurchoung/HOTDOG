#!/usr/bin/perl

$interface = shift @ARGV;
if (not $interface) {
    die('specify interface');
}

$dhcpcd = `pgrep -f 'dhcpcd.*$interface'`;
chomp $dhcpcd;
if ($dhcpcd) {
    system('hotdog', 'alert', "dhcpcd for $interface already running", '', "pid $dhcpcd");
    exit 1;
}

`sudo -A ifconfig $interface up`;

$wireless = 0;
open(FH, "iwconfig $interface |") or die('unable to run iwconfig');
while ($line = <FH>) {
    if ($line =~ m/^$interface/) {
        if ($line =~ m/ESSID:/) {
            $wireless = 1;
        }
    }
}
close(FH);

if ($wireless) {
    $essid = `sudo -A hotdog-scanNetworks.pl | hotdog choose '#{essid|percentDecode} #{quality}/70' 'Wireless Network' '\nChoose a network ESSID:\n\n' | hotdog-allValuesForKey:.pl essid | hotdog-percentDecode.pl | hotdog-quotedString.pl`;
    chomp $essid;
    if (not $essid) {
        exit 0;
    }

    `sudo -A iwconfig $interface essid $essid`;
}

if (open FH, "sudo -A dhcpcd -4 $interface 2>&1 | hotdog progress |") {
    $addr = undef;
    while ($line = <FH>) {
        chomp $line;
        if ($line =~ m/ leased ([\d\.]+)/) {
            $addr = $1;
        }
    }
    close(FH);
    if ($addr) {
        system('hotdog', 'alert', "Obtained address $addr");
    } else {
        $dhcpcd = `pgrep -f 'dhcpcd.*$interface'`;
        chomp $dhcpcd;
        if ($dhcpcd) {
            `sudo -A kill $dhcpcd`;
        }
        system('hotdog', 'alert', 'Unable to obtain address');
    }
}

