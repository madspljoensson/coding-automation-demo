
Projektet handler om at undersøge, om AI-agenter – med menneskelig kontrol – kan fjerne lavrisiko, gentagende IT-arbejde, uden at gå på kompromis med sikkerhed. Jeg vil gerne sikre, at jeg fokuserer på de platforme og flows, der faktisk giver værdi for Solita.

IT danmark chat

Sikkerhed

Solita function AI


NOTER:

1. Bruger
Default til AI
AI chat først og fremmest
Knowledge base: wiki og alt

1. IT support 
Tilføj folk til projekt (Azure)


Bruger oplevelse nemmere -> lave ticket

Soliticket chat - initial chat med bot 

Byg videre på 


On off boarding -> automatiseret


Magnus baggessen



- Liste af platforme
- Eksemple flows han gerne vil have
  - Hvilke manuelle processer oplever du som mest “unødvendige” i organisationen?
  - Hvor oplever ledere eller konsulenter mest ventetid pga. interne processer?
  - Er der steder hvor IT bliver en flaskehals – selvom opgaven er simpel?
- Sikkerhed:
  - Kan vi få read adgang til alle platforme? (Eksemple: Workday)
  - ? Hvor komfortabel er Solita med, at en AI udfører ændringer – hvis der stadig er sporbarhed, approval og rollback?
  - ? Er der kategorier af ændringer, som aldrig må automatiseres – uanset hvor sikre de er?
- Er der nogle dokumenter eller resourcer jeg kan få adgang til for at få mere information?
- Hvor gemmes wiki'er som AI agenten kan bruges, er der mange forskellige steder? (Azure Devops Wiki, Confluence, SharePoint, Notion, custom?)
- Solita Finlands version af AI automation


---
## CEO Jesper meeting:
Meeting with Jesper about project


### Platforms we use (examples/guesses)

"Which platform do we use and could be integrated in the AI agent"

Microsoft:
- Azure (App Service, Functions, Storage, Key Vault, Azure AD/Entra)
- Teams (chat ops, approvals)
- Entra ID (users, groups, access reviews)
- Azure DevOps (repos, pipelines, boards)
- SharePoint / OneDrive (docs, templates)
- ? Power Platform (Power Automate, Power Apps)

Other:
- Workday (HR onboarding/offboarding)

Other maybe?:
- Jira / Confluence (if used in some teams)
- Slack (if any non-Teams orgs)
- GitHub (if any repos outside Azure DevOps)

### Flows that can be automated (examples/guesses)

"What thing / flows can be automated?"

**User management:**
- Onboarding (create user, license, groups, starter access)
- Offboarding (disable user, remove access, archive data)
- Add person to project/group (role-based group assignment)
- Access reviews (periodic group membership checks)

**Project lifecycle:**
- Start new project (create repo, pipeline, templates, permissions)
- Development -> AMS (handover checklist, runbooks, access transitions)
- Environment provisioning (dev/test/prod setup)
- Secrets/config setup (Key Vault, config entries)

? Delivery/operations:
- Incident to postmortem template creation
- Release approvals and change records
- Cost reporting and budget alerts
- Compliance evidence collection

### Security flow

"Suggested security flow"

**Basic flow:**
Ask agent / add issue ->
Agent creates plan and scripts ->
Human review and accept ->
Agent executes script

**Template flow 1 (no human reviewer needed):**
Ask agent ->
Agent finds template script that matches perfectly ->
Agent automatically executes

**Template flow 2 (still human reviewer):**
Ask agent ->
Agent finds template script that matches perfectly ->
Human review and accept ->
Agent executes

## Questions for Jesper

- Is anything already automated? (Power Automate, scripts, etc.)

- Is there a rollback plan for Azure AD changes?

**MVP scope (IT support agent)**
- Who should be allowed review agent PRs? (IT staff, team leads?)

**Security and knowledge sources**
- Where is the wiki? (Confluence, SharePoint, ADO wiki?)
- Any sensitive docs the agent must NOT read?

**Scope boundaries**
- Which systems can the agent touch? (Azure AD, ADO, Workday, M365?)
- Any systems that are off-limits?




**Workday / HR**
- Is HR interested in automating onboarding/offboarding?
- Do we have access to workday and can we get access?

### Late game

**User interface**
- Should users talk to the agent via Teams, email, or web form?
- Should administrative roles (Example CEO, non technical people) be able to review agent tasks?




### Questions for me

**Success**
- What's a good first win? (e.g. agent handles "add to group" end-to-end)
- Target: agent handles X% of IT tickets with only review?

**Rollback**
- What happens if the agent makes a mistake?
- Is there a rollback plan for Azure AD changes?

