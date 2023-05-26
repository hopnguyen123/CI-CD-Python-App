import boto3
import datetime
import os

dynamodb = boto3.resource('dynamodb')

table_name=os.environ.get('DATABASE_NAME')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Scan item -> change
    response = table.scan()
    items = response['Items']
    while 'LastEvaluatedKey' in response:
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        items.extend(response['Items'])
    for item in items:
        current_time = str(datetime.datetime.now())    
        timestamp2 = item['expires_at']
        if current_time > timestamp2:
            # print(f"Need to run cleanup jobs {item['deployment_id']}")
            print(f"{current_time} > {timestamp2}")
            item['status']='DESTROYING'
            table.put_item(Item=item)
        else:
            print(f"{current_time} <= {timestamp2}")

    return items