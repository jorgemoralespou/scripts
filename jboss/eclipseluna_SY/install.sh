#!/usr/bin/env bash

: ${JBDS_BINARY:="eclipse-jee-luna-SR1-linux-gtk-x86_64.tar.gz"}
: ${DOWNLOAD_URL:="http://ftp.fau.de/eclipse/technology/epp/downloads/release/luna/SR1/eclipse-jee-luna-SR1-linux-gtk-x86_64.tar.gz"}
: ${INSTALL_PATH:="/tmp/eclipseluna"}
: ${JAVA_HOME:=$JAVA_HOME:-/usr/java/latest}
: ${SINGLE:=true}

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
echo "Checking for ${JBDS_BINARY}"
if [ ! -f ${JBDS_BINARY} ]
then
   echo "Not available. Downloading."
   curl ${DOWNLOAD_URL} -o ${JBDS_BINARY}
fi
if [ -f ${JBDS_BINARY} ]
then
   echo "Available"
   [ ! -e  ${INSTALL_PATH} ] && mkdir -p ${INSTALL_PATH}
   echo "Installing into ${INSTALL_PATH}"
   tar -xzf ${JBDS_BINARY} -C ${INSTALL_PATH} --strip-components=1
   # Verify that everything is fine
   [ ! -x ${INSTALL_PATH}/eclipse ] && echo "Something went wrong. Eclipse did not install correctly" && exit 255
   if [[ "$SINGLE" == "" ]]
   then
      echo "Updating eclipse to the latest"
      ${INSTALL_PATH}/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/luna/ -installIU org.eclipse.sdk.ide,org.eclipse.zest.core
      echo "Installing selected features from JBoss Tools"
      ${INSTALL_PATH}/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.jboss.org/jbosstools/updates/stable/luna/ -installIU org.jboss.tools.cdi.deltaspike.feature.feature.group,org.jboss.tools.cdi.feature.feature.group,org.jboss.tools.forge.feature.feature.group,org.hibernate.eclipse.feature.feature.group,org.jboss.tools.ws.jaxrs.feature.feature.group,org.jboss.tools.maven.cdi.feature.feature.group,org.jboss.tools.maven.feature.feature.group,org.jboss.tools.maven.jbosspackaging.feature.feature.group,org.jboss.tools.maven.sourcelookup.feature.feature.group,org.jboss.tools.ws.feature.feature.group,org.jboss.ide.eclipse.as.feature.feature.group,org.jboss.tools.jmx.feature.feature.group,org.jboss.tools.maven.apt.feature.feature.group
      echo "Installing SwitchYard tools"
      ${INSTALL_PATH}/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.jboss.org/jbosstools/updates/development/luna/integration-stack/ -installIU org.eclipse.bpmn2.feature.feature.group,org.eclipse.bpmn2.modeler.runtime.jboss.feature.group,org.eclipse.bpmn2.modeler.feature.group,org.fusesource.ide.camel.editor.feature.feature.group,org.guvnor.tools.feature.feature.group,org.jboss.tools.bpel.feature.feature.group,org.drools.eclipse.feature.feature.group,org.jbpm.eclipse.feature.feature.group,org.switchyard.tools.bpel.feature.feature.group,org.switchyard.tools.bpmn2.feature.feature.group,org.switchyard.tools.feature.feature.group
   else
      echo "Installing and updating eclipse, some JBoss Tools and some Integration Stack for SwitchYard"
      ${INSTALL_PATH}/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/luna/,http://download.jboss.org/jbosstools/updates/stable/luna/,http://download.jboss.org/jbosstools/updates/development/luna/integration-stack/ -installIU org.eclipse.sdk.ide,org.eclipse.zest.core,org.jboss.tools.cdi.deltaspike.feature.feature.group,org.jboss.tools.cdi.feature.feature.group,org.jboss.tools.forge.feature.feature.group,org.hibernate.eclipse.feature.feature.group,org.jboss.tools.ws.jaxrs.feature.feature.group,org.jboss.tools.maven.cdi.feature.feature.group,org.jboss.tools.maven.feature.feature.group,org.jboss.tools.maven.jbosspackaging.feature.feature.group,org.jboss.tools.maven.sourcelookup.feature.feature.group,org.jboss.tools.ws.feature.feature.group,org.jboss.ide.eclipse.as.feature.feature.group,org.jboss.tools.jmx.feature.feature.group,org.jboss.tools.maven.apt.feature.feature.group,org.eclipse.bpmn2.feature.feature.group,org.eclipse.bpmn2.modeler.runtime.jboss.feature.group,org.eclipse.bpmn2.modeler.feature.group,org.fusesource.ide.camel.editor.feature.feature.group,org.guvnor.tools.feature.feature.group,org.jboss.tools.bpel.feature.feature.group,org.drools.eclipse.feature.feature.group,org.jbpm.eclipse.feature.feature.group,org.switchyard.tools.bpel.feature.feature.group,org.switchyard.tools.bpmn2.feature.feature.group,org.switchyard.tools.feature.feature.group
   fi   
   echo "Everything went fine!!!"
   echo "Now you can run: "
   echo "   ${INSTALL_PATH}/eclipse"
else  
   echo "Something went wrong. Run script again!!!"
fi

