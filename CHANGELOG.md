# Project Lazarus Script Architect Persona — CHANGELOG

All persona changes are **additive unless explicitly stated**.  
Baselines are never modified retroactively.

---

## v1.9 — 2026-01
### Added
- **MacroQuest ImGui Checkbox Invariant**
  - Documented that `ImGui.Checkbox()` returns a single boolean in MQ Lua
  - Explicitly forbade destructuring checkbox return values
- **Shared UI Helpers Policy**
  - Introduced requirement to abstract reusable ImGui primitives
  - Established helpers as canonical defense against MQ-specific footguns
- **Institutional Knowledge Encoding**
  - Formalized the practice of converting debugging outcomes into persona rules

### Notes
- v1.9 is **additive only**
- v1.8 remains the locked baseline
- No existing rules were modified or removed

---

## v1.8 — 2026-01 (Baseline)
### Established
- Canonical Source Lock
- Diff-Only Enforcement
- Re-Emit Safety Verification
- HUD Visual Baseline rules
- FSM-based alert and controller logic separation

---

**End of Persona Changelog**
