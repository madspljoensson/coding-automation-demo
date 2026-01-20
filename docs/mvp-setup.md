# MVP Setup (Step-by-Step)

> Goal: connect ADO work items to GitHub issues, have the agent generate scripts, and execute only after PR review.

## 1) Confirm tenant + test scope
- Use the existing Solita Entra tenant (no new tenant needed).
- Define a **test-only scope**: one test group + one test user.

## 2) Create the Agent App Registration (Entra ID) -x-
Ask IT Support to create or approve an App Registration with **Microsoft Graph application permissions**:
- `User.Read.All`
- `Group.Read.All`
- `GroupMember.ReadWrite.All`

Then **grant Admin Consent** for the tenant.

## 3) Create test objects
Work with IT Support:
- Test group: `IT-AI-Test-Group`
- Test user: `ai.test@solita.fi`

## 4) Add GitHub secrets
In GitHub repo → Settings → Secrets and variables → Actions:
- `AZURE_CREDENTIALS`: Service Principal JSON for Azure CLI
- `AZURE_TENANT_ID`: Tenant ID

(See [docs/setup.md](setup.md) for details and sample commands.)

## 5) Wire ADO → GitHub issues
You already have ADO webhooks. Create a **Service Hook** that sends work item events to GitHub via `repository_dispatch`.
Then add a GitHub Action that:
1. Receives the ADO payload
2. Creates a GitHub issue
3. Adds label `agent-task`

**Current ADO project:** `commenter/Solita - Intern IT Ticket system`.

**Work item gating (current + future):**
- Current: only “enabler stories” from the `ai-tickets` board.
- Future: a custom work item type named `ticket`.
- In both cases, processing must be controlled by a **toggleable field** that explicitly marks the item for AI processing.
- Make this toggleable field name configurable via a single global variable so it’s easy to change later.
- Field type: **boolean** (for now).

## 6) Build the first task pipeline
Start with **Add user to group** only:
ADO work item → GitHub issue → agent generates script in `_agent/scripts/pending/` → PR → review → merge → `execute-approved.yml` runs script.

## 7) Add two more task templates
Add templates for:
- Remove user from group
- List group members

(See [_agent/scripts/templates/](../_agent/scripts/templates/) and [_agent/scripts/README.md](../_agent/scripts/README.md).)

## 8) Define success metrics early
Track:
- Time from ADO ticket → PR
- Review time
- Success rate
- Human edits required

## 9) Validate end-to-end
- Create a test ADO work item
- Ensure the issue is created with `agent-task`
- Verify script generation and PR flow
- Review and merge, confirm execution on test group
