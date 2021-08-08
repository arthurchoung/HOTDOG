#!/usr/bin/perl

$|=1;

$output = `hotdog "inputTextWithAlert:'Enter password:' hidden:1" 2>/dev/null`;
print "$output\n";

