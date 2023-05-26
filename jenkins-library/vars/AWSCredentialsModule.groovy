// AWSCredentialsModule.groovy
import com.cloudbees.plugins.credentials.CredentialsProvider
import com.cloudbees.plugins.credentials.Credentials
import com.amazonaws.auth.AWSStaticCredentialsProvider
import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.auth.AWSCredentialsProvider

class AWSCredentialsModule {
    static def getAWSCredentials() {
        // GetCredential AWS
        def getCredentials = CredentialsProvider.lookupCredentials(Credentials.class).find { Credentials -> Credentials.id == "aws-hopnn" }
        def credentials_id=getCredentials.id
        
        //Get AWS_Access_Key
        def accessKey = getCredentials.getAccessKey()

        //Get AWS_Access_Secret_Key
        def secretKey = getCredentials.getSecretKey()
    
        // Convert accessKey and secretKey to strings if needed
        String accessKeyString = accessKey.toString()
        String secretKeyString = secretKey.toString()

        // Create the AWS credentials provider using the retrieved credentials
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(
            new BasicAWSCredentials(accessKeyString,secretKeyString)
        )
        return credentialsProvider
    }
}
