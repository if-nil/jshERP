#!/bin/bash

SERVER_NAME=jshERP
readonly APP_HOME=${FILE_PATH:-$(dirname $(cd `dirname $0`; pwd))}
#readonly JAVA_HOME=""
readonly CONFIG_HOME="$APP_HOME/config/"
readonly LIB_HOME="$APP_HOME/lib"
readonly LOGS_HOME="$APP_HOME/logs"
readonly PID_FILE="$LOGS_HOME/application.pid"
readonly APP_MAIN_CLASS="jshERP.jar"
readonly LOG_CONFIG="$CONFIG_HOME/logback-spring.xml"
readonly JAVA_RUN="-Dlogs.home=$LOGS_HOME -Dlogging.config=$LOG_CONFIG -Dspring.config.location=file:$CONFIG_HOME -Dspring.pid.file=$PID_FILE -Dspring.pid.fail-on-write-error=true"
readonly JAVA_OPTS="-server -Xms128m -Xmx320m -XX:PermSize=128M -XX:MaxPermSize=256M $JAVA_RUN"
readonly JAVA="java"
PID=0
if [ ! -x "$LOGS_HOME" ]
then
  mkdir $LOGS_HOME
fi
chmod +x -R "$JAVA_HOME/bin/"

$JAVA $JAVA_OPTS -jar $LIB_HOME/$APP_MAIN_CLASS 