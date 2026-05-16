---
name: organize-settings
description: Organizes VS Code/Cursor settings.json into 9 labeled sections, moving misplaced or unsectioned settings to their correct location while preserving comments, formatting, and trailing commas.
---

Detect the OS and find settings.json:
- macOS: `~/Library/Application Support/Code/User/settings.json`
- Linux: `~/.config/Code/User/settings.json`

Read the file and move any settings that are in the wrong section or have no section (e.g. appended at the end of the file) into the correct section based on this mapping:

- Section 1 (INTERFACE AND EDITOR APPEARANCE): workbench.*, window.*, zenMode.*, search.*, notebook.*, explorer.*, editor.minimap.*
- Section 2 (FONTS, CURSOR, AND EDITOR BEHAVIOR): editor.* (except minimap and formatOnSave)
- Section 3 (FILE SYSTEM, AUTO-SAVE, AND FORMATTING): files.*, security.*, diffEditor.*, editor.formatOnSave
- Section 4 (INTEGRATED TERMINAL CONFIGURATION): terminal.*
- Section 5 (GLOBAL FORMATTER AND TOOL SETTINGS): prettier.*, eslint.*, liveServer.*, aws.*
- Section 6 (PYTHON ENVIRONMENT AND ANALYSIS): python.*
- Section 7 (LANGUAGE-SPECIFIC OVERRIDES): [language] blocks
- Section 8 (MACROS AND SHORTCUTS): multiCommand.*
- Section 9 (AI TOOLS AND CHAT): chat.*, claudeCode.*, github.copilot.*, github.com.*

Preserve all existing comments, formatting, and trailing commas. Only move settings that are clearly misplaced or have no section. Do not reorganize settings that are already in the correct section.
