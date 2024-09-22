#!/bin/bash

# Connect to the database and insert test data
docker exec a-hub-db psql -U academic_hub_owner -d academic_hub -c "
CREATE TABLE IF NOT EXISTS test_volume (id SERIAL PRIMARY KEY, message TEXT);
INSERT INTO test_volume (message) VALUES ('Test data for volume persistence');
"

# Restart the container
docker restart a-hub-db

# Wait for the container to be ready
sleep 10

# Check if the data persists
result=$(docker exec a-hub-db psql -U academic_hub_owner -d academic_hub -t -c "SELECT message FROM test_volume LIMIT 1;")

if [[ $result == *"Test data for volume persistence"* ]]; then
  echo "Volume test passed: Data persisted after container restart"
else
  echo "Volume test failed: Data did not persist"
fi
