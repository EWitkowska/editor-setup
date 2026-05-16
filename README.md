# editor-setup

My personal VS Code and Cursor configuration, managed via symlinks so both editors always share the same settings. Includes AI skills for keeping the settings file organized.

## What's inside

| Path                                 | Description                                                          |
| ------------------------------------ | -------------------------------------------------------------------- |
| `editor-config/settings.json`        | Shared VS Code / Cursor settings, organized into 9 labeled sections  |
| `editor-config/keybindings.json`     | Custom keybindings                                                   |
| `skills/claude/organize-settings.md` | Claude Code skill: moves misplaced settings into the correct section |
| `skills/gemini/organize-settings/`   | Gemini CLI skill: same functionality                                 |
| `setup.sh`                           | Creates all symlinks and installs skills automatically               |

## Requirements

- macOS or Linux
- VS Code and/or Cursor
- Claude Code and/or Gemini CLI (optional, for the skills)

## Installation

```bash
git clone https://github.com/ewawitkowska/editor-setup.git
cd editor-setup
./setup.sh
```

`setup.sh` detects which editors and AI tools you have installed and sets up only what applies. Existing config files are backed up with a `.bak` extension before being replaced.

## What setup.sh does

| Target      | Action                                                                |
| ----------- | --------------------------------------------------------------------- |
| VS Code     | Symlinks `settings.json` and `keybindings.json` from `editor-config/` |
| Cursor      | Same symlinks, both editors share one source of truth                 |
| Claude Code | Symlinks `organize-settings` skill to `~/.claude/skills/`             |
| Gemini CLI  | Symlinks `organize-settings` skill to `~/.gemini/skills/`             |

If an editor or CLI tool is not installed, that step is skipped with a `–` in the output.

## Skills

### `organize-settings`

Reads `settings.json` and moves any settings that ended up in the wrong section (or have no section) into the correct one, based on the key prefix. Preserves all comments, formatting, and trailing commas.

**In Claude Code:** type `/organize-settings` or ask Claude to run the skill.

**In Gemini CLI:** type `/organize-settings` or ask Gemini to run the skill.
