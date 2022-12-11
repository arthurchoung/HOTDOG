#!/usr/bin/perl

print <<EOF;
displayName,messageForClick
EOF

$output = `cat /proc/asound/cards`;
@lines = split "\n", $output;
$count = 0;
foreach $line (@lines) {
    if ($line =~ m/^\s*(\d+)[^:]+: (.+)/) {
        $name = "hw:$1";
        $displayName = $2;
        $displayName =~ s/\"//g;
        $displayName =~ s/\\//g;
        print <<EOF;
"$displayName ($name)","NSArray|addObject:'hotdog-openALSAPanel.sh'|addObject:'$name'|addObject:'$displayName'|runCommandInBackground"
EOF
        $count++;
    }
}

