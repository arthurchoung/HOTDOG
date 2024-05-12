#!/usr/bin/perl

use vCard;

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/'/\\'/g;
    return $str;
}

@output = `ls`;
chomp @output;

print <<EOF;
panelHorizontalStripes
panelText:''
panelText:'Contacts'
panelText:''
EOF

@arr = ();
foreach $path (@output) {
    next if ($path !~ m/\.vcf$/i);

    $vcard = vCard->new;
    $vcard->load_file($path);

    $full_name = asQuotedString($vcard->full_name());

    $dict = { 'full_name'=>$full_name, 'path'=>$path };
    push @arr, $dict;
}

@arr = sort { $a->{'full_name'} cmp $b->{'full_name'} } @arr;

foreach $elt (@arr) {
    $path = asQuotedString($elt->{'path'});
    print <<EOF;
panelMiddleButton:'$elt->{'full_name'}' message:[['hotdog' 'VCFPanel' '$path']|runCommandInBackground]
EOF
}

