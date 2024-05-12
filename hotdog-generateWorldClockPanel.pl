#!/usr/bin/env perl

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
    
    print <<EOF;
=region=$region
panelHorizontalStripes
panelText:''
panelText:(str:'World Clock: #{region}')
panelText:''
EOF
    $index = 0;
    foreach $elt (@timezones) {
        $index++;
        $tzstr = $elt->{'TZ'};
        $tz2str = $elt->{'TZ2'};
        print <<EOF;
=tzstr$index=$tzstr
=tz2str$index=$tz2str
panelMiddleButton:(tzstr$index|currentDateTimeForTimeZoneWithFormat:(str:'#{tz2str$index} \%I:\%M:\%S \%p')) message:[]
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
    $index = 0;
    foreach $elt (@regions) {
        $index++;
        print <<EOF;
=elt$index=$elt
panelMiddleButton:(elt$index) message:[NSArray|addObject:'hotdog'|addObject:'show'|addObject:'WorldClockPanel:(arg0)'|addObject:(elt$index)|runCommandInBackground]
EOF
    }
}

