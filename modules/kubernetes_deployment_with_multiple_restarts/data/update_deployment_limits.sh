#!/bin/bash
# Set the name of the deployment

DEPLOYMENT_NAME=${DEPLOYMENT_NAME}

# Set the namespace of the deployment

NAMESPACE=${NAMESPACE}

# Set the new CPU and memory limits

NEW_CPU_LIMIT="PLACEHOLDER"

NEW_MEM_LIMIT="PLACEHOLDER"

# Update the deployment with the new limits

kubectl set resources deployment $DEPLOYMENT_NAME -n $NAMESPACE --limits=cpu=$NEW_CPU_LIMIT,memory=$NEW_MEM_LIMIT