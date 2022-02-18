#!/usr/bin/perl

@arr = `ls --group-directories-first`;
chomp @arr;

print <<EOF;
panelHorizontalStripes
EOF

print <<EOF;
panelButton:'Shuffle with MPV' message:[['mpv' '--shuffle' '.']|runCommandInBackground]
panelText:''
panelLine
panelText:''
EOF

$numElts = scalar @arr;
for ($i=0; $i<$numElts; $i++) {
    $elt = $arr[$i];
    $elt =~ s/\'/\\\'/g;
    $type = 'panelMiddleButton';
    if ($i == 0) {
        $type = 'panelTopButton';
    } elsif ($i == $numElts-1) {
        $type = 'panelBottomButton';
    }
    $message = '';
    if (-d $elt) {
        $elt = "$elt/";
        print <<EOF;
$type:'$elt' message:['$elt'|changeDirectory;ObjectInterface|pushToNavigationStack]
EOF
    } else {
        print <<EOF;
$type:'$elt' message:['$elt'|runFileHandler]
EOF
    }
}

