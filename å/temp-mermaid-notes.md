1) "Why this matters" — Business value loop

Shows the project as a flywheel: faster ops → happier people → better delivery.

```mermaid
flowchart TD
  A[IT Tickets + Repetitive Admin Work] --> B[AI Agent drafts change plan + script]
  B --> C[Human Review / Approval]
  C --> D[Automated Execution]
  D --> E[Audit Log + Evidence]
  E --> F[Knowledge Base Improved<br/>templates + runbooks + docs]
  F --> B
  D --> G[Time saved + fewer errors]
  G --> H[More predictable onboarding/offboarding]
  H --> I[Improved employee experience]
  I --> A
```

2) Scope boundary — "What can the agent touch?"

Makes it crystal clear what's in/out (great for trust + risk management).

```mermaid
flowchart TD
  subgraph InScope[In Scope - Phase 1]
    G1[Entra ID Groups<br/>add/remove/list] --> G2[Enterprise App Access<br/>assign/unassign/list]
    G2 --> G3[Basic User Ops<br/>read attributes]
  end

  subgraph Guardrails[Mandatory Guardrails]
    R1[Allowlist<br/>TEST-* groups / apps] --> R2[Least privilege identity]
    R2 --> R3[PR-based approvals] --> R4[Audit log + rollback]
  end

  subgraph OutScope[Out of Scope - Phase 1]
    O1[Production-wide changes] --> O2[Financial systems]
    O2 --> O3[Direct HR actions<br/>in Workday] --> O4[Policy changes<br/>Conditional Access]
  end

  InScope --> Guardrails
  Guardrails --> OutScope
```

3) "Read → Suggest → Execute" maturity ladder (with risk)

A clean "roadmap" picture that CEOs love.

```mermaid
flowchart TD
  subgraph L0[L0 - Observe]
    A1[Read-only inventory<br/>who has access to what?]
    A2[Detect drift<br/>unexpected group members]
    A1 --> A2
  end

  subgraph L1[L1 - Assist]
    B1[Draft scripts + PRs]
    B2[Explain impact + plan]
    B3[Human approval required]
    B1 --> B2 --> B3
  end

  subgraph L2[L2 - Automate]
    C1[Auto-execute safe templates]
    C2[Rollback-ready]
    C3[Still fully audited]
    C1 --> C2 --> C3
  end

  L0 -->|low risk| L1
  L1 -->|medium risk| L2
```

4) Governance model — Who owns what?

This is gold in a CEO meeting because it shows you thought about accountability.

```mermaid
flowchart TD
  CEO[CEO Sponsor] --> Policy[Policy & Risk Appetite]
  Policy --> Security[Security / Compliance]
  Policy --> IT[IT Operations]

  Security --> Guardrails[Allowed actions<br/>+ red lines]
  IT --> Runbooks[Runbooks + templates]
  IT --> Reviewers[PR reviewers<br/>and approvals]

  Guardrails --> Agent[AI Agent]
  Runbooks --> Agent
  Reviewers --> Agent

  Agent --> Audit[Audit Log]
  Audit --> Reporting[Monthly metrics<br/>time saved, incidents avoided]
  Reporting --> CEO
```

5) Safety "kill switch" & containment

Shows you've built a system that can be stopped instantly.

```mermaid
flowchart TD
  Issue[Task request] --> Agent[Agent creates plan + script]
  Agent --> PR[Pull Request]
  PR --> Review[Human Review]
  Review -->|approved| Execute[Execute with least privilege]

  Execute --> Audit[Audit log]
  Execute --> Rollback[Rollback script / revert plan]

  subgraph Controls[Emergency Controls]
    direction TB
    K1[Disable GitHub workflow]
    K2[Disable app/service principal]
    K3[Remove permissions]
    K4["Block via Conditional Access<br/>(if used later)"]
  end

  Controls -.->|can halt| Agent
  Controls -.->|can halt| Execute
```

6) Promotion path — Test tenant → Limited prod → Wider prod

Very useful if Jesper asks "how do we safely go from experiment to real value?"

```mermaid
flowchart TD
  T[Test Tenant<br/>TEST-* objects only] --> P1[Prod - Limited Scope<br/>single team / allowlist]
  P1 --> P2[Prod - Expanded Scope<br/>more teams + more templates]
  P2 --> P3[Prod - Standard Operating Model<br/>governance + metrics]

  T -->|evidence: logs, success rate| P1
  P1 -->|evidence: low incidents + time saved| P2
  P2 -->|evidence: mature controls| P3
```

7) Example end-to-end onboarding (multi-system) — future vision

Shows how it becomes a "real thing" beyond Entra groups.

```mermaid
flowchart TD
  Req[Request: Onboard new employee] --> Validate[Validate data<br/>name, role, start date]
  Validate --> Plan[Generate plan<br/>systems + access]
  Plan --> PR[Create PR with scripts + checklist]
  PR --> Approve[Human review + approve]

  Approve --> Entra[Entra: groups + app access]
  Approve --> M365[M365: mailbox / Teams / SharePoint]
  Approve --> Devices[Endpoint: Intune policies<br/>apps + config]
  Approve --> Docs[Create project docs<br/>templates + runbooks]

  Entra --> Audit[Audit + evidence]
  M365 --> Audit
  Devices --> Audit
  Docs --> Audit
```

8) Metrics dashboard — "How we prove this works"

CEOs want measurable outcomes. This diagram can justify continued support.

```mermaid
flowchart LR
  subgraph Inputs[Inputs]
    Tickets[Ticket volume]
    Changes[Changes executed]
    ReviewTime[Review time]
  end

  subgraph KPIs[KPIs]
    SR[Success rate %]
    TS[Time saved]
    ER[Error reduction]
    LT[Lead time to access]
  end

  subgraph Outputs[Outputs]
    Report[Monthly report to IT + CEO]
    Decisions[Adjust scope / guardrails]
  end

  Inputs --> KPIs
  KPIs --> Outputs
  Outputs --> Inputs
```

