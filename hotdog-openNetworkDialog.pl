#!/usr/bin/perl

$interface = `q chooseCommandObserver hotdog-listNetworkInterfaces.pl hotdog-monitorNetworkInterfaces '#{interface} #{ifTrue:[up] then:["UP"] else:["DOWN"]} #{ifTrue:[dhcpIsRunning] then:["DHCP"]}' 'Network' '\nChoose a network interface to set up:\n\n' | allValuesForKey: interface`;
chomp $interface;

if (not $interface) {
    exit 0;
}

for(;;) {
    $dhcpcd = `pgrep -fx 'dhcpcd $interface'`;
    chomp $dhcpcd;
    if (not $dhcpcd) {
        last;
    }
    $confirm = `echo "dhcpcd is already running (pid $dhcpcd)\n\nKill dhcpcd?" | hotdog confirm`;
    chomp $confirm;
    if ($confirm ne 'OK') {
        exit 0;
    }
    `sudo -A kill $dhcpcd`;
    sleep 1;
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
    $essid = `sudo -A hotdog-scanNetworks.pl | q choose '#{essid|percentDecode} #{quality}/70' 'Wireless Network' '\nChoose a network ESSID:\n\n' | hotdog-allValuesForKey:.pl essid | hotdog-percentDecode.pl | hotdog-quotedString.pl`;
    chomp $essid;
    if (not $essid) {
        exit 0;
    }

    `sudo -A iwconfig $interface essid $essid`;
}

if (open FH, "sudo -A dhcpcd $interface 2>&1 |") {
    $addr = undef;
    while ($line = <FH>) {
        if ($line =~ m/ leased ([\d\.]+)/) {
            $addr = $1;
        } else {
            print "dhcpcd: $line";
        }
    }
    close(FH);
    if ($addr) {
        `echo "Obtained address $addr" | hotdog alert`;
    } else {
        $dhcpcd = `pgrep -fx 'dhcpcd $interface'`;
        chomp $dhcpcd;
        if ($dhcpcd) {
            `sudo -A kill $dhcpcd`;
        }
        `echo "Unable to obtain address" | hotdog alert`;
    }
}

