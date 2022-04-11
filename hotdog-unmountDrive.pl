#!/usr/bin/perl

$path = shift @ARGV;
if (not $path) {
    die('specify path');
}

$output = `echo "Unmount $path?" | hotdog confirm`;
chomp $output;
if ($output ne 'OK') {
    exit 1;
}
system('sudo', '-A', 'umount', $path);
if ($? != 0) {
    system('hotdog', 'alert', "Unable to unmount $path");
    exit 1;
}
system('hotdog', 'alert', "$path has been unmounted");
exit 0;

