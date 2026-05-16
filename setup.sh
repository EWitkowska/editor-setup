#!/usr/bin/env bash
set -euo pipefail

REPO="$(dirname "$(realpath "$0")")"

OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"
    CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
elif [[ "$OS" == "Linux" ]]; then
    VSCODE_DIR="$HOME/.config/Code/User"
    CURSOR_DIR="$HOME/.config/Cursor/User"
else
    echo "Unsupported OS: $OS (Windows support coming soon)"
    exit 1
fi

installed=()
backups=0

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        mv "$dest" "${dest}.bak"
        backups=$(( backups + 1 ))
    fi
    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi
    ln -s "$src" "$dest"
}

# VS Code
if [[ -d "$VSCODE_DIR" ]]; then
    backup_and_link "$REPO/editor-config/settings.json"    "$VSCODE_DIR/settings.json"
    backup_and_link "$REPO/editor-config/keybindings.json" "$VSCODE_DIR/keybindings.json"
    printf "✓  %-12s  symlinked: settings.json, keybindings.json\n" "VS Code"
    installed+=("VS Code")
else
    printf "–  %-12s  not installed\n" "VS Code"
fi

# Cursor
if [[ -d "$CURSOR_DIR" ]]; then
    backup_and_link "$REPO/editor-config/settings.json"    "$CURSOR_DIR/settings.json"
    backup_and_link "$REPO/editor-config/keybindings.json" "$CURSOR_DIR/keybindings.json"
    printf "✓  %-12s  symlinked: settings.json, keybindings.json\n" "Cursor"
    installed+=("Cursor")
else
    printf "–  %-12s  not installed\n" "Cursor"
fi

# Claude Code
CLAUDE_SKILLS="$HOME/.claude/skills"
if [[ -d "$CLAUDE_SKILLS" ]]; then
    backup_and_link "$REPO/skills/claude/organize-settings.md" "$CLAUDE_SKILLS/organize-settings.md"
    printf "✓  %-12s  skill installed: organize-settings\n" "Claude Code"
    installed+=("Claude Code")
else
    printf "–  %-12s  not installed\n" "Claude Code"
fi

# Gemini CLI
GEMINI_SKILLS="$HOME/.gemini/skills"
if [[ -d "$GEMINI_SKILLS" ]]; then
    if [[ -d "$GEMINI_SKILLS/organize-settings" && ! -L "$GEMINI_SKILLS/organize-settings" ]]; then
        mv "$GEMINI_SKILLS/organize-settings" "$GEMINI_SKILLS/organize-settings.bak"
        backups=$(( backups + 1 ))
    fi
    if [[ -L "$GEMINI_SKILLS/organize-settings" ]]; then
        rm "$GEMINI_SKILLS/organize-settings"
    fi
    ln -s "$REPO/skills/gemini/organize-settings" "$GEMINI_SKILLS/organize-settings"
    printf "✓  %-12s  skill installed: organize-settings\n" "Gemini CLI"
    installed+=("Gemini CLI")
else
    printf "–  %-12s  not installed\n" "Gemini CLI"
fi

if [[ $backups -gt 0 ]]; then
    echo ""
    printf "Backed up %d existing file(s) with .bak extension.\n" "$backups"
fi

if [[ ${#installed[@]} -eq 0 ]]; then
    echo ""
    echo "Nothing was installed. Install VS Code, Cursor, Claude Code, or Gemini CLI first."
    exit 1
fi
