#!/bin/sh
# Set all env variables

. ./setEnv.sh

cd ..

STARTMODE=true
export STARTMODE

mkdir -p /apps/agile/product/agile933/agileDomain/servers/vmwaglapp01-stg-ManagedServer1/logs

# Set Production Mode.  When to true, the server starts up in production mode.  When
# to false, the server starts up in development mode.  The default is false.
JMX_SET="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9891 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=fa
lse"


"$JAVA_HOME/bin/java" -server -ms5120M -mx7168M -XX:MaxPermSize=512M -XX:NewSize=1300M -XX:MaxNewSize=1300M -XX:+UseConcMarkSweepGC -classpath $CLASSPATH $JMX_SET -Dweb
logic.system.BootIdentityFile=/apps/agile/product/agile933/agileDomain/config/boot.properties -Dweblogic.Domain=agileDomain -Dweblogic.Name=vmwaglapp01-stg-ManagedServe
r1 "-Dbea.home=/apps/agile/product/weblogic" -Djava.awt.headless=true -Dweblogic.ProductionModeEnabled=$STARTMODE -Dweblogic.log.StdoutSeverity=Error "-Djava.security.p
olicy==/apps/agile/product/weblogic/wlserver_12.1/server/lib/weblogic.policy" -Dacs.skipServer=false -Dagile.log.dir=/apps/agile/product/agile933/agileDomain/servers/vm
waglapp01-stg-ManagedServer1/logs -Dweblogic.management.server=http://vmwaglapp01-stg.corp.netapp.com:9001 weblogic.Server
