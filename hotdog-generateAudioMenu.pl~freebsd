#!/usr/bin/env perl

@lines = `cat /dev/sndstat`;
chomp @lines;

$count = 0;
foreach $line (@lines) {
    if ($line =~ m/^pcm(\d+): <([^>]+)>/) {
        $id = $1;
        $name = $2;
        $default = 0;
        if ($line =~ m/default$/) {
            $default = 1;
        }
        print <<EOF;
=id=$id
=name=$name
=stringFormat=#{name} (#{id})
EOF
        if ($id != $default) {
            print <<EOF;
=messageForClick=NSArray|addObject:'hotdog-selectAudioDevice:.pl'|addObject:id|runCommandInBackground
EOF
        }
        print <<EOF;
==
EOF
        $count++;
    }
}

