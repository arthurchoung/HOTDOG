#!/usr/bin/perl

@output = `cat dialog.txt`;

$count = scalar @output;
$num = int(rand($count-25));

print <<EOF;
panelHorizontalStripes
EOF

for ($i=0; $i<25; $i++) {
    $line = $output[$num+$i];
    if ($line =~ m/^([^\:]+)\:(.+)$/) {
        $name = $1;
        $text = $2;
        $text =~ s/\\/\\\\/g;
        $text =~ s/'/\\'/g;
        if ($name eq 'DUDE') {
            print <<EOF;
panelChatBubble:'$text' fgcolor:'#000000' bgcolor:'#c0c0c0'
panelText:''
EOF
        } else {
            print <<EOF;
panelRightSideChatBubble:'$text' fgcolor:'#000000' bgcolor:'#99c5fe'
panelText:''
EOF
        }
    }
}

