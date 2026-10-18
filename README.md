# No Frontier - SOG

> **Tactical, turn-based single-player survival RPG set in a lawless, apocalyptic zone.**
> Command an elite Special Operations Group (SOG) squad, scavenge vital resources, manage base infrastructure, and navigate brutal perma-death mechanics in a low-poly semi-voxel isometric world.

---

## 📸 Overview

**No Frontier - SOG** is a mobile-first tactical grid-based RPG that combines strategic squad combat with deep base management and survival mechanics. 

Set in an isolated "No Frontier" exclusion zone overrun by infected threats and rogue paramilitary factions, players take command of an elite military unit. Every choice carries weight: resources are scarce, ammunition is limited, medical supplies determine life or death, and fallen operators are gone forever.

---

## ⚙️ Key Core Features

* **Tactical Grid Combat (Turn-Based):**
  * Tile/Grid-based movement and line-of-sight system.
  * Action Point (AP) economy, directional cover (High/Low), stance adjustments, and Overwatch/Suppression mechanics.
  * Targeted body-part strikes and tactical status effects (bleeding, infection, fractured limbs).

* **Squad Management & Infection Dynamics:**
  * **Permadeath:** Lost operators are permanently killed in action.
  * **Infection Counter & Quarantine:** Operators exposed to viral bites or bio-hazards require active medical treatment and monitoring. Unchecked infection inside the base can lead to outbreak within your own squad.
  * **Morale & Trait Synergies:** Mercenaries/Operators have distinct background traits, rivalries, and psychological limits under stress.

* **Base Upgrades & Scavenging Loops:**
  * Sector-by-sector exploration map (fog of war, high-risk scavenging runs).
  * Build and maintain base facilities: Infirmary, Armory, Workshop, Communications, and Perimeter Defense.
  * Resource management: Food, Clean Water, Ammo, Fuel, Scrap, and Medical Supplies.

* **Visual Style & Art Direction:**
  * Semi-voxel / stylized low-poly 3D aesthetics with dynamic isometric projection.
  * Functional, high-contrast mobile UI designed for touch interaction.

---

## 🎯 Initial Development Scope (Phase 1 MVP)

Fokus pengembangan awal (**Minimum Viable Product**) bertujuan untuk memvalidasi *core combat loop*, *grid physics*, dan sistem dasar *squad management*.

### 1. Combat Core & Movement Engine
- [ ] **Grid Navigation System:**
  - Tile-based movement (Square or Hex) dengan kalkulasi Action Points (AP).
  - Pathfinding dasar (A* Algorithm) yang memperhitungkan obstacle dan medan.
- [ ] **Turn-Based Combat Loop:**
  - Inisiatif giliran berbasis stat Speed / Reaction.
  - Tipe serangan dasar: Primary Weapon (Single Fire, Burst), Melee, dan Item/Medical use.
  - Sistem Cover: *No Cover*, *Half Cover* (50%), *Full Cover*