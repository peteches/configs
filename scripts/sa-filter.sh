#! /bin/bash


/usr/bin/spamassassin | /usr/bin/sendmail -i "$@"
