#!/usr/bin/perl

@output = `v4l2-ctl --list-devices`;
chomp @output;

print <<EOF;
displayName,messageForClick
EOF

$count = 0;
$name = '';
foreach $line (@output) {
    if ($line =~ m/^[^\s]/) {
        $name = $line;
        $name =~ s/:$//;
    } else {
        if ($line =~ m/^\s+(\/dev\/[a-zA-Z0-9]+)/) {
            if ($name) {
                $device = $1;
                print <<EOF;
=name=$name
=device=$device
=stringFormat=#{name} (#{device})
=messageForClick=NSArray|addObject:'ffplay'|addObject:device|runCommandInBackground
==
EOF
                $name = '';
                $count++;
            }
        }
    }
}

if (not $count) {
    print <<EOF;
=displayName=No cameras detected.
=messageForClick=1
==
EOF
}
