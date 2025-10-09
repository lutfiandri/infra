#!/bin/bash

# Wait for Portainer to be ready with shorter intervals
echo "Waiting for Portainer to be ready..."
for i in {1..30}; do
  if curl -f http://portainer:9000/api/status > /dev/null 2>&1; then
    echo "Portainer is ready!"
    break
  fi
  echo "Attempt $i/30: Portainer not ready yet..."
  sleep 2
done

# Create admin user if it doesn't exist
echo "Setting up admin user..."
curl -X POST http://portainer:9000/api/users/admin/init \
  -H "Content-Type: application/json" \
  -d "{
    \"Username\": \"${PORTAINER_ADMIN_USERNAME}\",
    \"Password\": \"${PORTAINER_ADMIN_PASSWORD}\"
  }" && echo "Admin user created successfully!" || echo "Admin user may already exist"

echo "Portainer initialization complete!"
