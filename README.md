# KServe Cursor AI Workspace

AI agent rules and commands for developing KServe on OpenShift. This is a companion to the [kserve-workspace](https://github.com/jlost/kserve-workspace) VS Code configuration.

## Features

* **Cursor Rules** - Context-aware rules that help the AI understand the multi-fork structure and workflows
* **Slash Commands** - Pre-built prompts for common development tasks like JIRA lookup, cherry-pick checking, and PR targeting
* **MCP Integration** - Configured for JIRA, GitHub, Slack, and Kubernetes tools

## Prereqs

This repository depends on the [kserve-workspace](https://github.com/jlost/kserve-workspace) being cloned as `.vscode` in the same KServe repository.

## Setup

1. Ensure `.vscode` is already set up (see [kserve-workspace README](https://github.com/jlost/kserve-workspace)):
    ```sh
    cd kserve
    git clone git@github.com:jlost/kserve-workspace.git .vscode
    ```

2. Clone this repository into your kserve repository at the root, named as `.cursor`:
    ```sh
    cd kserve
    git clone git@github.com:jlost/kserve-cursor.git .cursor
    ```
    You should now have both `.vscode` and `.cursor` directories at the root of the kserve repository.

3. Start Cursor:
    ```sh
    cursor .
    ```

## Contents

### Rules (`rules/`)

Cursor rules that provide context to the AI agent:

| Rule | Description |
|------|-------------|
| `fork-structure.mdc` | Multi-fork hierarchy and branch targeting |
| `git-workflow.mdc` | Git worktrees, commit signing, PR creation |
| `jira-github.mdc` | JIRA/GitHub integration and cross-reference handling |
| `mcp-tools.mdc` | Available MCP tools for cross-repository workflows |
| `e2e-testing.mdc` | E2E testing scripts, markers, and VS Code tasks |

### Commands (`commands/`)

Slash commands for common workflows:

#### JIRA Workflow Commands

| Command | Description |
|---------|-------------|
| `/jira-work TICKET` | **Full workflow:** research -> determine target -> create worktree |
| `/jira-research TICKET` | Deep search for existing work, document findings in JIRA |
| `/jira TICKET` | Quick context fetch (no deep search, no JIRA comment) |
| `/jira-assigned` | List assigned JIRA issues |

**Workflow composition:** `/jira-research` -> `/jira-work` -> `/jira` (in new worktree)

**Usage examples:**

```bash
# Full workflow: research issue, create worktree, start coding
/jira-work RHOAIENG-1234

# Research only (no worktree creation)
/jira-research RHOAIENG-1234

# Quick lookup of JIRA context
/jira RHOAIENG-1234

# Skip research if already done, specify target directly
/jira-work RHOAIENG-1234 skip_research:true target:odh/release-v0.15
```

#### Code Investigation Commands

| Command | Description |
|---------|-------------|
| `/pr-target` | Determine correct PR target for changes |
| `/cherrypick-check` | Check if a commit needs cherry-picking |
| `/branch-compare` | Compare branches across forks |
| `/find-fix ISSUE` | Find the fix for an issue across forks |

#### Testing Commands

| Command | Description |
|---------|-------------|
| `/e2e-debug` | Debug E2E test failures |

#### Release Commands

| Command | Description |
|---------|-------------|
| `/odh-release` | Guide through ODH release process |

## Contributions

Contributions welcome! Fork and submit a pull request.

