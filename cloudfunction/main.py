import base64
import json
from google.cloud import bigquery
from datetime import datetime

# Initialize BigQuery client
client = bigquery.Client()

# Set your dataset and table
table_id = "demo_dataset.events"  # No need for project_id if same project

def main(event, context):
    try:
        # Decode Pub/Sub message
        payload = base64.b64decode(event['data']).decode('utf-8')
        data = json.loads(payload)

        row = {
            "id": data.get("id"),
            "message": data.get("message"),
            "timestamp": datetime.utcnow().isoformat()
        }

        errors = client.insert_rows_json(table_id, [row])
        if errors:
            print(f"BigQuery insert errors: {errors}")
        else:
            print("Row successfully inserted.")
    except Exception as e:
        print(f"Error processing Pub/Sub message: {e}")