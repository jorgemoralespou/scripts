#!/usr/bin/env bash

#
#
#
usage() {
   echo "$0 USER PASSWORD"
   echo "Will provide encrypted password"
   exit
}

[ $# -ne 2 ] && usage;

. ./classpath.sh
java -cp $CLASSPATH EncryptPassword $*
