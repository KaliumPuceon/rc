#!/bin/bash
 
q=$(cmus-remote -C "save -q -" | sort | uniq | sort -R | sed "s/^/add -q /")
(echo "clear -q" ; echo "$q" ) | cmus-remote
