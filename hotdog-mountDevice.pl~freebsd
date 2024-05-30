#!/usr/bin/env perl

$baseDir = `hotdog configDir`;
chomp $baseDir;
chdir $baseDir;

$device = shift @ARGV;
$fstype = shift @ARGV;
if (not $device or not $fstype) {
    die('specify device and fstype');
}

for(;;) {
loop:
    # FIXME
    @mountlist = `hotdog-listDisks.pl | hotdog-allValuesForKey:.pl mountpoint | sed '/^\$/d'`;
    chomp @mountlist;
    $mountlist = join ' ', @mountlist;

    $mountpointsFile = 'Temp/mountpoints.txt';
    if (-e $mountpointsFile) {
        @lines = `cat $mountpointsFile`;
        @lines = sort @lines;
        chomp @lines;
        if (scalar @lines) {
            @arr = ('hotdog', 'radio', 'OK', 'Cancel', qq{"Enter mount point for $device:"});
            $default = '1';
            $i = 1;
            foreach $line (@lines) {
                $line =~ s/([\"\\])/\\$1/g;
                $found = 0;
                foreach $elt (@mountlist) {
                    if ($elt eq $line) {
                        $found = 1;
                        last;
                    }
                }
                if (not $found) {
                    push @arr, $i, $default, qq{"$line"};
                    $default = '0';
                }
                $i++;
            }
            if (not $default) {
                push @arr, 'new', '0', qq{"Enter New Mount Point"};
                $cmd = join ' ', @arr;
                $result = `$cmd`;
                chomp $result;
                if ($result eq 'new') {
                } elsif ($result > 0) {
                    $mountpoint = $lines[$result-1];
                    @mountcmd = ();
                    if ($fstype eq 'ntfs') {
                        @mountcmd = ('sudo', '-A', 'ntfs-3g', $device, $mountpoint);
                    } else {
                        @mountcmd = ('sudo', '-A', 'mount', '-t', $fstype, $device, $mountpoint);
                    }
                    system(@mountcmd);
                    if ($? != 0) {
                        system('hotdog', 'alert', "Unable to mount $device at $mountpoint");
                        exit 1;
                    }
                    chdir $mountpoint;
                    system('hotdog', 'nav', '.');
                    exit 0;
                } else {
                    exit 0;
                }
            }
        }
    }

    $text = <<EOF;
Enter mount point for $device:
(mount points that are already in use: $mountlist)
EOF

    $mountpoint = `hotdog input OK Cancel "$text" 'Mount point:'`;
    chomp $mountpoint;
    if ($? != 0) {
        exit 1;
    }
    if (not $mountpoint) {
        exit 0;
    }
    $output = `hotdog-listDisks.pl`;
    @lines = split "\n", $output;
    foreach $line (@lines) {
        if ($line =~ m/\bmountpoint:([^\s]+)/) {
            $str = $1;
            $str =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
            if ($mountpoint eq $str) {
                # FIXME: should sanitize $mountpoint
                system('hotdog', 'alert', "$mountpoint is already in use");
                goto loop;
            }
        }
    }

    if (open(FH, ">>$mountpointsFile")) {
        print FH "$mountpoint\n";
        close(FH);
    }

    @mountcmd = ();
    if ($fstype eq 'ntfs') {
        @mountcmd = ('sudo', '-A', 'ntfs-3g', $device, $mountpoint);
    } else {
        @mountcmd = ('sudo', '-A', 'mount', '-t', $fstype, $device, $mountpoint);
    }
    system(@mountcmd);
    if ($? != 0) {
        system('hotdog', 'alert', "Unable to mount $device at $mountpoint");
        exit 1;
    }

    chdir $mountpoint;
    system('hotdog', 'nav', '.');

    exit 0;
}


