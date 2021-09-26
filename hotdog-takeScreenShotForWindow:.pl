#!/usr/bin/perl

$arg = shift @ARGV;
if (not $arg) {
    die("specify window id");
}

$date = `date "+%Y-%m-%d %H:%M"`;
chomp $date;

$base = "$ENV{'HOME'}/Screen Shot $date";
$path = "$base.png";
for ($i=0;;$i++) {
    if (-e $path) {
        $path = "$base-$i.png";
        next;
    }
    last;
}

system(qq{import -frame -window "$arg" "$path"});
if ($? != 0) {
    system(qq{echo "Unable to take screen shot" | hotdog alert});
    exit 0;
}

system(qq{echo "'Screen shot is located at '$path'" | hotdog alert});

