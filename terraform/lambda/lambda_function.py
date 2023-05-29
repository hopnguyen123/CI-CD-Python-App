import boto3
import datetime
import os

dynamodb = boto3.resource('dynamodb')

table_name=os.environ.get('DATABASE_NAME')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # 'expires_at': theo UTC -> giờ Việt Nam - 7 
    items = [
        {'deployment_id': 1, 'status': 'BUILDING','expires_at':"2023-05-29 13:00:00"},
        {'deployment_id': 2, 'status': 'BUILDING','expires_at':"2023-05-29 13:02:00"},
        {'deployment_id': 3, 'status': 'BUILDING','expires_at':"2023-05-29 13:04:00"},
        {'deployment_id': 4, 'status': 'BUILDING','expires_at':"2023-05-29 13:06:00"},
        {'deployment_id': 5, 'status': 'BUILDING','expires_at':"2023-05-29 13:08:00"},

        {'deployment_id': 6, 'status': 'BUILDING','expires_at':"2023-05-29 13:10:00"},
        {'deployment_id': 7, 'status': 'BUILDING','expires_at':"2023-05-29 13:12:00"},
        {'deployment_id': 8, 'status': 'BUILDING','expires_at':"2023-05-29 13:14:00"},
        {'deployment_id': 9, 'status': 'BUILDING','expires_at':"2023-05-29 13:16:00"},
        {'deployment_id': 10, 'status': 'BUILDING','expires_at':"2023-05-29 13:18:00"},

        {'deployment_id': 11, 'status': 'BUILDING','expires_at':"2023-05-29 13:20:00"},
        {'deployment_id': 12, 'status': 'BUILDING','expires_at':"2023-05-29 13:22:00"},
        {'deployment_id': 13, 'status': 'BUILDING','expires_at':"2023-05-29 13:24:00"},
        {'deployment_id': 14, 'status': 'BUILDING','expires_at':"2023-05-29 13:26:00"},
        {'deployment_id': 15, 'status': 'BUILDING','expires_at':"2023-05-29 13:28:00"},

        {'deployment_id': 16, 'status': 'BUILDING','expires_at':"2023-05-29 13:40:00"},
        {'deployment_id': 17, 'status': 'BUILDING','expires_at':"2023-05-29 13:42:00"},
        {'deployment_id': 18, 'status': 'BUILDING','expires_at':"2023-05-29 13:44:00"},
        {'deployment_id': 19, 'status': 'BUILDING','expires_at':"2023-05-29 13:46:00"},
        {'deployment_id': 20, 'status': 'BUILDING','expires_at':"2023-05-29 13:48:00"},

        {'deployment_id': 21, 'status': 'BUILDING','expires_at':"2023-05-29 13:50:00"},
        {'deployment_id': 22, 'status': 'BUILDING','expires_at':"2023-05-29 13:52:00"},
        {'deployment_id': 23, 'status': 'BUILDING','expires_at':"2023-05-29 13:54:00"},
        {'deployment_id': 24, 'status': 'BUILDING','expires_at':"2023-05-29 13:56:00"},
        {'deployment_id': 25, 'status': 'BUILDING','expires_at':"2023-05-29 13:58:00"}
    ]

    for item in items:
        table.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': 'Item created',
    }
