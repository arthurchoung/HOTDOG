#!/usr/bin/perl

foreach $elt (@ARGV) {
    $dst = $elt;
    if ($dst =~ s/\-(\d+)\.png$//) {
        $num = $1;
        $num++;
        print qq{mv -i "$elt" "$dst-x$num.png"\n};
    } else {
        $dst =~ s/\.png$//;
        print qq{mv -i "$elt" "$dst-x0.png"\n};
    }
}

