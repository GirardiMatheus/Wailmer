#!/bin/bash

echo "⏳ Removing restart policy from all containers..."

for container in $(docker ps -aq); do
  name=$(docker inspect --format='{{.Name}}' "$container" | sed 's/^\/\(.*\)/\1/')
  policy=$(docker inspect --format='{{.HostConfig.RestartPolicy.Name}}' "$container")

  if [[ "$policy" != "no" ]]; then
    echo "🚫 Updating $name (policy: $policy) → no"
    docker update --restart=no "$container"
  else
    echo "✅ $name already has restart policy: no"
  fi
done

echo "✅ All containers updated."
