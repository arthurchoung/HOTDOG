#!/usr/bin/perl

$path = shift @ARGV;
if (not $path) {
    die('specify file');
}

if ($path =~ m/2160/) {
    system
        'mpv',
        '--hwdec=auto',
        '--force-window=yes',
        '--volume-max=200',
        '--video-unscaled=yes',
        $path;
} else {
    system
        'mpv',
        '--hwdec=auto',
        '--force-window=yes',
        '--volume-max=200',
        $path;
}

