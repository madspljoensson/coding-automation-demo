# Library Update Agent Instructions

You are tasked with upgrading library dependencies as specified in the Azure DevOps work item.

## Context

- **Work Item**: {work_item_id}
- **Library to Update**: {library_name}
- **Current Version**: {current_version}
- **Target Version**: {target_version}
- **Package Manager**: {package_manager}

## Task Overview

Upgrade the specified library and fix any breaking changes to ensure the application continues to function correctly.

## Step-by-Step Process

### 1. Identify Current Usage

- Locate dependency files (`package.json`, `requirements.txt`, `pom.xml`, etc.)
- Find all imports/usages of the library in the codebase
- Review current version and dependencies

### 2. Research Breaking Changes

- Check the library's changelog/release notes
- Identify breaking changes between current and target versions
- Note deprecated APIs or changed interfaces

### 3. Update Dependency

- Update the version in dependency file(s)
- Run dependency installation (`npm install`, `pip install`, etc.)
- Check for peer dependency conflicts

### 4. Fix Breaking Changes

Common patterns to look for:

- **API Changes**: Function signatures, renamed methods
- **Imports**: Changed import paths or module names
- **Configuration**: Updated config schema or options
- **Types**: TypeScript interface changes
- **Behavior**: Changed default values or semantics

### 5. Update Tests

- Run existing test suite
- Fix failing tests due to API changes
- Update mocks/fixtures if needed
- Add tests for new features if appropriate

### 6. Update Documentation

- Update README if library usage is documented
- Update code comments referencing old API
- Update examples if they exist

## Example: React 17 → 18 Upgrade

```javascript
// Before (React 17)
import ReactDOM from 'react-dom';
ReactDOM.render(<App />, document.getElementById('root'));

// After (React 18)
import { createRoot } from 'react-dom/client';
const root = createRoot(document.getElementById('root'));
root.render(<App />);
```

## Pull Request Checklist

- [ ] Dependency version updated in all relevant files
- [ ] All tests pass with new version
- [ ] Breaking changes addressed and tested
- [ ] No new security vulnerabilities introduced
- [ ] Documentation updated
- [ ] Changelog/migration notes included in PR

## PR Description Template

```markdown
## Library Update: {library_name}

**Upgraded from**: v{current_version} → v{target_version}

### Changes Made

- Updated dependency in {files}
- Fixed breaking changes:
  - [ ] API change 1
  - [ ] API change 2
- Updated tests: {test_files}

### Breaking Changes

{List any breaking changes found and how they were addressed}

### Testing

- [ ] All existing tests pass
- [ ] Manual testing performed: {describe}
- [ ] No new vulnerabilities: `npm audit` / `pip audit` clean

### Migration Notes

{Any notes for reviewers or future reference}

### References

- Changelog: {link}
- Migration guide: {link}
- Work Item: #{work_item_id}
```

## Safety Checks

Before creating PR:

1. **No regressions**: All existing functionality still works
2. **No security issues**: Run security audit tools
3. **No broken dependencies**: Resolve all peer dependency warnings
4. **Tests pass**: Full test suite is green

## Common Gotchas

- **Transitive dependencies**: Other packages may also need updates
- **Lock files**: Update `package-lock.json` / `yarn.lock` / `poetry.lock`
- **Type definitions**: `@types/*` packages may need separate updates
- **Build tools**: Webpack/Vite config may need adjustments
- **CI/CD**: Pipeline might need updates for new version

## If Update Fails

- Document the issue clearly in PR
- List attempted fixes
- Recommend next steps (e.g., "requires manual review of {component}")
- Create PR as draft for human to complete

---

**Success Criteria**: Application builds, tests pass, no new vulnerabilities, breaking changes documented.

