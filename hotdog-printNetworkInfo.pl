#!/usr/bin/env perl

$|=1;

$path = '/var/run/devd.seqpacket.pipe';

for(;;) {

    @lines = `ifconfig`;
    chomp @lines;

    $name = undef;
    $addr = undef;

    foreach $line (@lines) {
        if ($line !~ m/^\s/) {
            if ($line =~ m/:/) {
                @tokens = split ':', $line;
                $name = $tokens[0];
                if ($name =~ m/^lo/) {
                    $name = undef;
                }
            }
            next;
        }

        if ($name && ($name ne 'lo') && ($line =~ m/\sinet\s/)) {
            @tokens = split /\s+/, $line;
            $addr = $name . ' ' . $tokens[2];
            next;
        }
    }

    if ($addr) {
        print "$addr\n";
    } else {
        print "ifconfig\n";
    }

    if (open(FH, "cat $path |")) {
        while ($line = <FH>) {
            chomp $line;
            if ($line !~ m/\bsystem=IFNET\b/) {
                next;
            }
            if ($line =~ m/\btype=ADDR_DEL\b/) {
                last;
            } elsif ($line =~ m/\btype=ADDR_ADD\b/) {
                last;
            }
        }
        close(FH);
    } else {
        sleep 10;
    }

}
