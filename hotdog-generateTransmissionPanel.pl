#!/usr/bin/perl

print <<EOF;
panelHorizontalStripes
panelText:''
EOF

$pid = `pidof transmission-daemon`;
chomp $pid;
if ($pid) {
    print <<EOF;
panelText:'Daemon is running (pid $pid)'
panelButton:'Open Web Interface' message:['chromium http://admin:password\@127.0.0.1:9091'|split|runCommandInBackground]
panelButton:'Stop Daemon' message:['kill $pid'|split|runCommandInBackground;'sleep 1'|split|runCommandAndReturnOutput;updateArray]
panelText:''
EOF
    $clip = `xclip -o`;
    if ($clip) {
        $clip =~ s/\\/\\\\/g;
        $clip =~ s/'/\\'/g;
        if ($clip =~ m/^magnet:/) {
            print <<EOF;
panelText:'$clip'
panelButton:'Add' message:['transmission-remote' '-n' 'admin:password' '-a' '$clip'|runCommandAndReturnOutput|asString|showAlert]
EOF
        }
    }
} else {
    print <<EOF;
panelText:'Daemon is not running'
panelButton:'Start Daemon' message:['transmission-daemon -t -u admin -v password -p 9091 -a 127.0.0.1'|split|runCommandInBackground;'sleep 1'|split|runCommandAndReturnOutput;updateArray]
EOF
}
EOF

