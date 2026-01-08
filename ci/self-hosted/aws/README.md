# Harness

This guide walks you through setting up a Harness Delegate on an AWS EC2 instance with a self-hosted build pool.

## Requirements

- AWS EC2 instance (Ubuntu recommended)
- Docker installed on the instance
- AWS CLI installed and configured
- Harness account with appropriate permissions

## 1: IAM Role

Create an IAM role to give the Delegate instance permission to manage the build pool.

**Role Name:** `HarnessEC2SelfHosted`

**Required Permissions:**
- EC2 instance management (launch, terminate, describe)
- Ability to manage instances in the specified region and availability zone

**Attach this role to your Delegate EC2 instance:**
1. Go to AWS Console → EC2 → Select your instance
2. Actions → Security → Modify IAM role
3. Select `HarnessEC2SelfHosted` role

## 2 Pool File

Create a pool file to define the instances available to execute the CI process. You can have specific pools for Linux, Windows, and MacOS. Instances can be configured to hibernate to avoid additional costs when not in use.

**Create file:** `pool.yml`
```yaml

https://developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/vm-build-infrastructure/set-up-an-aws-vm-build-infrastructure#pool-settings-reference

