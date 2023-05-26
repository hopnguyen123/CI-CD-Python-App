// DynamoDBModule.groovy
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder
import com.amazonaws.services.dynamodbv2.model.PutItemRequest
import com.amazonaws.services.dynamodbv2.model.AttributeValue
import com.amazonaws.regions.Regions
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB

class DynamoDBModule {
    static void putItemToDynamoDB(credentialsProvider, Map<String, AttributeValue> item) {
        // Create dynamoDBClient
        def dynamoDBClient = AmazonDynamoDBClientBuilder.standard()
            .withRegion(Regions.AP_SOUTHEAST_1)
            .withCredentials(credentialsProvider)
            .build()

        // put Item to dynamoDB table
        def putItemRequest = new PutItemRequest()
            .withTableName('example-table')
            .withItem(item)

        dynamoDBClient.putItem(putItemRequest)
    }
}
