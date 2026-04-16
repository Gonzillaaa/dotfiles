# GSD (Get Shit Done) Quick Reference

A workflow framework for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that manages software projects from inception through completion. GSD provides structured phases, persistent state across sessions, and parallel agent execution for building software with AI assistance.

---

## Installation

Install from GitHub:
```bash
# Clone the repository
git clone https://github.com/glittercowboy/get-shit-done.git ~/.claude/commands/get-shit-done

# Or with SSH
git clone git@github.com:glittercowboy/get-shit-done.git ~/.claude/commands/get-shit-done
```

Alternatively, add as a git submodule in your dotfiles:
```bash
cd ~/.claude/commands
git submodule add https://github.com/glittercowboy/get-shit-done.git
```

## Updating

Update to the latest version:
```bash
# From within Claude Code
/gsd:update

# Or manually via git
cd ~/.claude/commands/get-shit-done
git pull origin main
```

---

## Core Concepts

- **Milestone**: Major deliverable (e.g., v1.0, v2.0)
- **Phase**: Discrete unit of work within a milestone
- **Plan**: Execution steps for a phase (stored in PLAN.md)
- **Todo**: Ad-hoc tasks captured during work

---

## Workflows

### Starting a New Project
```
/gsd:new-project    → Deep context gathering, creates PROJECT.md
/gsd:new-milestone  → Start milestone cycle, update PROJECT.md
```

### Joining an Existing Project
```
/gsd:progress       → Check current state, see active phase/milestone
/gsd:resume-work    → Restore context from previous session
/gsd:map-codebase   → Analyze codebase structure (optional, for unfamiliar repos)
```

### Continuing Work (Returning to a Project)
```
/gsd:progress       → See where you left off, route to next action
/gsd:resume-work    → Full context restoration if paused mid-phase
/gsd:check-todos    → Review pending tasks
```

### Phase Lifecycle
```
/gsd:discuss-phase       → Gather context through adaptive questioning
/gsd:list-phase-assumptions → Surface Claude's assumptions before planning
/gsd:research-phase      → Research implementation approach (standalone)
/gsd:plan-phase          → Create detailed PLAN.md with verification
/gsd:execute-phase       → Execute plans with wave-based parallelization
/gsd:verify-work         → Validate features through conversational UAT
```

### Milestone Completion
```
/gsd:audit-milestone     → Audit completion against original intent
/gsd:plan-milestone-gaps → Create phases to close identified gaps
/gsd:complete-milestone  → Archive milestone, prepare for next version
```

### Session Management
```
/gsd:progress     → Check progress, show context, route to next action
/gsd:pause-work   → Create context handoff when pausing mid-phase
/gsd:resume-work  → Resume with full context restoration
```

### Roadmap Management
```
/gsd:add-phase      → Add phase to end of current milestone
/gsd:insert-phase   → Insert urgent work as decimal phase (e.g., 72.1)
/gsd:remove-phase   → Remove future phase, renumber subsequent
```

### Task Management
```
/gsd:add-todo      → Capture idea/task as todo from conversation
/gsd:check-todos   → List pending todos, select one to work on
```

### Utilities
```
/gsd:quick         → Quick task with GSD guarantees, skip optional agents
/gsd:debug         → Systematic debugging with persistent state
/gsd:map-codebase  → Analyze codebase with parallel mapper agents
/gsd:help          → Show available commands and usage guide
```

### Configuration
```
/gsd:settings      → Configure workflow toggles and model profile
/gsd:set-profile   → Switch model profile (quality/balanced/budget)
/gsd:update        → Update GSD to latest version
```

### Community
```
/gsd:join-discord  → Join the GSD Discord community
```

---

## Typical Workflows

### New Project
```
1. /gsd:new-project          # Initialize with deep context gathering
2. /gsd:new-milestone        # Start milestone (e.g., v1.0)
3. /gsd:discuss-phase        # Clarify phase requirements
4. /gsd:plan-phase           # Create execution plan
5. /gsd:execute-phase        # Build it
6. /gsd:verify-work          # Validate
7. Repeat 3-6 for each phase
8. /gsd:audit-milestone      # Check completeness
9. /gsd:complete-milestone   # Archive and wrap up
```

### Existing Project (First Time)
```
1. /gsd:progress             # Assess current state
2. /gsd:map-codebase         # Understand the codebase (optional)
3. /gsd:discuss-phase        # Pick up current or next phase
4. Continue with plan → execute → verify cycle
```

### Returning to Work
```
1. /gsd:progress             # Quick status check
   OR
   /gsd:resume-work          # Full context restoration if paused mid-phase
2. Continue where you left off
```

## Quick Tasks

For small, well-defined work that doesn't need full phase ceremony:
```
/gsd:quick <description>
```
Provides atomic commits and state tracking without optional agents.

## Session Persistence

GSD maintains state across context resets:
- `/gsd:pause-work` before stopping
- `/gsd:resume-work` when returning
- `/gsd:progress` to check where you are

## Model Profiles

Control cost/quality tradeoff for downstream agents:
- **quality**: Best results, higher cost
- **balanced**: Good tradeoff (default)
- **budget**: Faster, cheaper, good for iteration
