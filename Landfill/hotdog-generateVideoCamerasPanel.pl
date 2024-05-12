#!/usr/bin/perl

@output = `v4l2-ctl --list-devices`;
chomp @output;

print <<EOF;
panelHorizontalStripes
panelText:''
panelText:'Video Cameras'
panelText:''
EOF

$count = 0;
$name = '';
foreach $line (@output) {
    if ($line =~ m/^[^\s]/) {
        $name = $line;
        $name =~ s/:$//;
        $name =~ s/\'//g;
    } else {
        if ($line =~ m/^\s+(\/dev\/[a-zA-Z0-9]+)/) {
            if ($name) {
                $device = $1;
                print <<EOF;
panelButton:'$name ($device)' message:[['ffplay' '$device']|runCommandInBackground]
EOF
                $name = '';
                $count++;
            }
        }
    }
}

if (not $count) {
    print <<EOF;
panelText:'No cameras detected.'
EOF
}
