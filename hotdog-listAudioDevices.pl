#!/usr/bin/perl

$output = `cat /proc/asound/cards`;
@lines = split "\n", $output;
$count = 0;
foreach $line (@lines) {
    if ($line =~ m/^\s*(\d+)[^:]+: (.+)/) {
        $name = "hw:$1";
        $displayName = $2;
        $displayName =~ s/([%\s])/sprintf '%%%02x', ord $1/eg;
        print <<EOF;
name:$name displayName:$displayName
EOF
        $count++;
    }
}

