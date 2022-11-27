#!/usr/bin/perl

$path = shift @ARGV;
if (not $path) {
    die('specify path');
}

$output = `hotdog confirm Unmount Cancel 'Unmount $path?'`;
chomp $output;
if ($output ne 'Unmount') {
    exit 1;
}
system('sudo', '-A', 'umount', $path);
if ($? != 0) {
    system('hotdog', 'alert', "Unable to unmount $path");
    exit 1;
}
system('sync');
system('hotdog', 'alert', "$path has been unmounted");
exit 0;

