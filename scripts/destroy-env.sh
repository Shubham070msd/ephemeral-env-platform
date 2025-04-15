#!/bin/bash
cd "$(dirname "$0")/../terraform" || exit 1

echo "Destroying environment"

terraform destroy -auto-approve
