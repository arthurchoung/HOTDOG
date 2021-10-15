#!/usr/bin/perl

$output = `cat /proc/asound/cards`;
@lines = split "\n", $output;
$count = 0;
foreach $line (@lines) {
    if ($line =~ m/^\s*(\d+)[^:]+: (.+)/) {
        $name = "hw:$1";
        $displayName = $2;
        $displayName =~ s/\'//g;
        print <<EOF;
panelText:''
panelText:'$displayName ($name)'
panelButton:'Open Mixer' message:[NSArray|addObject:'hotdog-openALSAPanel.sh'|addObject:'$name'|addObject:'$displayName'|runCommandInBackground]
EOF
        $count++;
    }
}

if (not $count) {
    print <<EOF;
panelText:''
panelText:'No audio devices found'
EOF
}

