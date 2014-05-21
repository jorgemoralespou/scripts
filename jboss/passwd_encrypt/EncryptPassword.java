import java.security.MessageDigest;
import java.math.BigInteger;
import org.jboss.crypto.CryptoUtil;

public class EncryptPassword
  {
    public static void main(String ar[]) throws Exception
     {
       /*
       You will need the following JAFRs in your classpath in order to compile & run this program
       export CLASSPATH=$JBOSS_HOME/modules/org/picketbox/main/picketbox-4.0.7.Final.jar:$JBOSS_HOME/bin/client/jboss-client.jar:$CLASSPATH:.:
       */

       String clearTextPassword=ar[0]+":ManagementRealm:"+ar[1];     //---> This is how JBoss Encrypts password

       //String clearTextPassword=ar[0];
       String hashedPassword=CryptoUtil.createPasswordHash("MD5", "hex", null, null, clearTextPassword);
       //System.out.println("clearTextPassword: "+clearTextPassword);
       //System.out.println("hashedPassword: "+hashedPassword);
       System.out.println(hashedPassword);
     }
  }

