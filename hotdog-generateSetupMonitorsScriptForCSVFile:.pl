#!/usr/bin/perl

$|=1;

use strict;

sub read_csv_hack
{
    my ($path) = @_;
    my $output = `cat $path`;
    my @lines = split "\n", $output;
    my $first = shift @lines;
    $first =~ s/\"//g;
    my @keys = split ',', $first;
    my $nkeys = scalar @keys;
    my %results = ();
    if ($nkeys) {
        my $index = 1;
        foreach my $line (@lines) {
            $line =~ s/\"//g;
            my @tokens = split ',', $line;
            my %elt = ();
            for (my $i=0; $i<$nkeys; $i++) {
                $elt{$keys[$i]} = $tokens[$i];
            }
            $elt{'index'} = $index;
            $results{$tokens[0]} = \%elt;
            $index++;
        }
    }
    return %results;
}

sub get_monitors
{
    my $output = `xrandr`;
    my @lines = split "\n", $output;

    my @results = ();

    foreach my $line (@lines) {
        if ($line =~ m/ connected /) {
            $line =~ s/ connected / /;
            $line =~ s/ primary / /;
            my %elt = ();
            if ($line =~ m/^([^\s]+)\s/) {
                $elt{'name'} = $1;
            }
            push @results, \%elt;
        }
    }

    return @results;
}

sub sort_monitors
{
    my @results = @_;

    @results = sort {
        if (not $a->{'index'}) {
            return 1;
        }
        if (not $b->{'index'}) {
            return 1;
        }
        return $a->{'index'} <=> $b->{'index'};
    } @results;

    return @results;
}

my $arg = shift @ARGV;
if (not $arg) {
    die("need arg");
}

my %prefs = read_csv_hack($arg);

my @results = get_monitors();

foreach my $elt (@results) {
    my $pref = $prefs{$elt->{'name'}};
    if ($pref) {
        $elt->{'rotate'} = $pref->{'rotate'};
        $elt->{'index'} = $pref->{'index'};
    }
}

@results = sort_monitors(@results);

print "xrandr --auto\n";

my $prevElt = undef;
foreach my $elt (@results) {
    my @arr = ();
    push @arr, 'xrandr';
    push @arr, '--output';
    push @arr, $elt->{'name'};
    push @arr, '--auto';
    if ($prevElt) {
        push @arr, '--right-of';
        push @arr, $prevElt->{'name'};
    }
    if ($elt->{'rotate'}) {
        push @arr, '--rotate';
        push @arr, $elt->{'rotate'};
    }
    my $str = join ' ', @arr;
    print "$str\n";
    $prevElt = $elt;
}

