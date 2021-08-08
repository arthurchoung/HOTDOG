#!/usr/bin/perl

$monitorWidth = shift @ARGV;
$monitorHeight = shift @ARGV;
if (not $monitorWidth or not $monitorHeight) {
    die('specify width and height');
}

@arr = ();

while ($line = <STDIN>) {
    chomp $line;

    $elt = {};
    if ($line !~ m/\bid:(\d+)/) {
        die("missing id");
    }
    $elt->{'id'} = $1;

    if ($line !~ m/\bx:([\-\d]+)/) {
        die("missing x");
    }
    $elt->{'x'} = $1;

    if ($line !~ m/\by:([\-\d]+)/) {
        die("missing y");
    }
    $elt->{'y'} = $1;

    if ($line !~ m/\bw:(\d+)/) {
        die("missing w");
    }
    $elt->{'w'} = $1;

    if ($line !~ m/\bh:(\d+)/) {
        die("missing h");
    }
    $elt->{'h'} = $1;
    push @arr, $elt;
}

@arr = sort { $b->{'h'} <=> $a->{'h'} } @arr;

$cursorX = 0;
foreach $elt (@arr) {
    $elt->{'x'} = $cursorX;
    $elt->{'y'} = 0;
    $cursorX += $elt->{'w'};
}

if ($cursorX > $monitorWidth) {
    $pct = $cursorX / $monitorWidth;
    foreach $elt (@arr) {
        $elt->{'x'} /= $pct;
        $elt->{'w'} /= $pct;
        $elt->{'h'} /= $pct;
    }
}

foreach $elt (@arr) {
    print "id:$elt->{'id'} x:$elt->{'x'} y:$elt->{'y'} w:$elt->{'w'} h:$elt->{'h'}\n";
}

