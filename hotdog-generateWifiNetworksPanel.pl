#!/usr/bin/perl

@lines = `sudo -A hotdog-scanNetworks.pl`;
chomp @lines;

print <<EOF;
panelHorizontalStripes
panelText:'Wireless Networks'
panelText:''
panelText:'Choose a network ESSID:'
EOF

foreach $line (@lines) {
    $essid = '';
    if ($line =~ m/\bessid:([^\s]+)/) {
        $essid = $1;
$essid = "'$essid'";
        $essid =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
        $essid =~ s/\\/\\\\/g;
        $essid =~ s/'/\\'/g;
    }
    if ($line =~ m/\bquality:([^\s]+)/) {
        $quality = $1;
    }
    print <<EOF;
panelText:''
panelButton:'$essid $quality/70' message:['$essid'|writeToStandardOutput;'%20'|percentDecode|writeToStandardOutput;exit:0]
EOF
}

