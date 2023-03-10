#!/usr/bin/perl

if (not scalar @ARGV) {
    die('specify command');
}

$cmd = join ' ', @ARGV;

@output = `$cmd`;
chomp @output;

print <<EOF;
displayName,messageForClick
EOF

$cmd =~ s/'//g;
$cmd =~ s/"//g;

foreach $elt (@output) {
    $elt =~ s/'//g;
    $elt =~ s/"//g;
    if (not $elt) {
        $elt = ' ';
    }
    print <<EOF;
"$elt","NSArray|addObject:'hotdog-handleCommandOutputMenu:line:.pl'|addObject:'$cmd'|addObject:'$elt'|runCommandInBackground"
EOF
}

