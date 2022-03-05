#!/usr/bin/perl

use vCard;

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/'/\\'/g;
    return $str;
}

$path = shift @ARGV;
if (not $path) {
    die('specify file');
}

$vcard = vCard->new;
$vcard->load_file($path);

$path = asQuotedString($path);

print <<EOF;
panelHorizontalStripes
panelText:''
panelText:'$path'
panelText:''
EOF

$version = asQuotedString($vcard->version());
$full_name = asQuotedString($vcard->full_name());
$title = asQuotedString($vcard->title());
$photo = asQuotedString($vcard->photo());
$birthday = asQuotedString($vcard->birthday());
$timezone = asQuotedString($vcard->timezone());
$family_names = $vcard->family_names();
$given_names = $vcard->given_names();
$other_names = $vcard->other_names();
$honorific_prefixes = $vcard->honorific_prefixes();
$honorific_suffixes = $vcard->honorific_suffixes();
$phones = $vcard->phones();
$addresses = $vcard->addresses();
$email_addresses = $vcard->email_addresses();

print <<EOF;
panelMiddleButton:'Full Name: $full_name'
panelMiddleButton:'Title: $title'
panelMiddleButton:'Photo: $photo'
panelMiddleButton:'Birthday: $birthday'
panelMiddleButton:'Time Zone: $timezone'
EOF

foreach $elt (@$family_names) {
    $elt = asQuotedString($elt);
    print <<EOF;
panelMiddleButton:'Family Name: $elt'
EOF
}

foreach $elt (@$given_names) {
    $elt = asQuotedString($elt);
    print <<EOF;
panelMiddleButton:'Given Name: $elt'
EOF
}

foreach $elt (@$other_names) {
    $elt = asQuotedString($elt);
    print <<EOF;
panelMiddleButton:'Other Name: $elt'
EOF
}

foreach $elt (@$honorific_prefixes) {
    $elt = asQuotedString($elt);
    print <<EOF;
panelMiddleButton:'Honorific Prefix: $elt'
EOF
}

foreach $elt (@$honorific_suffixes) {
    $elt = asQuotedString($elt);
    print <<EOF;
panelMiddleButton:'Honorific Suffix: $elt'
EOF
}

foreach $elt (@$phones) {
    $type = $elt->{'type'};
    if ($type) {
        $type = asQuotedString($type->[0]);
    } else {
        $type = 'none';
    }
    $number = asQuotedString($elt->{'number'});
    $preferred = $elt->{'preferred'};
    if ($preferred) {
        $preferred = ' (preferred)';
    } else {
        $preferred = '';
    }
    print <<EOF;
panelMiddleButton:'Phone: $type $number$preferred'
EOF
}

foreach $elt (@$addresses) {
    $type = $elt->{'type'};
    if ($type) {
        $type = asQuotedString($type->[0]);
    } else {
        $type = 'none';
    }
    $pobox = asQuotedString($elt->{'pobox'});
    $extended = asQuotedString($elt->{'extended'});
    $street = asQuotedString($elt->{'street'});
    $city = asQuotedString($elt->{'city'});
    $region = asQuotedString($elt->{'region'});
    $post_code = asQuotedString($elt->{'post_code'});
    $country = asQuotedString($elt->{'country'});
    $preferred = $elt->{'preferred'};
    if ($preferred) {
        $preferred = 'preferred';
    } else {
        $preferred = '';
    }
    print <<EOF;
panelMiddleButton:'Address:'
panelMiddleButton:'type $type'
panelMiddleButton:'pobox $pobox'
panelMiddleButton:'extended $extended'
panelMiddleButton:'street $street'
panelMiddleButton:'city $city'
panelMiddleButton:'region $region'
panelMiddleButton:'post_code $post_code'
panelMiddleButton:'country $country'
panelMiddleButton:'preferred $preferred'
EOF
}

foreach $elt (@$email_addresses) {
    $type = $elt->{'type'};
    if ($type) {
        $type = asQuotedString($type->[0]);
    } else {
        $type = 'none';
    }
    $address = asQuotedString($elt->{'address'});
    $preferred = $elt->{'preferred'};
    if ($preferred) {
        $preferred = 'preferred';
    } else {
        $preferred = '';
    }
    print <<EOF;
panelMiddleButton:'Email:'
panelMiddleButton:'type $type'
panelMiddleButton:'address $address'
panelMiddleButton:'preferred $preferred'
EOF
}

print <<EOF;
panelText:''
panelText:'Version: $version'
EOF

