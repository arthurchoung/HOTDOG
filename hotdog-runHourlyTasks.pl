#!/usr/bin/env perl

$|=1;

$path = "$ENV{'HOME'}/HourlyTasks";

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/\"/\\\"/g;
    return '"' . $str . '"';
}

for (;;) {
    $files = `ls -tr $path 2>/dev/null`;
    @files = split '\n', $files;
    foreach $elt (@files) {
        $file = "$path/$elt";
        $timestamp = (stat($file))[9];
        $now = time;
        $diff = $now - $timestamp;
        if ($diff >= 360) {
            print "running '$file'...\n";
            $quotedFile = asQuotedString($file);
            system("sh $quotedFile");
            print " (finished)\n";
            $cmd = 
            system("touch $quotedFile");
        } else {
            print "file $file already ran $diff seconds ago...\n";
        }
    }

    for ($i=60; $i>0; $i--) {
        print "$path sleeping $i...\n";
        sleep 1;
    }
}

