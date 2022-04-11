#!/usr/bin/perl

$path = shift @ARGV;
if (not $path) {
    die('specify file');
}

system('hotdog', 'alert', "Supposed to open the file '$path'");

