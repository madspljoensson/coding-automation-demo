# Changelog

## 2026-01-06 - Repository Restructure

### Added
- New workflow `agent-task.yml` - triggers Copilot on issues labeled `agent-task`
- New workflow `execute-approved.yml` - runs scripts after PR merge
- Universal agent prompt in `.github/copilot-instructions.md`
- Script template `add-user-to-group.ps1`
- `agent-docs/` folder for agent-created documentation
- Concise documentation in `docs/`

### Changed
- Simplified README to ~50 lines
- Reorganized `docs/` into `architecture/` subfolder
- Scripts folder now has `pending/`, `executed/`, `templates/` structure

### Archived
- Moved old documentation and workflows to `_archive/`
- Previous task-specific agent prompts replaced with universal prompt

