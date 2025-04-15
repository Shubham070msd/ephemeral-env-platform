#!/bin/bash

read -p "Enter GitHub repo URL: " REPO_URL
read -p "Enter branch name: " BRANCH

rm -rf app
git clone -b $BRANCH $REPO_URL app

if [ $? -ne 0 ]; then
  echo "Failed to clone repo or branch. Exiting."
  exit 1
fi

date +%s > deployed_at.txt

cd "$ROOT_DIR/terraform" || exit 1
terraform init
terraform apply -auto-approve
