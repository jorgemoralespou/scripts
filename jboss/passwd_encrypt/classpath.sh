#!/usr/bin/env bash

if [ -z $JBOSS_HOME ]
then
   echo "JBOSS_HOME is not set"
   exit 255
fi

_PATH=$(find $JBOSS_HOME/modules/system/layers/base/org/picketbox/main/ -regextype posix-extended -regex ".*picketbox-[[:digit:]].*")
export CLASSPATH=$CLASSPATH:$_PATH:$JBOSS_HOME/bin/jboss-client.jar:.
