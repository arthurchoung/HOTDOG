#!/usr/bin/env perl

$|=1;

sub print_bar_chart
{
    my @pcts = @_;

    my $barHeight = 16;
    my $spacing = 1;
    my $barWidth = 5;

    my @heights = map { int ($_ * $barHeight) + 1 } @pcts;

    print "\npixels\n";

    my $y;
    for ($y=18; $y>0; $y--) {
        my @arr = ();
        my $height;
        foreach $height (@heights) {
            if ($height >= $y) {
                push @arr, "x" x $barWidth;
            } else {
                push @arr, " " x $barWidth;
            }
        }
        my $str = join " " x $spacing, @arr;
        print "$str\n";
    }

    print "\n";
}

print <<EOF;
palette
x #000000

highlightedPalette
x #ffffff

EOF

open(FH, 'vmstat -P -w 1 -p proc |') || die('unable to run vmstat');

$line = <FH>;
$line =~ s/^\s+//;
$line =~ s/\s+$//;
@headers = split /\s+/, $line;
$numberOfCPUs = scalar @headers;
$numberOfCPUs -= 4;
$line = <FH>;

while ($line = <FH>) {
    chomp $line;
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    @arr = split /\s+/, $line;
    @pcts = ();
    for ($i=16; $i<scalar @arr; $i+=3) {
        $val = 100 - int($arr[$i]);
        $val = $val / 100.0;
        push @pcts, $val;
    }
    print_bar_chart(@pcts);
}

