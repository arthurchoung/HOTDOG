#!/usr/bin/perl

$args = join ' ', @ARGV;

@output = `cal $args`;
chomp @output;

@daysofweek = ();

print <<EOF;
panelHorizontalStripes
panelText:''
EOF

foreach $line (@output) {
    next if ($line =~ m/^ *$/);
    if ($line =~ m/^ +[A-Z]/) {
        $line =~ s/^ +//g;
        $line =~ s/ +$//g;
        @tokens = split / +/, $line;
        $month = shift @tokens;
        $year = shift @tokens;
        print <<EOF;
panelText:'$month $year'
panelText:''
EOF
    } elsif ($line =~ m/^[A-Z]/) {
        @daysofweek = split / +/, $line;
        $str = join q{' '}, @daysofweek;
        print <<EOF;
panelCalendarRow:['$str'] square:0 bgcolor:'black' fgcolor:'white'
EOF

    } else {
        $line =~ s/^ +//g;
        $line =~ s/ +$//g;
        @days = split / +/, $line;
        if ($days[0] == 1) {
            while (scalar @days < 7) {
                unshift @days, '';
            }
        }
        $str = join q{' '}, @days;
        print <<EOF;
panelCalendarRow:['$str']
EOF
    }
}

print <<EOF;
panelCalendarRow:[]
EOF

