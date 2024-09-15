#!/bin/bash
# Example deployment script
echo "Deploying model..."
aws sagemaker create-endpoint --endpoint-name my-endpoint --endpoint-config-name my-endpoint-config
