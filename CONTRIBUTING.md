# Contributing to AI-Driven Coding Automation

Thank you for your interest in contributing! This document provides guidelines for contributing to this research project.

## 🎯 Project Goals

This is a research project studying AI-driven automation of DevOps tasks. Contributions should align with:

- Demonstrating agentic workflow capabilities
- Improving automation success rates
- Enhancing security and safety mechanisms
- Supporting academic research objectives

## 🚀 Getting Started

1. **Fork the repository**
2. **Clone your fork**

```bash
git clone https://github.com/your-username/coding-automation-demo.git
cd coding-automation-demo
```

3. **Create a feature branch**

```bash
git checkout -b feature/your-feature-name
```

4. **Set up your environment**

```bash
cp .env.example .env
# Edit .env with your credentials
```

## 📝 Contribution Guidelines

### Code Style

- **Python**: Follow PEP 8, use type hints
- **Shell scripts**: Use shellcheck for validation
- **YAML**: 2-space indentation, validate syntax
- **Markdown**: Follow CommonMark specification

### Commit Messages

Use conventional commits format:

```
type(scope): brief description

Detailed explanation if needed

Fixes #123
```

**Types**: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`

**Examples**:

```
feat(agent): add support for parallel ticket processing
fix(webhook): handle null values in ADO payloads
docs(readme): update setup instructions
test(parser): add unit tests for webhook parser
```

### Pull Requests

1. **Keep PRs focused**: One feature or fix per PR
2. **Write clear descriptions**: Explain what and why
3. **Add tests**: Ensure changes are tested
4. **Update documentation**: Keep README and docs in sync
5. **Link issues**: Reference related issues

### Testing

Run tests before submitting:

```bash
# Python tests
pytest tests/

# Shell script tests
shellcheck scripts/*.sh

# YAML validation
yamllint .github/workflows/
```

## 🔒 Security

- **Never commit secrets**: Use `.env` (gitignored) or GitHub Secrets
- **Review Azure CLI commands**: Ensure they're safe and on allowlist
- **Validate inputs**: All external inputs must be sanitized
- **Report vulnerabilities**: Email security@example.com (do not file public issues)

## 📊 Research Data

If contributing data or evaluation results:

- **Anonymize**: Remove sensitive information from tickets/logs
- **Format**: Use structured JSON or CSV
- **Document**: Include metadata (date, source, context)
- **License**: Ensure data can be used in academic publication

## 🎨 Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome constructive feedback
- Focus on what's best for the project
- Show empathy toward others

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks
- Publishing others' private information
- Other unprofessional conduct

## 🏗 Architecture Decisions

For significant changes:

1. **Open an issue first**: Discuss the approach
2. **Document rationale**: Explain why this approach
3. **Consider alternatives**: What other options were considered?
4. **Impact analysis**: How does this affect existing functionality?

## 📚 Documentation

Update documentation for:

- New features or significant changes
- Configuration options
- API changes
- Breaking changes

Keep these files up to date:

- `README.md` - Overview and quick start
- `docs/architecture.md` - System architecture
- `docs/setup_guide.md` - Detailed setup
- `docs/troubleshooting.md` - Common issues

## 🧪 Testing Guidelines

### Unit Tests

- Test individual functions/methods
- Mock external dependencies
- Aim for >80% code coverage

### Integration Tests

- Test workflow end-to-end
- Use test fixtures for ADO payloads
- Verify PR creation and updates

### Manual Testing

Before submitting:

1. Test with sample work item
2. Verify PR is created correctly
3. Check agent logs for errors
4. Validate Azure CLI execution (if applicable)

## 📋 Issue Templates

### Bug Report

```markdown
**Describe the bug**
Clear description of the issue

**To Reproduce**
1. Create work item with...
2. Trigger workflow...
3. Observe error...

**Expected behavior**
What should happen

**Logs**
Relevant error logs

**Environment**
- OS: [e.g., Windows 11]
- GitHub Actions runner: [e.g., ubuntu-latest]
- Agent model: [e.g., Claude Sonnet 4.5]
```

### Feature Request

```markdown
**Problem**
What problem does this solve?

**Proposed Solution**
How should it work?

**Alternatives Considered**
What other approaches were considered?

**Research Value**
How does this contribute to research goals?
```

## 🎓 Academic Contributions

This project supports academic research. Contributions may be cited in:

- DTU Master's Thesis
- Academic publications
- Conference presentations

By contributing, you agree that your contributions may be referenced in academic work.

## 🔄 Development Workflow

1. **Pick an issue** or create one
2. **Discuss approach** in the issue
3. **Implement changes** in a feature branch
4. **Write/update tests**
5. **Update documentation**
6. **Submit PR** with clear description
7. **Address review feedback**
8. **Merge** once approved

## 📞 Getting Help

- **Questions**: Open a discussion or issue
- **Chat**: [Link to Slack/Discord if available]
- **Email**: [maintainer email]

## 🙏 Recognition

Contributors will be acknowledged in:

- README Contributors section
- Academic paper acknowledgments (if applicable)
- Project documentation

Thank you for helping advance AI-driven DevOps automation research!

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

