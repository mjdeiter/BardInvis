# BardInvis

**BardInvis** is an **EMU-safe group invis controller** for  
**Project Lazarus EverQuest**, built using **MacroQuest (MQNext)** and **E3**.

It provides a **single-button ImGui toggle** that instructs a bard to play  
**Shauri’s Sonorous Clouding** for group invis and reliably removes it when disabled.

All known bard melody and song-linger edge cases are handled.

<img width="236" height="261" alt="image" src="https://github.com/user-attachments/assets/e9c0cb0c-360e-48c7-b385-444fa593a349" />


---

## Features

- One-button **GROUP INVIS ON / OFF** control  
- Uses bard song **Shauri’s Sonorous Clouding**  
- Explicitly removes bard-song invis on disable (no linger issues)  
- Live group invis status summary  
- Optional per-member visibility list  
- Deterministic, controller-side execution only  

---

## Safety & Design

- **EMU-safe** (no `FindItem`, no unsafe TLOs)  
- No automation of combat or movement  
- Compatible with standard **E3** workflows  
- Designed specifically for **Project Lazarus** (not Live EQ)

---

## Intended Use

This script is intended for multibox controllers who want a **reliable, low-friction way to manage group invis** while traveling, without relying on timing, manual buff removal, or melody micromanagement.
