#!/usr/bin/perl

$line = <STDIN>;
chomp $line;

$w = 0;
$h = 0;
$monitorX = 0;
$monitorWidth = 0;
$monitorHeight = 0;
if ($line =~ m/\bw:(\d+)/) { $w = int($1); }
if ($line =~ m/\bh:(\d+)/) { $h = int($1); }
if ($line =~ m/\bmonitorX:(\d+)/) { $monitorX = int($1); }
if ($line =~ m/\bmonitorWidth:(\d+)/) { $monitorWidth = int($1); }
if ($line =~ m/\bmonitorHeight:(\d+)/) { $monitorHeight = int($1); }

if ($w && $h && ($monitorWidth > $w) && ($monitorHeight - 20 > $h)) {
    $rangeX = $monitorWidth - $w;
    $rangeY = $monitorHeight - 20 - $h;

    $x = $monitorX + int(rand($rangeX));
    $y = int(rand($rangeY));
    print "x:$x y:$y\n";
    exit 0;
}

print "x:$monitorX y:0\n";

