# Research Goals

This project is part of a DTU thesis in collaboration with Solita, exploring AI-driven automation of IT tasks.

## Research Questions

1. How effectively can AI agents automate routine IT support tasks?
2. What is the optimal balance between agent autonomy and human oversight?
3. Which task types are most suitable for automation?

## Metrics

| Metric | Description |
|--------|-------------|
| Success rate | % of tasks completed without human intervention |
| Time to PR | Minutes from issue creation to PR |
| Approval rate | % of agent PRs that get merged |
| Error rate | % of scripts that fail on execution |

## Scope

### Phase 1 (Current)
- Azure AD group management (add/remove users)
- GitHub Issues as trigger
- Script-based execution with human approval

### Phase 2 (Future)
- Azure DevOps integration
- Multi-platform support (Teams, Workday)
- RAG over internal documentation

## Methodology

1. Collect baseline data on manual task completion
2. Deploy agent system
3. Compare automated vs manual metrics
4. Iterate on prompts and workflows

