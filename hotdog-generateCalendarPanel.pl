#!/usr/bin/perl

$args = join ' ', @ARGV;

@output = `cal $args`;
chomp @output;

@daysofweek = ();

print <<EOF;
setValue:[ configDir:'Config/calendarMenu.csv'|parseCSVFile|asMenu ] forKey:'buttonRightClickMessage'
panelHorizontalStripes
panelText:''
EOF

%months = (
    'January' => 1,
    'February' => 2,
    'March' => 3,
    'April' => 4,
    'May' => 5,
    'June' => 6,
    'July' => 7,
    'August' => 8,
    'September' => 9,
    'October' => 10,
    'November' => 11,
    'December' => 12
);

foreach $line (@output) {
    next if ($line =~ m/^ *$/);
    if ($line =~ m/^ +[A-Z]/) {
        $line =~ s/^ +//g;
        $line =~ s/ +$//g;
        @tokens = split / +/, $line;
        $monthName = shift @tokens;
        $year = shift @tokens;
        print <<EOF;
panelText:'$monthName $year'
panelText:''
EOF
    } elsif ($line =~ m/^[A-Z]/) {
        @daysofweek = split / +/, $line;
        @daysofweek = map { 'header:' . $_ } @daysofweek;
        $str = join q{' '}, @daysofweek;
        print <<EOF;
panelCalendarRow:['$str'] square:0 bgcolor:'black' fgcolor:'white' message:[]
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
        $month = $months{$monthName};
        if (not $month) {
            $month = $monthName;
        }
        @days = map { 
            if ($_ eq '') {
                '';
            } else {
                "year:$year month:$month day:$_ text: bgcolor: fgcolor:"
            }
        } @days;
        $str = join q{' '}, @days;
        print <<EOF;
panelCalendarRow:['$str'] message:[hoverObject|showAlert]
EOF
    }
}

print <<EOF;
panelCalendarRow:[]
EOF

