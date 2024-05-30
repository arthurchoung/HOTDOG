#!/usr/bin/env perl

$arg = shift @ARGV;
if (not $arg) {
    die('specify interface');
}

if ($arg =~ m/^lo/) {
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
    if ($line =~ m/\bdhclientIsRunning:([0-9]+)/) {
        $dhclient = $1;
    }

    $wireless = 0;
    if (open(FH, "iwconfig $interface |")) {
        while ($line = <FH>) {
            if ($line =~ m/^$interface/) {
                if ($line =~ m/ESSID:/) {
                    $wireless = 1;
                }
            }
        }
        close(FH);
    }

    $text = "What to do with $interface?";
    $text =~ s/\\/\\\\/g;
    $text =~ s/"/\\"/g;
    $dhclientcmd = qq{dhclient 0 "dhclient $interface"};
    if ($dhclient) {
        $dhclientcmd = qq{killdhclient 0 "kill dhclient (kill -9 $dhclient)"}
    }
    $cmd = sprintf('hotdog radio OK Cancel %s %s %s %s %s',
        qq{"$text"},
        'nothing 1 "Do Nothing"',
        $dhclientcmd,
        qq{ifconfigup 0 "ifconfig $interface up"},
        qq{ifconfigdown 0 "ifconfig $interface down"});
    $result = `$cmd`;
    chomp $result;
    if ($result eq 'dhclient') {
        system('hotdog-connectNetworkInterface.pl', $interface);
    } elsif ($result eq 'killdhclient') {
        system('sudo', '-A', 'kill', '-9', $dhclient);
    } elsif ($result eq 'ifconfigup') {
        system('sudo', '-A', 'ifconfig', $interface, 'up');
    } elsif ($result eq 'ifconfigdown') {
        system('sudo', '-A', 'ifconfig', $interface, 'down');
    }
}

