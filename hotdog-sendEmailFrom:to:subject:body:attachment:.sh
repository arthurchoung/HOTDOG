#!/bin/sh

if [ "$#" -lt 4 ]; then
    echo "specify from, to, subject, body, attachment"
    exit 1
fi

RESULT=$( hotdog-generateEmailFrom:to:subject:body:attachment:.py "$@" )

if [ "x$RESULT" == "x" ]; then
    hotdog alert "unable to generate email"
    exit 1
fi

( cat <<EOF
$RESULT
EOF
) | msmtp --tls-certcheck=off "$2"

EXITCODE=$?
if [ $EXITCODE -ne 0 ]; then
    hotdog alert "unable to send email"
    exit 1
fi

hotdog alert "email probably sent, but you never know with email"

