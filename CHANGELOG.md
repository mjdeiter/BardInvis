# BardInvis — CHANGELOG

All changes follow **semantic versioning** and Lazarus scripting standards.  
Unless otherwise stated, releases are **backward-compatible** and EMU-safe.

---

## v1.3.7 — UI Polish (Current Stable)
- Color-coded per-member invis status in the names table  
  - **Green** = Invisible  
  - **Red** = Visible
- Improves readability with no behavior changes
- Recommended stable release

---

## v1.3.6 — UI Helper Integration
- Integrated shared `ui_helpers.lua` checkbox wrapper
- Fixed MacroQuest ImGui checkbox API misuse
- Resolved persistent checkbox reset issues
- Added version number to GUI title bar

---

## v1.3.5 — Config Path Correction
- Corrected config directory resolution using:
  - `mq.TLO.MacroQuest.Path('config')`
- Fixed UI persistence failures caused by ambiguous config paths
- No logic changes

---

## v1.3.4 — Crash Fix
- Fixed startup crash caused by treating `mq.configDir` as a function
- Corrected config path handling
- No behavior changes

---

## v1.3.3 — UI State Persistence
- Added persistence for the “Show Names” checkbox
- Stored UI state in a dedicated INI file
- Foundation for production UI behavior

---

## v1.3.2 — UI Label Polish
- Renamed checkbox from “Show Invis Debug” to **“Show Names”**
- Improved clarity and user-facing wording
- No behavior changes

---

## v1.3.1 — Production UI + Optional Names
- Added minimal group invis status line
- Added optional per-member visibility table (toggleable)
- Cleaned production UI while retaining observability

---

## v1.3.0 — Production UI Cleanup
- Removed always-on debug table
- Introduced clean, minimal ImGui layout
- Marked end of debug-first phase

---

## v1.2.2 — Bard Song Linger Fix (Major Stability Release)
- Explicitly removes **Shauri’s Sonorous Clouding** on OFF
- Eliminated bard song aura linger issues
- Deterministic ON / OFF behavior
- First fully stable functional release

---

## v1.2.0–v1.2.1 — Toggle & Melody Refinement
- Added ON / OFF toggle support
- Restored exit melody on disable
- Improved FSM structure and timing
- Iterative fixes based on live testing

---

## v1.0.0 — Initial Release
- Basic bard-driven group invis toggle
- Early ImGui interface
- Proof-of-concept implementation

---

**End of BardInvis Changelog**
