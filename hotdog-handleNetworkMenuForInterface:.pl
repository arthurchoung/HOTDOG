#!/usr/bin/perl

$arg = shift @ARGV;
if (not $arg) {
    die('specify interface');
}

if ($arg eq 'lo') {
    exit 0;
}

@lines = `hotdog-listNetworkInterfaces.pl`;
chomp @lines;

foreach $line (@lines) {
    $interface = '';
    if ($line =~ m/\binterface:([a-z0-9]+)/) {
        $interface = $1;
        $interface =~ s/\'//g;
    }
    if ($interface ne $arg) {
        next;
    }

    if ($line =~ m/\btype:([^\s]+)/) {
        $type = $1;
        $type =~ s/\'//g;
    }
    if ($line =~ m/\bup:([^\s]+)/) {
        $up = $1;
        $up =~ s/\'//g;
    }
    if ($line =~ m/\blowerUp:([^\s]+)/) {
        $lowerUp = $1;
        $lowerUp =~ s/\'//g;
    }
    if ($line =~ m/\boperstate:([^\s]+)/) {
        $operstate = $1;
        $operstate =~ s/\'//g;
    }
    if ($line =~ m/\baddress:([^\s]+)/) {
        $address = $1;
        $address =~ s/\'//g;
    }
    $dhcpcd = `pgrep -f 'dhcpcd.*$interface'`;
    chomp $dhcpcd;
    if ($dhcpcd =~ m/^(\d+)/) {
        $dhcpcd = $1;
    }

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

    if ($dhcpcd) {
        $text = "Kill $dhcpcd (dhcpcd for $interface)?";
        $cmd = qq{hotdog confirm OK Cancel "$text"};
        $output = `$cmd`;
        chomp $output;
        if ($output eq 'OK') {
            $cmd = "sudo kill $dhcpcd";
            $output = `$cmd`;
            chomp $output;
        }
    } else {
        $text = "Run dhcpcd for $interface?";
        $cmd = qq{hotdog confirm OK Cancel "$text"};
        $output = `$cmd`;
        chomp $output;
        if ($output eq 'OK') {
            $cmd = "hotdog-connectNetworkInterface.pl $interface";
            $output = `$cmd`;
            chomp $output;
        }
    }
}
