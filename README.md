# No Frontier : SOG Vietnam

> A high-lethality, physics-driven, turn-based tactical RPG inspired by games such as *Jagged Alliance* and *XCOM*.

**Project status:** Early development  
**Current development scope:** Map editor  
**Engine:** Godot 3.6  
**Languages:** GDScript and/or C#  
**Target platforms:** PC and mobile (landscape)

---

## Overview

*No Frontier : SOG Vietnam* is a tactical game built around lethal combat, meaningful positioning, weapon handling, terrain, and projectile behavior. Rather than relying on large health pools, combat is designed to resolve quickly: a few well-placed shots can kill or incapacitate a unit.

The intended experience combines turn-based planning with selected real-time simulation elements. Movement, terrain, line of sight, weapon condition, ammunition, and the consequences of stray projectiles should all matter.

This README describes the **early project scope and intended design**. It does not imply that every listed system is already implemented.

## Core Design Pillars

- **High lethality:** Units use a brutal 3-HP model. Combat should be dangerous and decisive.
- **Physics-driven outcomes:** Projectiles interact with the world rather than resolving every shot as a simple hit-chance roll.
- **Tactical positioning:** Facing, line of sight, cover, terrain, and movement routes influence survival.
- **Meaningful resource costs:** Action points (AP), ammunition, weapon condition, and maintenance affect tactical choices.
- **Emergent chaos:** Bursts can miss, hit unintended targets, or strike civilians. Actions can have consequences beyond the intended target.
- **Turn-based tactics with real-time reactions:** The game remains turn-based, while selected mechanics—especially overwatch—can resolve while units continue moving.

## Current Development Scope

### Map Editor

The current focus is the **map editor**. Work on other gameplay systems should be treated as future scope unless explicitly brought into the current development plan.

The intended map and terrain pipeline includes:

- Heightmap-based terrain on a flat base plane, adjusted with noise.
- Grid generation by sampling terrain at grid coordinates with downward raycasts.
- Slope evaluation using terrain or mesh normals; slopes above a configured threshold are marked non-walkable.
- Procedural placement of trees, bushes, rocks, and other entities using terrain height, slope, and OpenSimplexNoise density maps.
- Terrain and object data that can later support movement costs, line-of-sight obstruction, and tactical cover.

The editor's precise feature list, save format, and implementation status should be documented as they are confirmed during development.

## Planned Combat Design

### Lethality and Health

- Units have **3 HP**.
- A small number of hits can kill or incapacitate a unit.
- Combat should avoid inflated health pools and damage-sponge enemies.

### Aiming and Shooting

- **Free Aim (0 AP):** Direct shot attempt using projectile simulation and relevant visibility checks.
- **Aim Weapon (1 AP):** Improves the shot's precision or hit chance according to the intended aiming rules.

> Implementation note: projectile collision is intended for hit detection. Raycasts may still be useful for line-of-sight or visibility checks; those are separate from the bullet's actual travel and collision.

### Projectile Physics and Ricochet

- Bullets should travel through the world and collide with physical targets and obstacles.
- Ricochet is intended for suitable hard surfaces, such as rocks, concrete, and steel helmets, at shallow glancing angles (initial design target: below roughly 35°).
- Ricochet direction is based on the impact surface normal and a reflected/bounced direction vector.
- A ricochet should reduce projectile velocity and damage.

The exact angle convention, material response, and collision implementation remain tuning and engineering details.

### Directional Overwatch

Overwatch is intended to adapt the familiar reaction-fire concept to the game's high lethality while allowing movement to continue.

- A unit establishes overwatch by setting its facing direction.
- Weapon type and soldier stats influence effective range and firing-cone width.
- An enemy entering the watched sector can trigger a reaction engagement if the other conditions are met.
- Units continue moving while reaction fire resolves; movement is not globally paused.
- Terrain such as rivers and uphill slopes can slow movement, increasing the time spent exposed to a watched sector.
- **Overwatch accuracy is deliberately poor.** Projectiles may miss the intended target or hit other entities, potentially including civilians.
- Detection, reaction engagement, and projectile collision are distinct stages: detecting a target does not guarantee that a projectile will hit it.

#### AP and reaction firing

- The current design calls for a **minimum of 4 AP** to activate overwatch.
- The number of reaction engagements is limited by the available AP budget.
- Each detected target can trigger one engagement, subject to the remaining budget and reaction rules.
- One engagement may produce different numbers of projectiles depending on the weapon.

Illustrative weapon behavior:

| Weapon class | Intended overwatch behavior |
|---|---|
| Sniper rifle | Single shot |
| Assault rifle | Burst |
| Machine gun | Long burst |

Exact AP accounting, burst sizes, reaction timing, target re-trigger rules, and simultaneous-reaction ordering remain implementation and balancing decisions.

### Weapons, Action Points, and Maintenance

Initial firing-mode and AP design:

| Weapon class / example | Mode | AP cost |
|---|---|---:|
| Assault rifle (M16, Type 56) | Single shot | 1 |
| Assault rifle (M16, Type 56) | Burst fire | 2 |
| Machine gun (M60, RPD) | Burst fire | 2 |
| Machine gun (M60, RPD) | Suppressive fire | 4 |
| Sniper rifle (M14, SVD Dragunov) | Single shot | 1 |
| Sniper rifle (M14, SVD Dragunov) | Aimed shot | 3 |
| Bolt-action rifle (Mosin-Nagant) | Single shot plus manual bolt cycle | 2 |
| Pump-action shotgun | Single shot plus manual cocking | 2 |

These are intended design values and may be adjusted during implementation and testing.

#### Jamming

- If a weapon jams during a firing queue, the remaining queue is cleared without an AP refund.
- Unjamming costs 4 AP when the unit has at least 4 AP remaining.
- If the unit has fewer than 4 AP, the weapon remains jammed until the next turn.

#### Machine-gun heat and barrel handling

- Machine guns can avoid thermal lockout while a spare barrel is available in inventory.
- Overheating accelerates weapon degradation and reduces accuracy.
- Swapping or cooling a hot barrel costs 4 AP.
- Hot barrels cool passively over several turns while in inventory.

#### Durability and maintenance

- Weapon Cleaning Kit: restores 15% condition.
- Weapon Spare Parts: restores 45% condition.
- At **0% durability**, a weapon is permanently broken and cannot be repaired; the unit must switch weapons or acquire another one.

## Terrain, Movement, and Cover

The terrain system is intended to support tactical decisions, not just visual variety.

- **Movement cost:** terrain can change how quickly a unit crosses an area.
- **Walkability:** slope thresholds determine whether grid locations are traversable.
- **Hard cover and obstruction:** rocks and trees can block movement and line of sight, according to their collision and cover definitions.
- **Soft cover:** bushes may permit movement while providing stealth or other tactical modifiers.
- **Visibility and cover are separate properties:** difficult terrain does not automatically conceal a unit, and an object that conceals a unit does not necessarily stop bullets.

Terrain behavior and cover rules should be represented as data wherever practical, so the map editor can author levels that later gameplay systems interpret consistently.

## Planned Tactical HUD

The target UI is designed for mobile landscape and should also work on PC.

| Screen area | Intended content |
|---|---|
| Top-left | Minimap, including player squad and VC units |
| Left panel | Vertical unit portraits, 3-heart HP indicators, and AP bars |
| Bottom-left | Primary and secondary weapon displays, including ammunition and magazine status |
| Bottom-center | Main actions: Shot, Move, and Task |
| Top-right | Menu button |
| Bottom-right | End Turn button |

## Technical Direction

- **Engine:** Godot 3.6.
- **Scripting:** GDScript and/or C#.
- **Terrain:** Heightmap-based terrain with noise-based elevation adjustment.
- **Grid:** Terrain sampling using raycasts and normal-based slope evaluation.
- **Placement:** Procedural entity placement informed by terrain data and noise density maps.
- **Combat projectiles:** Physical projectile movement and collision for hit detection.
- **Simulation:** Turn-based action economy with explicitly scheduled reaction events for mechanics such as overwatch.

Prefer separating terrain data, unit state, weapon state, AP rules, and projectile behavior so systems can be tested independently and connected incrementally.

## Early Development Priorities

1. Build and validate the map editor workflow.
2. Establish terrain, grid, walkability, and object-placement data.
3. Define how maps are saved, loaded, and validated.
4. Build unit movement and terrain-cost handling.
5. Implement projectile collision and damage resolution.
6. Add AP management, turns, weapon states, and reaction events.
7. Integrate enemy behavior and the tactical HUD.

These are suggested dependencies, not a claim that the later systems are currently underway. **The active scope remains the map editor.**

## Design Questions to Resolve Later

- What is the authoritative map data and save-file format?
- How are terrain materials and projectile ricochet properties represented?
- How are AP costs allocated across multi-projectile bursts and reaction engagements?
- What is the precise overwatch detection and re-trigger rule?
- How are simultaneous reaction shots ordered?
- How are civilian casualties and other unintended hits represented in mission outcomes?
- Which systems should be data-driven resources versus node-based scene logic?

## Project Status

This is an early-scope design document. Values and mechanics described here are current design intentions, not guarantees that they are implemented, finalized, or balanced.

The immediate focus is the **map editor**. Expand this document as features become implemented and tested.
