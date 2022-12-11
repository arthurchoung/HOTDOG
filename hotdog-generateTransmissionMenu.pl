#!/usr/bin/perl

print <<EOF;
displayName,messageForClick
EOF

$pid = `pidof transmission-daemon`;
chomp $pid;
if ($pid) {
    print <<EOF;
"Open Web Interface","'chromium http://admin:password\@127.0.0.1:9091'|split|runCommandInBackground"
,
"Stop Daemon (pid $pid)","'kill $pid'|split|runCommandInBackground"
EOF
    $clip = `xclip -o`;
    if ($clip) {
        $clip =~ s/\\/\\\\/g;
        $clip =~ s/'/\\'/g;
        $clip =~ s/"/\\"/g;
        if ($clip =~ m/^magnet:/) {
            print <<EOF;
,
"Add $clip","['transmission-remote' '-n' 'admin:password' '-a' '$clip']|runCommandAndReturnOutput|asString|showAlert"
EOF
        }
    }
} else {
    print <<EOF;
"Start Daemon","'transmission-daemon -t -u admin -v password -p 9091 -a 127.0.0.1'|split|runCommandInBackground"
EOF
}

