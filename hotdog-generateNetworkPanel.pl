#!/usr/bin/perl

@lines = `hotdog-listNetworkInterfaces.pl`;
chomp @lines;

print <<EOF;
panelHorizontalStripes
panelText:''
panelButton:'Sync Time with NTP' message:[['ntpdate' 'pool.ntp.org']|runCommandWithSudoAndReturnOutput|asString|showAlert]
panelText:''
panelLine
panelText:''
panelText:'Choose a network interface to set up:'
panelText:''
panelLine
EOF

$first = 1;

foreach $line (@lines) {
    if ($first) {
        $first = 0;
    } else {
        print <<EOF;
panelText:''
panelLine
EOF
    }

    $interface = '';
    print <<EOF;
panelText:''
EOF
    if ($line =~ m/\binterface:([^\s]+)/) {
        $interface = $1;
        $interface =~ s/\'//g;
        print <<EOF;
panelText:'Interface: $interface'
EOF
    }
    if ($line =~ m/\btype:([^\s]+)/) {
        $type = $1;
        $type =~ s/\'//g;
        print <<EOF;
panelText:'Type:$type'
EOF
    }
    if ($line =~ m/\bup:([^\s]+)/) {
        $up = $1;
        $up =~ s/\'//g;
        print <<EOF;
panelText:'Up:$up'
EOF
    }
    if ($line =~ m/\blowerUp:([^\s]+)/) {
        $lowerUp = $1;
        $lowerUp =~ s/\'//g;
        print <<EOF;
panelText:'lowerUp:$lowerUp'
EOF
    }
    if ($line =~ m/\boperstate:([^\s]+)/) {
        $operstate = $1;
        $operstate =~ s/\'//g;
        print <<EOF;
panelText:'operstate:$operstate'
EOF
    }
    if ($line =~ m/\baddress:([^\s]+)/) {
        $address = $1;
        $address =~ s/\'//g;
        print <<EOF;
panelText:'Address:$address'
EOF
    }
    $dhcpcd = `pgrep -f 'dhcpcd.*$interface'`;
    chomp $dhcpcd;
    if ($dhcpcd =~ m/^(\d+)/) {
        $dhcpcd = $1;
    }
    print <<EOF;
panelText:'dhcpcd:$dhcpcd'
EOF

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
    print <<EOF;
panelText:'wireless:$wireless'
EOF

    if ($interface eq 'lo') {
    } elsif ($dhcpcd) {
        print <<EOF;
panelButton:'Kill $dhcpcd (dhcpcd for $interface)' message:[NSArray|addObject:'kill'|addObject:'$dhcpcd'|runCommandWithSudoAndReturnOutput;updateArray]
EOF
    } else {
        print <<EOF;
panelButton:'Run dhcpcd for $interface' message:[NSArray|addObject:'hotdog-connectNetworkInterface.pl'|addObject:'$interface'|runCommandAndReturnOutput;updateArray]
EOF
    }
}

