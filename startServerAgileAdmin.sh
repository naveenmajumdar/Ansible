#!/bin/sh
# Set all env variables

. ./setEnv.sh

cd ..

STARTMODE=true
export STARTMODE

mkdir -p /apps/agile/product/agile933/agileDomain/servers/vmwaglapp01-stg-AgileServer/logs

# Set Production Mode.  When to true, the server starts up in production mode.  When
# to false, the server starts up in development mode.  The default is false.
JMX_SET="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9890 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=fa
lse"

"$JAVA_HOME/bin/java" -server -ms3072M -mx5120M -XX:MaxPermSize=1024M -XX:NewSize=1300M -XX:MaxNewSize=1300M -XX:+UseConcMarkSweepGC -classpath $CLASSPATH $JMX_SET -Dwe
blogic.system.BootIdentityFile=/apps/agile/product/agile933/agileDomain/config/boot.properties -Dweblogic.Name=vmwaglapp01-stg-AgileServer -Dbea.home=/apps/agile/produc
t/weblogic -Djava.awt.headless=true -Dweblogic.ProductionModeEnabled=$STARTMODE -Dweblogic.log.StdoutSeverity=Error -Dagile.log.dir=/apps/agile/product/agile933/agileDo
main/servers/vmwaglapp01-stg-AgileServer/logs -Djava.awt.headless=true -Djava.security.policy=$WLS_HOME/server/lib/weblogic.policy weblogic.Server
