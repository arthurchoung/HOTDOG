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
    `echo "Unable to unmount $path" | hotdog alert`;
    exit 1;
}
`echo "$path has been unmounted" | hotdog alert`;
exit 0;

