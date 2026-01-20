# Repository Structure

## Directory Overview

```
coding-automation-demo/
├── .github/
│   ├── copilot-instructions.md   # Universal agent prompt
│   └── workflows/
│       ├── agent-task.yml        # Triggers agent on labeled issues
│       └── execute-approved.yml  # Runs scripts after PR merge
│
├── _agent/                       # AI-managed folder (do not edit manually)
│   ├── scripts/
│   │   ├── pending/              # New scripts awaiting approval
│   │   ├── executed/             # Scripts that have been run
│   │   └── templates/            # Reusable script patterns
│   └── agent-docs/               # Agent-created documentation
│
├── docs/
│   ├── architecture/
│   │   ├── system.md             # This system architecture
│   │   └── repository.md         # This file
│   ├── setup.md                  # Setup instructions
│   └── research.md               # Research goals
│
├── __archive/                     # Deprecated files (reference only)
│
├── README.md                     # Project overview
├── CHANGELOG.md                  # Version history
└── LICENSE                       # MIT license
```

## Key Directories

### `.github/`

GitHub-specific configuration. The `copilot-instructions.md` file contains the universal prompt that guides the agent for all tasks.

### `_agent/scripts/`

Three-stage script lifecycle:
1. **templates/** - Reusable patterns the agent can reference
2. **pending/** - Agent-created scripts awaiting human approval
3. **executed/** - Scripts that have been approved and run

### `_agent/agent-docs/`

Knowledge base created by the agent itself. When the agent learns something useful (e.g., "this group requires special handling"), it documents it here for future reference.

### `docs/`

Human-written documentation about the project.

### `_archive/`

Old files kept for reference. Not actively used.

