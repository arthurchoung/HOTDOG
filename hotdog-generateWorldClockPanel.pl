#!/usr/bin/perl

$region = shift @ARGV;

@output = `cat /usr/share/zoneinfo/zone1970.tab`;
chomp @output;

@timezones = ();

foreach $line (@output) {
    next if ($line =~ m/^#/);
    @fields = split "\t", $line;
    $tz = $fields[2];
    @tokens = split '/', $tz;
    $tz1 = $tz;
    $tz2 = '';
    if (scalar @tokens > 1) {
        $tz1 = shift @tokens;
        $tz2 = join '/', @tokens;
    }
    $dict = {
        'codes' => $fields[0],
        'coordinates' => $fields[1],
        'TZ' => $tz,
        'comments' => $fields[3],
        'TZ1' => $tz1,
        'TZ2' => $tz2
    };
    push @timezones, $dict;
}

if ($region) {
    @timezones = grep { $_->{'TZ1'} eq $region } @timezones;
    @timezones = sort { $a->{'TZ2'} cmp $b->{'TZ2'} } @timezones;
    
    $str = $region;
    $str =~ s/\\/\\\\/g;
    $str =~ s/'/\\'/g;

    print <<EOF;
panelHorizontalStripes
panelText:''
panelText:'World Clock: $str'
panelText:''
EOF
    foreach $elt (@timezones) {
        $tzstr = $elt->{'TZ'};
        $tzstr =~ s/\\/\\\\/g;
        $tzstr =~ s/'/\\'/g;
        $tz2str = $elt->{'TZ2'};
        $tz2str =~ s/\\/\\\\/g;
        $tz2str =~ s/'/\\'/g;
        print <<EOF;
panelMiddleButton:('$tzstr'|currentDateTimeForTimeZoneWithFormat:'$tz2str \%I:\%M:\%S \%p') message:[]
EOF
    }
} else {
    %regions = ();
    foreach $elt (@timezones) {
        $regions{$elt->{'TZ1'}} = 1;
    }
    @regions = sort keys %regions;
    print <<EOF;
panelHorizontalStripes
panelText:''
panelText:'World Clock'
panelText:''
panelText:'Choose a region:'
panelText:''
EOF
    foreach $elt (@regions) {
        $elt =~ s/\\/\\\\/g;
        $elt =~ s/'/\\'/g;
        print <<EOF;
panelMiddleButton:'$elt' message:[['hotdog' 'show' "WorldClockPanel:'$elt'"]|runCommandInBackground]
EOF
    }
}

