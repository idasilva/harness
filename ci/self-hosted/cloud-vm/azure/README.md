# Harness

This guide walks you through setting up a Harness Delegate on an AWS EC2 instance with a self-hosted build pool.


## Requirements

- Azure subscription with appropriate permissions
- Azure VM (Ubuntu recommended)
- Docker installed on the instance
- Delegate install on the VM.
- VM Build runner install on the VM.
- Azure CLI installed and configured
- Harness account with appropriate permissions


# Drone/Harness Azure Runner - Standard SKU Public IP Fix

## Problem Overview

**Issue:** Azure runner fails with error:
```
ERROR CODE: IPv4BasicSkuPublicIpCountLimitReached
Message: Cannot create more than 0 IPv4 Basic SKU public IP addresses for this subscription in this region.
```

**Root Cause:** Azure retired Basic SKU public IPs on September 30, 2025. The Drone runner was hardcoded to create Basic SKU public IPs, which are no longer allowed by Azure.

**Solution:** Modified the `createPublicIP` function to explicitly use Standard SKU instead of defaulting to Basic SKU.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Detailed Fix Instructions](#detailed-fix-instructions)
3. [Build Process](#build-process)
4. [Deployment Options](#deployment-options)
5. [Common Issues & Solutions](#common-issues--solutions)
6. [Configuration Reference](#configuration-reference)
7. [Testing & Verification](#testing--verification)

---

## Quick Start

### Using Pre-built Docker Image

```bash
# Pull the fixed image
docker pull idasilva6/drone-runner-aws:v1.0.0

# Stop old runner
docker stop drone-runner-aws && docker rm drone-runner-aws

# Run new runner
docker run -d \
  --name drone-runner-aws \
  --restart always \
  -p 3000:3000 \
  -v /runner/pool.yml:/app/pool.yml \
  idasilva6/drone-runner-aws:v1.0.0 \
  daemon --pool-file=/app/pool.yml

# Check logs
docker logs -f drone-runner-aws
```

---

## Detailed Fix Instructions

### 1. Fork and Clone Repository

```bash
# Fork on GitHub: https://github.com/drone-runners/drone-runner-aws

# Clone your fork
git clone https://github.com/YOUR_USERNAME/drone-runner-aws.git
cd drone-runner-aws

# Create fix branch
git checkout -b fix/azure-standard-sku-public-ip
```

### 2. Code Changes

**File:** `internal/drivers/azure/azure_network.go` (or similar path)

**Find the `createPublicIP` function:**

```go
func (c *config) createPublicIP(ctx context.Context, publicIPName string) (*armnetwork.PublicIPAddress, error) {
	logr := logger.FromContext(ctx)
	publicIPAddressClient, err := armnetwork.NewPublicIPAddressesClient(c.subscriptionID, c.cred, nil)
	if err != nil {
		return nil, err
	}
	parameters := armnetwork.PublicIPAddress{
		Location: to.Ptr(c.location),
		Zones:    c.zones,
		Properties: &armnetwork.PublicIPAddressPropertiesFormat{
			PublicIPAllocationMethod: to.Ptr(armnetwork.IPAllocationMethodStatic),
		},
	}
	// ... rest of function
}
```

**Add SKU specification (add these 3 lines after `Zones: c.zones,`):**

```go
func (c *config) createPublicIP(ctx context.Context, publicIPName string) (*armnetwork.PublicIPAddress, error) {
	logr := logger.FromContext(ctx)
	publicIPAddressClient, err := armnetwork.NewPublicIPAddressesClient(c.subscriptionID, c.cred, nil)
	if err != nil {
		return nil, err
	}
	parameters := armnetwork.PublicIPAddress{
		Location: to.Ptr(c.location),
		Zones:    c.zones,
		SKU: &armnetwork.PublicIPAddressSKU{                              // ← ADD THIS
			Name: to.Ptr(armnetwork.PublicIPAddressSKUNameStandard),  // ← ADD THIS
		},                                                                // ← ADD THIS
		Properties: &armnetwork.PublicIPAddressPropertiesFormat{
			PublicIPAllocationMethod: to.Ptr(armnetwork.IPAllocationMethodStatic),
		},
	}
	// ... rest of function
}
```

### 3. Commit Changes

```bash
git add .
git commit -m "fix: use Standard SKU for Azure public IPs instead of deprecated Basic SKU

Azure retired Basic SKU public IPs on September 30, 2025. This change
updates the createPublicIP function to explicitly use Standard SKU,
which is now required for all new public IP addresses in Azure.

Fixes error: 'Cannot create more than 0 IPv4 Basic SKU public IP addresses'"

git push origin fix/azure-standard-sku-public-ip
```

---

## Build Process

### Build with Docker (Multi-arch support)

#### Dockerfile (Debian-based)

```dockerfile
# First Stage: Build environment
FROM golang:1.24rc1-bookworm AS builder

RUN apt-get update && apt-get install -y \
    ca-certificates \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Allow Go 1.23 to build if needed
ENV GOTOOLCHAIN=auto

# Fetch dependencies
RUN go mod download

# Build the application
RUN CGO_ENABLED=1 go build -o /app/drone-runner-aws

# Second Stage: Final lightweight image
FROM debian:bookworm-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Create database file
RUN touch database.sqlite3 && chmod 666 /app/database.sqlite3

# Copy binary from builder
COPY --from=builder /app/drone-runner-aws ./drone-runner-aws
RUN chmod +x ./drone-runner-aws

# Run as non-root user
RUN useradd -r -u 1000 runner
RUN chown -R runner:runner /app
USER runner

EXPOSE 3000

ENTRYPOINT ["/app/drone-runner-aws"]
```

#### Build and Push Commands

```bash
# Build for multiple architectures
docker buildx create --use

# Build and push
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t your-username/drone-runner-aws:v1.0.0 \
  --push \
  .

# Or build locally for single architecture
docker build -t your-username/drone-runner-aws:v1.0.0 .
docker push your-username/drone-runner-aws:v1.0.0
```


### Issue: Authentication/Permission Errors

**Error:**
```
Authorization failed or access denied
```

**Solution:** Verify service principal has correct permissions:

```bash
# Check current role assignments
az role assignment list \
  --assignee <client-id> \
  --output table

# Add Contributor role if missing
az role assignment create \
  --assignee <client-id> \
  --role Contributor \
  --scope /subscriptions/<subscription-id>
```

Required permissions:
- ✅ Virtual Machine Contributor
- ✅ Network Contributor
- ✅ Contributor (recommended)

---

## Configuration Reference

### Minimal pool.yml

```yaml
version: "1"
instances:
  - name: ubuntu-azure-pool
    default: true
    type: azure
    pool: 2
    limit: 4
    platform:
      os: linux
      arch: amd64
    spec:
      account:
        client_id: YOUR_CLIENT_ID
        client_secret: YOUR_CLIENT_SECRET
        subscription_id: YOUR_SUBSCRIPTION_ID
        tenant_id: YOUR_TENANT_ID
      location: eastus
      size: Standard_B1s
      tags:
        environment: ci
        team: devops
      image:
        username: azureuser
        password: YourStrongPassword123!
        publisher: Canonical
        offer: ubuntu-24_04-lts
        sku: server
        version: latest
```
---

## Testing & Verification

### 1. Check Runner is Running

```bash
docker ps | grep drone-runner
docker logs drone-runner-aws
```

Expected output:
```
Name                                          SKU
--------------------------------------------  --------
runner-ubuntu-azure-pool-xyz-publicip        Standard  ✅
```


### Update Docker Image

```bash
# Pull new image
docker pull idasilva6/drone-runner-aws:v1.0.1

# Stop and remove old container
docker stop drone-runner-aws
docker rm drone-runner-aws

# Start with new image
docker run -d \
  --name drone-runner-aws \
  --restart always \
  -p 3000:3000 \
  -v /runner/pool.yml:/app/pool.yml \
  idasilva6/drone-runner-aws:v1.0.1 \
  daemon --pool-file=/app/pool.yml
```

---