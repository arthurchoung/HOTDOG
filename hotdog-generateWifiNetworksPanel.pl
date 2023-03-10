#!/usr/bin/perl

@lines = `sudo -A hotdog-scanNetworks.pl | hotdog-reverseNumericSortForKey:.pl quality`;
chomp @lines;

print <<EOF;
panelHorizontalStripes
panelText:'Wireless Networks'
panelText:''
panelText:'Choose a network ESSID:'
panelText:''
EOF

$count = scalar @lines;
for ($i=0; $i<$count; $i++) {
    $line = $lines[$i];
    $essid = '';
    $quality = '';
    $encryption = '';
    if ($line =~ m/\bessid:([^\s]+)/) {
        $essid = $1;
#$essid = "'$essid'";
        $essid =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
        $essid =~ s/\\/\\\\/g;
        $essid =~ s/'/\\'/g;
    }
    if ($line =~ m/\bquality:([^\s]+)/) {
        $quality = $1;
    }
    if ($line =~ m/\bencryption:([a-zA-Z]+)/) {
	$encryption = $1;
    }
    $button = 'panelMiddleButton';
    if ($i == 0) {
	    $button = 'panelTopButton';
	} elsif ($i == $count-1) {
		$button = 'panelBottomButton';
	}
    print <<EOF;
$button:'$essid [$quality/70] encryption:$encryption' message:['$essid'|writeToStandardOutput;exit:0]
EOF
}

