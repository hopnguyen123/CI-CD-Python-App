import com.amazonaws.services.dynamodbv2.model.AttributeValue
import AWSCredentialsModule
import DynamoDBModule
import DateUtilsModule

def call(String deploymentId, String groupId, String owner, String cleanupUrl, String expires_at) {

    //CredentialProvider AWS
    def credentialsProvider = AWSCredentialsModule.getAWSCredentials()
    echo "CredentialProvider: ${credentialsProvider}"
    
    // Format Date
    def formattedDate = DateUtilsModule.formatExpiryDate(expires_at)
    echo "FormatDate: ${formattedDate}"
    
    // Item
    def item = [
        'deployment_id': new AttributeValue().withN(deploymentId),
        'status': new AttributeValue('BUILDING'),
        'expires_at': new AttributeValue(formattedDate),
        'group_id': new AttributeValue(groupId),
        'owner': new AttributeValue(owner),
        'cleanup_url': new AttributeValue(cleanupUrl),
        'comment': new AttributeValue(''),
        'deployed_at': new AttributeValue(''),
        'metadata': new AttributeValue(''),
        'stacks': new AttributeValue('')
    ]
    echo "item: ${item}"

    // Put item to DynamoDB table
    DynamoDBModule.putItemToDynamoDB(credentialsProvider, item)  
    echo '-------- Data sent to DynamoDB table: DONE ----------'
}
