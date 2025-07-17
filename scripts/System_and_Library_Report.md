# System and Library Report

This document provides an overview of every module and script in the __MasterScript project, including detailed descriptions, common usage scenarios, dependencies, and suggestions for future improvements.

---

## 1. ReplicatedStorage Modules

### 1.1 Auxiliary Modules
| Name                                                       | Description                                                        | Use Scenarios                                                | Dependencies                                  | Future Improvements                                     | Notes                  |
|------------------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------|-----------------------------------------------|---------------------------------------------------------|------------------------|
| Auxiliary/FaceToMouse.luau                                  | Calculates world-space CFrame or direction from object to mouse    | Aiming projectiles, UI selection                            | UserInputService, Camera                      | Add smoothing, custom offsets                          | -                      |
| Auxiliary/GameplayUtilities.luau                            | Collection of generic gameplay helper functions                    | Health/damage calculations, cooldown timers                 | None                                          | Convert to event-driven API, add documentation          | -                      |
| Auxiliary/RockModule.luau                                   | Handles rock/projectile creation, trajectory, collision effects    | Earth-based ability effects                                 | PartModule, Physics service                    | Refactor for extensible ability parameters              | Also see RockModule2   |
| Auxiliary/RockModule2/init.luau                             | Improved rock spawning with style presets                          | Advanced geological effects                                  | Styles.luau                                  | Merge common logic with RockModule                     |
| Auxiliary/RockModule2/Styles.luau                           | Defines rock appearance presets                                     | Theming rock effects                                         | None                                          | Expose more style parameters                           |
| Auxiliary/CameraShaker/init.luau                             | Base manager for camera shake events                                | Impact feedback, explosions                                   | RunService, Camera                            | Support multiplayer/local-only shake grouping           |
| Auxiliary/CameraShaker/CameraShakeInstance.luau             | Represents an individual camera shake instance                     | Controlling shake duration and magnitude                     | CameraShakePresets.luau                      | Object pooling, auto-cleanup                            |
| Auxiliary/CameraShaker/CameraShakePresets.luau              | Predefined camera shake configurations                              | Standardized shake for hits, explosions                      | None                                          | Add presets for unique abilities                         |
| Auxiliary/LightningBolt/init.luau                            | Core lightning bolt effect controller                               | Visual FX for lightning abilities                            | LightningSparks.luau, ExplosionBrightspot      | Expose timing and color parameters                      |
| Auxiliary/LightningBolt/LightningSparks.luau                | Particle-based spark effect for bolts                               | Charged lightning visuals                                     | ParticleEmitter assets                       | Add spark branching logic                                 |
| Auxiliary/LightningBolt/ExplosionBrightspot/init.meta.json* | Configuration for a brightspot particle emitter                     | Lightning explosion highlights                                | ParticleEmitter asset                        | Adjust size/time curves for dramatic flair             |

### 1.2 Main Modules
| Name                                                       | Description                                                        | Use Scenarios                                                | Dependencies                                  | Future Improvements                                     | Notes                  |
|------------------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------|-----------------------------------------------|---------------------------------------------------------|------------------------|
| Main/ProjectilePresets.luau                                 | Defines preset parameters (speed, size, textures) for projectiles   | Standardizing projectile behavior                             | None                                          | Add more presets, data-driven JSON import                |

### 1.3 Shared Modules
| Name                          | Description                                              | Use Scenarios                                    | Dependencies         | Future Improvements                           | Notes    |
|-------------------------------|----------------------------------------------------------|--------------------------------------------------|----------------------|-----------------------------------------------|----------|
| Shared/Bezier.luau            | Cubic Bezier interpolation                                | Smooth animation, movement paths                 | None                 | Expose higher-order curves                    | -        |
| Shared/ClickDetector.luau     | Wrapper for ClickDetector with promise/callback support   | UI buttons, world click interactions             | None                 | Add debounce/throttle                          |
| Shared/CombatModule.luau      | Basic combat logic (attack, defense, states)             | Player/NPC combat                               | GameplayUtilities.luau| Extract state machine, add network syncing     |
| Shared/CreateWeld.luau        | Helper to weld two parts together                         | Weapon attachments, vehicle parts                | None                 | Support dynamic breaking                     |
| Shared/FindGroundPos.luau     | Raycast helper to find ground position                    | Projectile landing, character placement          | Workspace, RaycastService| Cache results for optimization               |
| Shared/MockPart.luau          | Creates dummy Parts for testing and effects               | Offscreen previews                               | None                 | Extend to other Instance types                |
| Shared/MouseModule.luau       | Abstraction over mouse input events                       | Custom cursor, mouse-driven aiming               | UserInputService    | Gesture support                             |
| Shared/PerformanceModule.luau | Tools for profiling and throttling heavy operations       | Debugging, frame-rate management                  | RunService          | Visual overlay, logging to file              |
| Shared/PartCircleModule.luau  | Generates circular arrangement of parts                   | AoE effects, markers                              | None                 | 3D and 2D variant                            |
| Shared/ViewportHandler.luau   | Manages ViewportFrames for 3D previews                   | UI previews, item showcases                      | Roblox GUI           | Support multiple concurrent viewports         |
| Shared/OTS.luau               | On-the-spot utility functions                             | General use                                      | None                 | Clarify purpose or rename                    |
| Shared/SimplePath.luau        | Straight-line path callback over time                     | Movement scripting                               | RunService          | Integrate obstacle avoidance                 |
| Shared/Velocity.luau          | Functions for velocity calculation and interpolation      | Physics-based movement                          | None                 | Add vector smoothing                          |

### 1.4 Templates
| Name                                        | Description                                | Use Scenarios                  | Dependencies                  | Future Improvements                 | Notes                 |
|---------------------------------------------|--------------------------------------------|--------------------------------|-------------------------------|--------------------------------------|-----------------------|
| Templates/AbilityTemplate.luau              | Base class/template for defining abilities | Creating new ability modules   | None                          | Documentation, esemples             |
| Templates/Abilities/AmberHit.luau           | Particle and sound logic for amber hits    | Ability "Amber" effects      | AbilityTemplate.luau          | Parameterize color, timing            |
| Templates/Abilities/Baal.luau               | Visual and logic for "Baal" ability      | Ability "Baal" execution     | AbilityTemplate.luau          | Separate FX and logic                 |
| Templates/Abilities/Lightning.luau          | Lightning effect logic                     | Ability "Lightning" execution | LightningBolt (auxiliary)     | Sync with audio, network optimization |

### 1.5 Third-Party Libraries
| Name                          | Description                                        | Use Scenarios                   | Dependencies      | Future Improvements                 | Notes                      |
|-------------------------------|----------------------------------------------------|---------------------------------|-------------------|--------------------------------------|----------------------------|
| ThirdParty/Fusion/init.luau   | UI-reactive library for ROBLOX                     | Building reactive UI screens    | None              | Upgrade to latest Fusion version     |
| ThirdParty/Fluent Renewed/init.luau | Fluent UI-inspired widget library           | Stylized UI components          | Fusion            | Update naming conventions            |

---

## 2. ServerScriptService & Workspace Scripts
*(List any .server.luau or scripts under ServerScriptService / StarterPlayer / Workspace)*

*Note: Several scripts under `ServerScriptService`, `StarterPlayerScripts`, and `Workspace` are auto-generated or game-specific; please document these individually as needed.*

---

## 3. Future System Improvements & Roadmap
- Convert all utility modules to typed Luau interfaces where possible.
- Migrate particle configurations from `.meta.json` into data-driven tables.
- Implement automated tests for core shared modules.
- Provide extensive in-code documentation and update `selene.toml` lint rules.
- Evaluate performance hotspots via `PerformanceModule` and optimize heavy loops.

---

## 4. Full Module File List with Hyperlinks

Below is a complete, recursive list of all module and script files under `src/ReplicatedStorage/Modules`, with links to each file.

- **Modules/**
  - **Auxiliary/**
    - [FaceToMouse.luau](../src/ReplicatedStorage/Modules/Auxiliary/FaceToMouse.luau)
    - [GameplayUtilities.luau](../src/ReplicatedStorage/Modules/Auxiliary/GameplayUtilities.luau)
    - [RockModule.luau](../src/ReplicatedStorage/Modules/Auxiliary/RockModule.luau)
    - **RockModule2/**
      - [init.luau](../src/ReplicatedStorage/Modules/Auxiliary/RockModule2/init.luau)
      - [Styles.luau](../src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Styles.luau)
      - **Rocks/**
        - **Spike/**
          - [init.meta.json](../src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Rocks/Spike/init.meta.json)
    - **CameraShaker/**
      - [init.luau](../src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/init.luau)
      - [CameraShakeInstance.luau](../src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakeInstance.luau)
      - [CameraShakePresets.luau](../src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakePresets.luau)
    - **LightningBolt/**
      - [init.luau](../src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/init.luau)
      - [LightningSparks.luau](../src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningSparks.luau)
      - **LightningExplosion/**
        - [init.luau](../src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningExplosion/init.luau)
        - **GlareEmitter/**
          - (Emitter assets directory)
        - **PlasmaEmitter/**
          - (Emitter assets directory)
        - **ExplosionBrightspot/**
          - [init.meta.json](../src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningExplosion/ExplosionBrightspot/init.meta.json)
  - **Main/**
    - [ProjectilePresets.luau](../src/ReplicatedStorage/Modules/Main/ProjectilePresets.luau)
  - **Shared/**
    - [Bezier.luau](../src/ReplicatedStorage/Modules/Shared/Bezier.luau)
    - **BezierTweens/**
      - [init.luau](../src/ReplicatedStorage/Modules/Shared/BezierTweens/init.luau)
      - [Lerps.luau](../src/ReplicatedStorage/Modules/Shared/BezierTweens/Lerps.luau)
      - [TweenFunctions.luau](../src/ReplicatedStorage/Modules/Shared/BezierTweens/TweenFunctions.luau)
    - [BoatTween.luau](../src/ReplicatedStorage/Modules/Shared/BoatTween.luau)
    - [ClickDetector.luau](../src/ReplicatedStorage/Modules/Shared/ClickDetector.luau)
    - **CombatHandler/**
      - [init.luau](../src/ReplicatedStorage/Modules/Shared/CombatHandler/init.luau)
      - **CombatHitbox/**
        - [init.meta.json](../src/ReplicatedStorage/Modules/Shared/CombatHandler/CombatHitbox/init.meta.json)
        - **DmgPoint/**
          - [init.meta.json](../src/ReplicatedStorage/Modules/Shared/CombatHandler/CombatHitbox/DmgPoint/init.meta.json)
    - [CombatModule.luau](../src/ReplicatedStorage/Modules/Shared/CombatModule.luau)
    - [CreateWeld.luau](../src/ReplicatedStorage/Modules/Shared/CreateWeld.luau)
    - [FindGroundPos.luau](../src/ReplicatedStorage/Modules/Shared/FindGroundPos.luau)
    - [MockPart.luau](../src/ReplicatedStorage/Modules/Shared/MockPart.luau)
    - [MouseModule.luau](../src/ReplicatedStorage/Modules/Shared/MouseModule.luau)
    - [PerformanceModule.luau](../src/ReplicatedStorage/Modules/Shared/PerformanceModule.luau)
    - [PartCircleModule.luau](../src/ReplicatedStorage/Modules/Shared/PartCircleModule.luau)
    - [ViewportHandler.luau](../src/ReplicatedStorage/Modules/Shared/ViewportHandler.luau)
    - [OTS.luau](../src/ReplicatedStorage/Modules/Shared/OTS.luau)
    - [SimplePath.luau](../src/ReplicatedStorage/Modules/Shared/SimplePath.luau)
    - [Velocity.luau](../src/ReplicatedStorage/Modules/Shared/Velocity.luau)
    - ...and other utility scripts
  - **Templates/**
    - [AbilityTemplate.luau](../src/ReplicatedStorage/Modules/Templates/AbilityTemplate.luau)
    - **Abilities/**
      - [AmberHit.luau](../src/ReplicatedStorage/Modules/Templates/Abilities/AmberHit.luau)
      - [Baal.luau](../src/ReplicatedStorage/Modules/Templates/Abilities/Baal.luau)
      - [Lightning.luau](../src/ReplicatedStorage/Modules/Templates/Abilities/Lightning.luau)
      - ...other ability templates
  - **ThirdParty/**
    - **Fusion/**
      - [init.luau](../src/ReplicatedStorage/Modules/ThirdParty/Fusion/init.luau)
      - [External.luau](../src/ReplicatedStorage/Modules/ThirdParty/Fusion/External.luau)
    - **Fluent Renewed/**
      - [init.luau](../src/ReplicatedStorage/Modules/ThirdParty/Fluent Renewed/init.luau)
    - **Roact/**
      - (Roact library files and folders)

---

*Report generated on July 17, 2025.*
