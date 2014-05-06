JBoss AS 7 Init.d script
====
Installation steps:

- Copy this script to /etc/init.d with the name that you want your instance to have (jboss-as, jboss-node1, jboss-sy, jboss-fsw1,...)
- Make it executable
- Create the appropiate configuration file in /etc/profile.d  (You can copy the sample one, and modify the contents accordingly)
- Register the script as a service (chkconfig --add jboss-AS). Remember to use the name you have provided. And if you want change levels
