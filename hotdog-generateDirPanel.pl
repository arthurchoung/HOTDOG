#!/usr/bin/perl

$arg = shift @ARGV;

$lsflags = '--group-directories-first';
if (-e '00lsflags') {
    $lsflags = `cat 00lsflags`;
    chomp $lsflags;
    $lsflags =~ s/[^-=a-zA-Z0-9 ]//g;
}

$cmd = "ls $lsflags";
@arr = `$cmd`;
chomp @arr;

if ($arg) {
    @arr = grep /$arg/i, @arr;
}

print <<EOF;
setValue:[ configDir:'Config/filePanelMenu.csv'|parseCSVFile|asMenu ] forKey:'navigationRightMouseDownMessage'
setValue:[ configDir:'Config/fileMenu.csv'|parseCSVFile|asMenu ] forKey:'buttonRightMouseDownMessage'
panelHorizontalStripes
EOF

if ($lsflags) {
    print <<EOF;
panelText:'ls: $lsflags'
EOF
}
if ($arg) {
    $arg =~ s/'/\\'/g;
    print <<EOF;
panelText:'grep: $arg'
EOF
}
if ($lsflags || $arg) {
    print <<EOF;
panelText:''
EOF
}

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
        if ($elt =~ m/\.app$/) {
            print <<EOF;
$type:'$elt' message:[['hotdog' 'open' '$elt']|runCommandInBackground]
EOF
        } else {
            $elt = "$elt/";
            print <<EOF;
$type:'$elt' message:['$elt'|changeDirectory;ObjectInterface|pushToNavigationStack]
EOF
        }
    } else {
        print <<EOF;
$type:'$elt' message:['$elt'|runFileHandler]
EOF
    }
}

