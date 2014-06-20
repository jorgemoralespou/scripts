#!/usr/bin/env bash

: ${JBDS_BINARY:="jbdevstudio-product-universal-7.1.1.GA-v20140314-2145-B688.jar"}
: ${INSTALL_PATH:="/tmp/jbdevstudio"}
: ${JAVA_HOME:=$JAVA_HOME:-/usr/java/latest}

#
# Install JBDS & Integration Stack plugins
#
if [ -f ${JBDS_BINARY} ]
then
   echo "Installing JBDS and Integration Stack plugins"
   # Install JBDS
   cp install-config.xml /tmp/install-config.xml
   sed -i -e "s/%PATH%/$(echo ${INSTALL_PATH} | sed -e 's/[\/&]/\\&/g')/g"  /tmp/install-config.xml
   sed -i -e "s/%JRE%/$(echo ${JAVA_HOME}/bin/java | sed -e 's/[\/&]/\\&/g')/g"  /tmp/install-config.xml
   java -jar ${JBDS_BINARY} /tmp/install-config.xml
   rm /tmp/install-config.xml 
   
   echo "Installing Integration Stack"
   # Install Integration Stack
   ${INSTALL_PATH}/jbdevstudio -nosplash -application org.eclipse.equinox.p2.director -repository https://devstudio.jboss.com/updates/7.0/,https://devstudio.jboss.com/updates/7.0/integration-stack/ -installIU org.eclipse.bpmn2.feature.feature.group,org.eclipse.bpmn2.modeler.feature.feature.group,org.eclipse.bpmn2.modeler.jboss.runtime.feature.feature.group,org.fusesource.ide.camel.editor.feature.feature.group,org.fusesource.ide.runtimes.feature.feature.group,org.fusesource.ide.server.extensions.feature.feature.group,org.guvnor.tools.feature.feature.group,org.jboss.tools.bpel.feature.feature.group,org.jboss.tools.esb.feature.feature.group,org.jboss.tools.jbpm.common.feature.feature.group,org.jboss.tools.jbpm.convert.feature.feature.group,org.jboss.tools.jbpm3.feature.feature.group,org.jboss.tools.runtime.drools.detector.feature.feature.group,org.jboss.tools.runtime.esb.detector.feature.feature.group,org.jboss.tools.runtime.jbpm.detector.feature.feature.group,org.jbpm.eclipse.feature.feature.group,org.switchyard.tools.bpel.feature.feature.group,org.switchyard.tools.bpmn2.feature.feature.group,org.switchyard.tools.feature.feature.group
else
   echo "Download JBoss Developer Studio from here: http://www.jboss.org/products/devstudio/overview/"
   echo ""
   echo "Run this script again."
   echo ""
   echo "To configure installation you can set following environment variables:"
   echo " JBDS_BINARY  - Current value=${JBDS_BINARY}"
   echo " INSTALL_PATH - Current value=${INSTALL_PATH}"
   echo " JAVA_HOME    - Current value=${JAVA_HOME}"
fi

