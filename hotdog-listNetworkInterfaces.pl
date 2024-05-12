#!/usr/bin/env perl

$|=1;

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/\"/\\\"/g;
    return '"' . $str . '"';
}


@lines = `ifconfig`;
chomp @lines;

$name = undef;
$type = undef;
$addr = undef;
$status = undef;
%flags = ();

sub dhclientIsRunning
{
    my @output = `pgrep -f 'dhclient.*$name'`;
    chomp @output;
    return pop @output;
}

sub print_elt
{
    if ($name !~ m/^lo/) {
        $dhclientIsRunning = dhclientIsRunning();
        print "interface:$name type: up:$flags{'UP'} lowerUp:$flags{'LOWER_UP'} operstate:$status address:$addr dhclientIsRunning:$dhclientIsRunning\n";
    }
    $name = undef;
    $type = undef;
    $addr = undef;
    $status = undef;
    %flags = ();
}

foreach $line (@lines) {
    if ($line =~ m/^\s/) {
        if ($line =~ m/^\s+inet\s/) {
            @tokens = split /\s+/, $line;
            $addr = $name . ' ' . $tokens[2];
        }
        if ($line =~ m/^\s+ether\s/) {
            $type = 'ether';
        }
        if ($line =~ m/^\s+status:\s+([a-zA-Z0-9]+)/) {
            $status = $1;
        }
    } else {
        if ($name) {
            print_elt();
        }
        if ($line =~ m/^([a-zA-Z0-9]+):/) {
            $name = $1;
        }
        if ($line =~ m/flags=\d+<([^>]+)>/) {
            @arr = split ',', $1;
            foreach $elt (@arr) {
                $flags{$elt} = 1;
            }
        }
    }

}

print_elt();


