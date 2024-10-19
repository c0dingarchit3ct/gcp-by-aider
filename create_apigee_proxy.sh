#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if required arguments are provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <project_id> <apigee_org> <apigee_env> <cloud_run_url>"
    exit 1
fi

PROJECT_ID=$1
APIGEE_ORG=$2
APIGEE_ENV=$3
CLOUD_RUN_URL=$4
# set current project 
echo "setting project " 
gcloud config set project $PROJECT_ID

# Extract the service name from the Cloud Run URL
SERVICE_NAME=$(echo $CLOUD_RUN_URL | awk -F[/:] '{print $4}')

# Create a new Apigee API proxy
echo "Creating Apigee API proxy..."
gcloud apigee apis create $SERVICE_NAME \
    --organization=$APIGEE_ORG \
    --project=$PROJECT_ID

# Update the target endpoint of the proxy to point to the Cloud Run service
echo "Updating target endpoint..."
gcloud apigee apis update $SERVICE_NAME \
    --organization=$APIGEE_ORG \
    --project=$PROJECT_ID \
    --target-url=$CLOUD_RUN_URL

# Deploy the API proxy to the specified environment
echo "Deploying API proxy..."
gcloud apigee apis deploy $SERVICE_NAME \
    --organization=$APIGEE_ORG \
    --environment=$APIGEE_ENV \
    --project=$PROJECT_ID

echo "Apigee proxy '$SERVICE_NAME' has been created and deployed, connecting to Cloud Run service at $CLOUD_RUN_URL"
