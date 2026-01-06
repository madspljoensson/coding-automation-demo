# Troubleshooting Guide

Common issues and their solutions for the AI-Driven Coding Automation system.

## Table of Contents

- [Service Hook Issues](#service-hook-issues)
- [GitHub Actions Issues](#github-actions-issues)
- [Agent Failures](#agent-failures)
- [Azure CLI Issues](#azure-cli-issues)
- [PR Creation Issues](#pr-creation-issues)
- [Performance Issues](#performance-issues)
- [Security Issues](#security-issues)

## Service Hook Issues

### Service Hook Not Triggering

**Symptoms:**
- Work item created in Azure DevOps
- No corresponding GitHub Action triggered
- Service Hook history shows errors

**Diagnostic Steps:**

1. Check Service Hook configuration:

```bash
# In Azure DevOps: Project Settings → Service Hooks → History
# Look for recent deliveries and their status
```

2. Verify webhook URL is correct
3. Check GitHub webhook delivery logs

**Solutions:**

#### Solution 1: Fix Authentication

The service hook may be failing authentication:

```bash
# Verify GitHub token has correct scopes
gh auth status

# Regenerate token if needed with these scopes:
# - repo (full control)
# - workflow
```

Update the service hook with the new token.

#### Solution 2: Check Firewall Rules

Ensure your network allows outbound connections from Azure DevOps:

- Azure DevOps IP ranges: [Microsoft Documentation](https://learn.microsoft.com/en-us/azure/devops/organizations/security/allow-list-ip-url)
- GitHub webhook IPs: Check GitHub meta API

#### Solution 3: Recreate Service Hook

Sometimes the hook gets corrupted:

1. Delete existing service hook
2. Create new one following setup guide
3. Test with a sample work item

### Service Hook Delivers But Workflow Doesn't Run

**Symptoms:**
- Service hook history shows successful delivery
- GitHub Actions doesn't show workflow run

**Solutions:**

Check workflow trigger configuration in `.github/workflows/agent-trigger.yml`:

```yaml
on:
  repository_dispatch:
    types: [azure-devops-work-item]  # Must match service hook event type
```

Verify the service hook sends the correct `event_type`:

```json
{
  "event_type": "azure-devops-work-item",
  "client_payload": { ... }
}
```

## GitHub Actions Issues

### Workflow Fails with Authentication Error

**Error Message:**
```
Error: Authentication failed
fatal: could not read Username for 'https://github.com'
```

**Solution:**

The workflow needs proper permissions:

```yaml
permissions:
  contents: write      # To push code
  pull-requests: write # To create PRs
  actions: read        # To read workflow runs
```

Add to your workflow file or check organization settings.

### Workflow Times Out

**Symptoms:**
- Workflow runs for 6 hours then fails
- Agent task appears stuck

**Solutions:**

1. **Reduce timeout** in workflow:

```yaml
jobs:
  agent-task:
    timeout-minutes: 30  # Add this
```

2. **Check for infinite loops** in agent logic
3. **Monitor agent progress** with more logging

### Secrets Not Available in Workflow

**Error Message:**
```
Error: Secret AZURE_CLIENT_ID not found
```

**Solution:**

1. Verify secret exists: Repository → Settings → Secrets and variables → Actions
2. Check secret name matches exactly (case-sensitive)
3. For organization secrets, ensure repository has access
4. Reference correctly in workflow:

```yaml
env:
  AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
```

## Agent Failures

### Agent Doesn't Understand Work Item

**Symptoms:**
- Agent creates PR but changes are incorrect
- Agent reports confusion in logs
- PR is empty or off-topic

**Solutions:**

#### Solution 1: Improve Work Item Description

Work items should be structured:

```markdown
## Objective
[Clear statement of what needs to be done]

## Requirements
- Specific requirement 1
- Specific requirement 2

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Technical Notes
[Any technical context or constraints]
```

#### Solution 2: Enhance Agent Prompt

Update `agents/prompts/ticket_prompt.md` with better instructions for your domain.

#### Solution 3: Add Examples

Provide example work items in `agents/examples/` that the agent can reference.

### Agent Makes Incorrect Changes

**Symptoms:**
- Agent creates PR with wrong implementation
- Tests fail
- Code doesn't match requirements

**Solutions:**

1. **Review agent logs** for reasoning
2. **Improve prompts** with more specific guidance
3. **Add validation steps** in workflow:

```yaml
- name: Run tests
  run: npm test
  
- name: Check if tests pass
  if: failure()
  run: |
    echo "Tests failed - canceling PR creation"
    exit 1
```

4. **Use more specific work item types** (e.g., separate prompts for upgrades vs. new features)

### Agent Exceeds Token Limit

**Error Message:**
```
Error: Maximum context length exceeded
```

**Solutions:**

1. **Reduce context size**:
   - Limit files passed to agent
   - Use `.agentignore` to exclude irrelevant files
   - Break large tasks into smaller work items

2. **Use chunking strategy**:
   - Process one module at a time
   - Create multiple smaller PRs

## Azure CLI Issues

### Authentication Fails

**Error Message:**
```
ERROR: The command failed with an unexpected error.
Error: AADSTS70011: Invalid client secret
```

**Solutions:**

1. **Verify Service Principal credentials**:

```bash
az login --service-principal \
  -u $AZURE_CLIENT_ID \
  -p $AZURE_CLIENT_SECRET \
  --tenant $AZURE_TENANT_ID
```

2. **Check secret hasn't expired**:

```bash
az ad sp credential list --id $AZURE_CLIENT_ID
```

3. **Regenerate secret if needed**:

```bash
az ad sp credential reset --id $AZURE_CLIENT_ID
```

Update GitHub secret with new value.

### Permission Denied

**Error Message:**
```
ERROR: The client '...' does not have authorization to perform action
```

**Solutions:**

1. **Check RBAC assignments**:

```bash
az role assignment list --assignee $AZURE_CLIENT_ID
```

2. **Add required role**:

```bash
az role assignment create \
  --assignee $AZURE_CLIENT_ID \
  --role Contributor \
  --scope /subscriptions/$AZURE_SUBSCRIPTION_ID
```

3. **Verify scope** matches target resources

### Command Not Allowed

**Symptoms:**
- Agent tries to run Azure CLI command
- Command is blocked by allowlist

**Solution:**

Update allowlist in configuration:

```bash
# .env
ALLOWED_AZURE_CLI_COMMANDS="az account show,az group list,az resource list,az vm list"
```

## PR Creation Issues

### PR Not Created

**Symptoms:**
- Workflow completes successfully
- No PR appears in repository
- No errors in logs

**Diagnostic Steps:**

1. Check if branch was created:

```bash
git fetch
git branch -r | grep work-item
```

2. Check if commits exist:

```bash
git log origin/work-item-12345
```

**Solutions:**

#### Solution 1: GitHub Token Permissions

Token needs `pull_request: write` permission:

1. Go to token settings
2. Add `pull_requests: read and write`
3. Update secret in repository

#### Solution 2: Branch Protection Rules

Branch protection may block PR creation:

1. Repository Settings → Branches
2. Check protection rules
3. Add exception for agent or relax rules

#### Solution 3: PR Already Exists

Check if PR already exists for that branch:

```bash
gh pr list --head work-item-12345
```

### PR Created But Empty

**Symptoms:**
- PR is created
- PR has no file changes
- PR description is generated but diff is empty

**Solutions:**

1. **Check if changes were committed**:

```bash
git log origin/work-item-12345 --oneline
```

2. **Verify git configuration** in workflow:

```yaml
- name: Configure Git
  run: |
    git config user.name "GitHub Copilot Agent"
    git config user.email "agent@github.com"
```

3. **Check if changes were staged**:

```yaml
- name: Commit changes
  run: |
    git add .
    git commit -m "Changes for work item #$WORK_ITEM_ID" || echo "No changes to commit"
```

## Performance Issues

### Agent Takes Too Long

**Symptoms:**
- Simple tasks take >30 minutes
- Workflow approaches timeout

**Solutions:**

1. **Optimize context**:
   - Reduce files in agent context
   - Use targeted file selection

2. **Use faster model**:
   - Switch to smaller/faster LLM if available
   - Trade-off: accuracy vs. speed

3. **Parallelize independent tasks**:

```yaml
strategy:
  matrix:
    task: [task1, task2, task3]
```

### High Cost Per Task

**Symptoms:**
- Monthly bill higher than expected
- Token usage exceeds budget

**Solutions:**

1. **Monitor token usage**:

```yaml
- name: Track tokens
  run: |
    echo "Tokens used: $TOKEN_COUNT"
    # Add to metrics
```

2. **Optimize prompts**:
   - Remove redundant context
   - Use more concise instructions

3. **Implement caching**:
   - Cache common responses
   - Reuse analysis across similar tasks

4. **Set rate limits**:

```bash
# .env
AGENT_MAX_TASKS_PER_HOUR=5
COST_LIMIT_MONTHLY_USD=500
```

## Security Issues

### Secrets Exposed in Logs

**Symptoms:**
- Secrets appear in workflow logs
- Security scanning detects exposed credentials

**Solutions:**

1. **Immediate action**:
   - Revoke compromised secrets
   - Rotate all related credentials
   - Review access logs

2. **Prevention**:

```yaml
- name: Use secret safely
  env:
    SECRET: ${{ secrets.MY_SECRET }}
  run: |
    # Don't echo secrets
    # Don't use set -x with secrets
    # Mask in logs
    echo "::add-mask::$SECRET"
```

3. **Audit logs** for commands that might expose secrets:

```bash
# Bad
echo $AZURE_CLIENT_SECRET

# Good
# Just use it, don't print it
az login --service-principal -p $AZURE_CLIENT_SECRET ...
```

### Unauthorized Access Attempt

**Symptoms:**
- Failed login attempts in logs
- Unauthorized Azure resource access

**Solutions:**

1. **Review audit logs**:

```bash
az monitor activity-log list \
  --start-time 2024-01-01 \
  --query "[?contains(authorization.action, 'failed')]"
```

2. **Tighten permissions**:
   - Use least privilege principle
   - Limit service principal scope
   - Use managed identities where possible

3. **Enable alerting**:

```bash
# Set up alerts for suspicious activity
az monitor metrics alert create \
  --name UnauthorizedAccess \
  --condition "count failed_authentications > 5"
```

## Getting More Help

### Enable Debug Logging

Add to workflow:

```yaml
env:
  ACTIONS_STEP_DEBUG: true
  ACTIONS_RUNNER_DEBUG: true
```

### Collect Diagnostic Information

```bash
# System info
uname -a
node --version
python --version
az --version

# GitHub info
gh auth status
gh api /rate_limit

# Azure info
az account show
az account list

# Environment
env | grep -E "(AZURE|GITHUB)" | sed 's/=.*/=***/'
```

### Contact Support

When opening an issue, include:

1. Workflow run ID
2. Work item ID (if applicable)
3. Relevant logs (with secrets redacted)
4. Steps to reproduce
5. Expected vs actual behavior

**GitHub Issues**: [Link to issues]  
**Email**: [support email]  
**Documentation**: [Link to docs]

---

**Last Updated**: December 2024

