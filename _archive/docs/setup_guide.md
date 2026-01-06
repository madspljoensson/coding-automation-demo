# Setup Guide

Complete step-by-step guide to set up the AI-Driven Coding Automation system.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Azure DevOps Setup](#azure-devops-setup)
3. [GitHub Setup](#github-setup)
4. [Azure Setup](#azure-setup)
5. [Configuration](#configuration)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

Before starting, ensure you have:

- [ ] Azure DevOps organization admin access
- [ ] GitHub organization owner access
- [ ] Azure subscription with contributor rights
- [ ] GitHub Copilot Business license
- [ ] Bash/PowerShell terminal access

### Software Requirements

- Git 2.30+
- Azure CLI 2.40+
- GitHub CLI 2.20+ (optional but recommended)
- Python 3.9+ OR Node.js 18+
- curl or wget

## Azure DevOps Setup

### Step 1: Create Personal Access Token (PAT)

1. Navigate to Azure DevOps: `https://dev.azure.com/{your-org}`
2. Click on User Settings (top right) → Personal Access Tokens
3. Click "New Token"
4. Configure:
   - **Name**: `GitHub Copilot Agent Integration`
   - **Organization**: Select your org
   - **Expiration**: 90 days (or custom)
   - **Scopes**: Custom defined
     - ✅ Work Items: Read, Write, & Manage
     - ✅ Code: Read
     - ✅ Build: Read
5. Click "Create"
6. **IMPORTANT**: Copy the token immediately (you won't see it again)

Save as: `AZURE_DEVOPS_PAT`

### Step 2: Create Service Hook

1. Go to Project Settings → Service Hooks
2. Click "Create subscription"
3. Select "Web Hooks"
4. Click "Next"

**Trigger Configuration:**

- **Trigger on**: Work item created
- **Area path**: (All)
- **Work item type**: Task, Bug, User Story (select relevant types)
- Click "Next"

**Action Configuration:**

- **URL**: `https://api.github.com/repos/{owner}/{repo}/dispatches`
  - Replace `{owner}/{repo}` with your GitHub repository
- **HTTP headers**:

```
Authorization: Bearer {GITHUB_TOKEN}
Content-Type: application/json
```

- **Resource details to send**: All
- **Messages to send**: All
- Click "Test" then "Finish"

### Step 3: Test the Hook

1. Create a test work item in Azure DevOps
2. Check that the webhook was triggered (Service Hooks → History)
3. Verify GitHub received the webhook (Settings → Webhooks → Recent Deliveries)

## GitHub Setup

### Step 1: Enable GitHub Copilot

1. Go to GitHub Organization Settings
2. Navigate to Copilot
3. Enable Copilot for your organization
4. Ensure "Copilot Agent" features are enabled (if available)

### Step 2: Create GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens
2. Click "Generate new token"
3. Configure:
   - **Name**: `ADO Agent Integration`
   - **Expiration**: 90 days
   - **Repository access**: Select specific repositories
   - **Permissions**:
     - ✅ Contents: Read and write
     - ✅ Pull requests: Read and write
     - ✅ Workflows: Read and write
     - ✅ Metadata: Read
4. Click "Generate token"
5. Copy the token

Save as: `GITHUB_TOKEN`

### Step 3: Configure Repository Secrets

1. Go to your repository → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add each of these secrets:

| Name | Value | Notes |
|------|-------|-------|
| `AZURE_DEVOPS_PAT` | (from ADO setup) | Azure DevOps PAT |
| `AZURE_CLIENT_ID` | (from Azure setup below) | Service Principal ID |
| `AZURE_CLIENT_SECRET` | (from Azure setup below) | Service Principal Secret |
| `AZURE_TENANT_ID` | (from Azure portal) | Your Azure AD Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | (from Azure portal) | Target subscription ID |

### Step 4: Create GitHub Actions Workflow

Create `.github/workflows/agent-trigger.yml`:

```yaml
name: Copilot Agent Task

on:
  repository_dispatch:
    types: [azure-devops-work-item]

jobs:
  agent-task:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Parse work item
        id: parse
        run: |
          echo "work_item_id=${{ github.event.client_payload.resource.id }}" >> $GITHUB_OUTPUT
          echo "work_item_title=${{ github.event.client_payload.resource.fields['System.Title'] }}" >> $GITHUB_OUTPUT
      
      - name: Create Copilot Agent task
        run: |
          # Placeholder - implement agent invocation
          echo "Work Item: ${{ steps.parse.outputs.work_item_id }}"
          echo "Title: ${{ steps.parse.outputs.work_item_title }}"
      
      # TODO: Add actual Copilot Agent invocation
```

## Azure Setup

### Step 1: Create Service Principal

```bash
# Login to Azure
az login

# Set subscription
az account set --subscription "Your Subscription Name"

# Create service principal
az ad sp create-for-rbac --name "github-copilot-agent" \
  --role contributor \
  --scopes /subscriptions/{subscription-id} \
  --sdk-auth

# Output will include:
# {
#   "clientId": "...",          <- AZURE_CLIENT_ID
#   "clientSecret": "...",      <- AZURE_CLIENT_SECRET
#   "tenantId": "...",          <- AZURE_TENANT_ID
#   "subscriptionId": "..."     <- AZURE_SUBSCRIPTION_ID
# }
```

Save these values to GitHub Secrets.

### Step 2: Create Sandbox Resource Group (Optional)

```bash
# Create resource group for testing
az group create \
  --name rg-copilot-agent-sandbox \
  --location eastus \
  --tags environment=sandbox purpose=ai-automation
```

### Step 3: Assign Permissions

```bash
# Assign reader role (for read-only operations)
az role assignment create \
  --assignee {clientId} \
  --role Reader \
  --scope /subscriptions/{subscription-id}/resourceGroups/rg-copilot-agent-sandbox
```

## Configuration

### Step 1: Clone Repository

```bash
git clone https://github.com/{owner}/{repo}.git
cd {repo}
```

### Step 2: Create .env File

```bash
cp .env.example .env
```

Edit `.env` with your values:

```bash
# Azure DevOps
AZURE_DEVOPS_ORG_URL=https://dev.azure.com/your-org
AZURE_DEVOPS_PROJECT=YourProject
AZURE_DEVOPS_PAT=your-pat-here

# Azure
AZURE_TENANT_ID=your-tenant-id
AZURE_SUBSCRIPTION_ID=your-subscription-id
AZURE_CLIENT_ID=your-client-id
AZURE_CLIENT_SECRET=your-client-secret

# GitHub
GITHUB_TOKEN=your-github-token
GITHUB_REPOSITORY=owner/repo

# Agent Configuration
AGENT_MAX_TASKS_PER_HOUR=10
AGENT_TIMEOUT_MINUTES=30
```

### Step 3: Validate Configuration

```bash
# Test Azure DevOps connection
python scripts/test_ado_connection.py

# Test Azure connection
az account show

# Test GitHub connection
gh auth status
```

## Testing

### Test 1: Service Hook

1. Create a test work item in Azure DevOps:
   - **Type**: Task
   - **Title**: "[TEST] Verify webhook integration"
   - **Description**: "This is a test work item"

2. Check GitHub Actions:
   - Go to Actions tab
   - Verify workflow was triggered
   - Check logs for work item details

### Test 2: Manual Trigger

```bash
# Manually trigger the workflow
gh workflow run agent-trigger.yml
```

### Test 3: End-to-End

1. Create a real work item for a simple task
2. Assign to the agent
3. Monitor the workflow execution
4. Verify PR is created
5. Review and merge the PR

## Troubleshooting

### Service Hook Not Triggering

**Symptom**: Work items created in ADO don't trigger GitHub Actions

**Solutions**:
1. Check Service Hook history in ADO for errors
2. Verify webhook URL is correct
3. Check GitHub_TOKEN has correct permissions
4. Test webhook manually using curl:

```bash
curl -X POST \
  https://api.github.com/repos/{owner}/{repo}/dispatches \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"event_type":"azure-devops-work-item","client_payload":{}}'
```

### Authentication Errors

**Symptom**: "401 Unauthorized" errors in logs

**Solutions**:
1. Verify all tokens are current (not expired)
2. Check token permissions/scopes
3. Regenerate tokens if needed
4. Verify secrets are correctly named in GitHub

### Agent Task Fails

**Symptom**: Workflow runs but agent doesn't create PR

**Solutions**:
1. Check GitHub Actions logs for errors
2. Verify Copilot license is active
3. Ensure work item description is clear
4. Check rate limits haven't been hit

## Next Steps

Once setup is complete:

1. ✅ Review [Architecture Documentation](architecture.md)
2. ✅ Read [Contributing Guidelines](../CONTRIBUTING.md)
3. ✅ Try example use cases in `agents/examples/`
4. ✅ Configure monitoring and alerting
5. ✅ Customize agent prompts for your needs

## Support

- Issues: [GitHub Issues](https://github.com/{owner}/{repo}/issues)
- Documentation: [docs/](.)
- Email: [maintainer email]

---

**Setup complete!** 🎉 You're ready to automate DevOps tasks with AI.

