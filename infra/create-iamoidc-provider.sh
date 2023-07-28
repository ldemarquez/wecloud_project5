#!/bin/sh
#
#Variables
CLUSTER_NAME=eksp6
REGION=us-east-1



eksctl utils associate-iam-oidc-provider \
    --region $REGION \
    --cluster $CLUSTER_NAME \
    --approve
