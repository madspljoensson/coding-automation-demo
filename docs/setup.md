# Setup Guide

## Prerequisites

- GitHub Copilot Pro or Business license
- Azure subscription with Azure AD access
- GitHub repository with Actions enabled

## Step 1: Configure GitHub Secrets

Go to **Settings > Secrets and variables > Actions** and add:

| Secret | Description |
|--------|-------------|
| `AZURE_CREDENTIALS` | Service Principal JSON for Azure CLI |
| `AZURE_TENANT_ID` | Your Azure AD tenant ID |

### Create Service Principal

```bash
az ad sp create-for-rbac --name "github-agent" \
  --role "Directory Readers" \
  --scopes /subscriptions/{subscription-id} \
  --sdk-auth
```

For group management, grant Microsoft Graph permissions:
- `User.Read.All`
- `GroupMember.ReadWrite.All`

## Step 2: Enable Copilot for Repository

1. Go to repository **Settings > Copilot**
2. Enable Copilot access
3. Allow Copilot to be assigned to issues

## Step 3: Create the `agent-task` Label

1. Go to **Issues > Labels**
2. Create new label: `agent-task`
3. Color suggestion: `#7057ff` (purple)

## Step 4: Test

1. Create a new issue: "Add test.user@solita.dk to TestGroup"
2. Add the `agent-task` label
3. Watch the Actions tab for the workflow
4. Review the PR when created

## Troubleshooting

- **Workflow not triggering**: Check Actions permissions in Settings
- **Copilot not responding**: Verify Copilot is enabled for the repo
- **Azure commands failing**: Check service principal permissions

