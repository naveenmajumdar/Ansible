#!/bin/sh
# Shutdown WebLogic Application Server

function usage {
    echo "Usage:"
    echo "  - Superadmin password is specified in command line:"
    echo "      $0: <WAIT|FORCE> <superadmin password>"
    echo "  - Superadmin password is retrieved from Weblogic boot.properties file:"
    echo "      $0: <WAIT|FORCE>"
    echo "Exiting..."
}

case $1 in
    "FORCE")
      SHUTDOWN_MODE=FORCE;
      SHUTDOWN_PARM=FORCESHUTDOWN;
      ;;
    "WAIT")
        SHUTDOWN_MODE=WAIT;
        SHUTDOWN_PARM=SHUTDOWN;
        ;;
    *)
        usage;
        exit;
        ;;
esac

PW_SUPERADMIN=$2

. ./setEnv.sh

HOST_NAME=vmwaglapp01-stg
#LISTEN_PORT=9001
WLS_USERNAME=superadmin
WLS_PASSWORD=$PW_SUPERADMIN

if [ -z $WLS_PASSWORD ]
then
    echo "Retrieving $WLS_USERNAME's password from boot.identity file..."
    WLS_PASSWORD=`"$JAVA_HOME/bin/java" -classpath $CLASSPATH com.agile.util.WLSBootIdentityUtil`
fi

echo Executing SHUTDOWN $SHUTDOWN_MODE ...
"$JAVA_HOME/bin/java" -classpath $CLASSPATH weblogic.Admin -url $HOST_NAME:9001 -username $WLS_USERNAME -password $WLS_PASSWORD $SHUTDOWN_PARM
