#!/usr/bin/perl

$path = shift @ARGV;
if (not $path) {
    die('specify file');
}

if (open FH, "| hotdog alert") {
    print FH "Supposed to open the file '$path'\n";
    close FH;
}

