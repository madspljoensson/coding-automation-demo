# Scripts

Utility scripts for the AI-Driven Coding Automation system.

## Overview

This directory contains helper scripts used by the agent and CI/CD pipelines.

## Scripts

### `ado_webhook_parser.py`

Parses Azure DevOps webhook payloads and extracts work item information.

**Usage:**

```bash
python scripts/ado_webhook_parser.py < payload.json
```

**Output:**

```json
{
  "work_item_id": 12345,
  "title": "Upgrade React to v18",
  "description": "...",
  "type": "Task",
  "tags": ["library-upgrade", "react"]
}
```

### `azure_helpers.sh`

Common Azure CLI operations wrapped in safe functions.

**Usage:**

```bash
source scripts/azure_helpers.sh

# List resource groups
list_resource_groups

# Show storage account details
show_storage_account "mystorageaccount" "myresourcegroup"
```

### `create_service_hook.py`

Automates creation of Azure DevOps service hook for webhook integration.

**Usage:**

```bash
python scripts/create_service_hook.py \
  --org "https://dev.azure.com/myorg" \
  --project "MyProject" \
  --webhook-url "https://api.github.com/repos/owner/repo/dispatches" \
  --github-token $GITHUB_TOKEN
```

### `test_ado_connection.py`

Tests connectivity and authentication to Azure DevOps.

**Usage:**

```bash
python scripts/test_ado_connection.py
```

## Development

To add a new script:

1. Create the script file
2. Add appropriate error handling
3. Document usage in this README
4. Add tests in `tests/` directory
5. Update `.gitignore` if generating temporary files

