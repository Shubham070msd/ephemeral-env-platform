#!/bin/bash

EXPIRE_TIME=30  # 30 seconds
DEPLOYED_AT_FILE="deployed_at.txt"

if [ ! -f "$DEPLOYED_AT_FILE" ]; then
  echo "No deployment timestamp found. Creating now..."
  date +%s > "$DEPLOYED_AT_FILE"
  echo "Auto-destroy timer started."
  exit 0
fi

DEPLOYED_AT=$(cat $DEPLOYED_AT_FILE)
NOW=$(date +%s)
ELAPSED=$((NOW - DEPLOYED_AT))

if [ "$ELAPSED" -ge "$EXPIRE_TIME" ]; then
  echo "Environment expired after $ELAPSED seconds. Destroying..."
  cd "$(dirname "$0")/../terraform" || exit 1
  terraform destroy -auto-approve
else
  echo "Environment still active. $((EXPIRE_TIME - ELAPSED))s remaining."
fi
