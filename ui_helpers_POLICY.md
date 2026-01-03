# /ui_helpers Policy (Canonical)

This document defines the **standard policy for shared UI helpers** used across
Project Lazarus scripts.

---

## Purpose

Shared UI helpers exist to:

- Encode MacroQuest-specific API behavior
- Prevent repeated UI-related defects
- Enforce consistent ImGui patterns across scripts
- Reduce regression risk as scripts evolve

Once a helper exists, it becomes the **canonical implementation**.

---

## Required Usage

- Reusable UI primitives **must be abstracted** once proven stable
- Direct calls to raw ImGui widgets should be avoided when a helper exists
- Scripts should import helpers via:
```lua
local ui = require('ui_helpers')
```

---

## Checkbox Standard (Mandatory)

### Canonical Helper
```lua
ui.checkbox(label, current_value, on_change)
```

### Guarantees
- Correct handling of MQ ImGui return values
- No silent state corruption
- Optional persistence callbacks
- Identical behavior across all scripts

### Prohibited Pattern
```lua
changed, value = ImGui.Checkbox(label, value)
```

Use of this pattern is considered a defect.

---

## Extension Guidelines

- Helpers must be:
  - Small
  - Deterministic
  - Side-effect free unless explicitly documented
- New helpers should:
  - Solve a real, observed problem
  - Be reusable across scripts
  - Be documented here when added

---

## Examples of Future Helpers

- Persistent window position/size
- Toggle + status badge widgets
- Consistent color/status indicators
- Safe combo boxes and sliders

---

**End of /ui_helpers Policy**
