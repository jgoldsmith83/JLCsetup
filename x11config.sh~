#!/usr/bin/expect -f

set PASSWORD "jobsearch"

spawn x11vnc -storepasswd ~/.vnc/passwd
expect "password:" {send "jobsearch\r"}
expect "password:" {send "jobsearch\r"}
expect "Write*\?" {send "y\r"}
