#!/usr/bin/env bash

: ${JBDS_BINARY:="jboss-devstudio-8.0.0.GA-v20141020-1042-B317-installer-standalone.jar"}
: ${INSTALL_PATH:="/tmp/jbdevstudio"}
: ${JAVA_HOME:=$JAVA_HOME:-/usr/java/latest}


function usage {
   echo "This script will install JBDS 8 with the Integration Stack"
   echo "Download JBoss Developer Studio from here: http://www.jboss.org/products/devstudio/overview/ and place it in the same directory or configure this script accordingly" 
   echo ""
   echo "To configure installation you can set following environment variables:"
   echo " JBDS_BINARY  - Current value=${JBDS_BINARY}"
   echo " INSTALL_PATH - Current value=${INSTALL_PATH}"
   echo " JAVA_HOME    - Current value=${JAVA_HOME}"
   exit 255
}

[ $# -ne 0 ] && usage;

#
# Install JBDS & Integration Stack plugins
#
if [ -f ${JBDS_BINARY} ]
then
   echo "Installing JBDS and Integration Stack plugins in ${INSTALL_PATH}"
   # Install JBDS
   cp install-config.xml /tmp/install-config.xml
   sed -i -e "s/%PATH%/$(echo ${INSTALL_PATH} | sed -e 's/[\/&]/\\&/g')/g"  /tmp/install-config.xml
   sed -i -e "s/%JRE%/$(echo ${JAVA_HOME}/bin/java | sed -e 's/[\/&]/\\&/g')/g"  /tmp/install-config.xml
   java -jar ${JBDS_BINARY} /tmp/install-config.xml
   rm /tmp/install-config.xml 
   
   echo "Installing Integration Stack. This process might take a while, so relax and wait!!!"
   # Install Integration Stack
   ${INSTALL_PATH}/jbdevstudio -nosplash -application org.eclipse.equinox.p2.director -repository http://download.jboss.org/jbosstools/updates/development/luna/integration-stack/,https://devstudio.jboss.com/updates/8.0/,https://devstudio.jboss.com/updates/8.0/integration-stack/,https://devstudio.redhat.com/updates/8.0-development/integration-stack/ -installIU org.eclipse.bpmn2.feature.feature.group,org.eclipse.bpmn2.modeler.runtime.jboss.feature.group,org.eclipse.bpmn2.modeler.feature.group,org.fusesource.ide.camel.editor.feature.feature.group,org.fusesource.ide.core.feature.feature.group,org.fusesource.ide.jmx.feature.feature.group,org.fusesource.ide.server.extensions.feature.feature.group,org.guvnor.tools.feature.feature.group,org.jboss.tools.bpel.feature.feature.group,org.drools.eclipse.feature.feature.group,org.jboss.tools.esb.feature.feature.group,org.jbpm.eclipse.feature.feature.group,org.jboss.tools.runtime.drools.detector.feature.feature.group,org.jboss.tools.runtime.esb.detector.feature.feature.group,org.jboss.tools.runtime.jbpm.detector.feature.feature.group,org.switchyard.tools.bpel.feature.feature.group,org.switchyard.tools.bpmn2.feature.feature.group,org.switchyard.tools.feature.feature.group
else
   usage
fi

