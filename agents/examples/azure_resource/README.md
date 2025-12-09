# Azure Resource Changes Example

Example of automated Azure infrastructure changes via IaC.

## Scenario

**Work Item**: #12350 - "Add storage account for application logs"

## Requirements

- Create new storage account in dev resource group
- Configure for blob storage
- Enable soft delete and versioning
- Tag appropriately
- Update application configuration

## Files Modified

- `infrastructure/bicep/storage.bicep` - New storage account definition
- `infrastructure/bicep/parameters.dev.json` - Parameters for dev environment
- `scripts/deploy-storage.sh` - Deployment script
- `docs/infrastructure.md` - Updated documentation

## Expected Infrastructure Code

```bicep
// infrastructure/bicep/storage.bicep
param storageAccountName string
param location string = resourceGroup().location
param environment string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
  tags: {
    environment: environment
    purpose: 'application-logs'
    managedBy: 'bicep'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 30
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 30
    }
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
```

## Deployment Script

```bash
#!/bin/bash
# scripts/deploy-storage.sh

set -e

ENVIRONMENT=${1:-dev}
RESOURCE_GROUP="rg-myapp-${ENVIRONMENT}"
LOCATION="eastus"

echo "Deploying storage account to ${ENVIRONMENT}..."

# Validate template
az deployment group validate \
  --resource-group $RESOURCE_GROUP \
  --template-file infrastructure/bicep/storage.bicep \
  --parameters infrastructure/bicep/parameters.${ENVIRONMENT}.json

# Deploy
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file infrastructure/bicep/storage.bicep \
  --parameters infrastructure/bicep/parameters.${ENVIRONMENT}.json \
  --mode Incremental

echo "Deployment complete!"
```

## Agent Workflow

1. ✅ Parse work item requirements
2. ✅ Create Bicep template for storage account
3. ✅ Add security best practices (TLS 1.2, HTTPS only)
4. ✅ Configure soft delete for data protection
5. ✅ Create deployment script
6. ✅ Update documentation
7. ✅ Create PR with all changes

## Safety Checks

- [ ] Template validates successfully
- [ ] Security settings meet organization standards
- [ ] Cost estimate provided
- [ ] Rollback procedure documented
- [ ] Human approval required before deployment

## Cost Estimate

**Storage Account (Standard_LRS)**:
- Storage: ~$0.02/GB/month
- Transactions: Minimal for logs
- Estimated monthly: ~$5-10 depending on usage

## Time Savings

- **Manual**: 1.5-2 hours (research, write IaC, test, document)
- **Agent**: 8-12 minutes
- **Speedup**: ~10x

## Post-Merge Actions

After PR is approved and merged:

1. CI/CD pipeline automatically runs deployment
2. Storage account created in Azure
3. Application configuration updated
4. Work item automatically marked complete

## Validation

```bash
# Verify storage account was created
az storage account show \
  --name stamyappdev001 \
  --resource-group rg-myapp-dev

# Check security settings
az storage account show \
  --name stamyappdev001 \
  --query '{https:supportsHttpsTrafficOnly,tls:minimumTlsVersion}'
```

