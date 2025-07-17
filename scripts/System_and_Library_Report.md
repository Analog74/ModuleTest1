# System and Library Report

This document provides an overview of every module and script in the __MasterScript project, including detailed descriptions, common usage scenarios, dependencies, and suggestions for future improvements.

---

## 1. ReplicatedStorage Modules

### 1.1 Auxiliary Modules
| Name | Description | Use Scenarios | Dependencies | Future Improvements | Notes |
|------|-------------|---------------|--------------|---------------------|-------|
| [FaceToMouse.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/FaceToMouse.luau) | Calculates world-space CFrame or direction from object to mouse | Aiming projectiles, UI selection | UserInputService, Camera | Add smoothing, custom offsets | - |
| [GameplayUtilities.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/GameplayUtilities.luau) | Collection of generic gameplay helper functions | Health/damage calculations, cooldown timers | None | Convert to event-driven API, add documentation | - |
| [RockModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule.luau) | Handles rock/projectile creation, trajectory, collision effects | Earth-based ability effects | PartModule, Physics service | Refactor for extensible ability parameters | Also see RockModule2 |
| [RockModule2/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/init.luau) | Improved rock spawning with style presets | Advanced geological effects | [Styles.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Styles.luau) | Merge common logic with RockModule | - |
| [RockModule2/Styles.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Styles.luau) | Defines rock appearance presets | Theming rock effects | None | Expose more style parameters | - |
| [CameraShaker/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/init.luau) | Base manager for camera shake events | Impact feedback, explosions | RunService, Camera | Support multiplayer/local-only shake grouping | - |
| [CameraShaker/CameraShakeInstance.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakeInstance.luau) | Represents an individual camera shake instance | Controlling shake duration and magnitude | [CameraShakePresets.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakePresets.luau) | Object pooling, auto-cleanup | - |
| [CameraShaker/CameraShakePresets.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakePresets.luau) | Predefined camera shake configurations | Standardized shake for hits, explosions | None | Add presets for unique abilities | - |
| [LightningBolt/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/init.luau) | Core lightning bolt effect controller | Visual FX for lightning abilities | [LightningSparks.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningSparks.luau), ExplosionBrightspot | Expose timing and color parameters | - |
| [LightningBolt/LightningSparks.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningSparks.luau) | Particle-based spark effect for bolts | Charged lightning visuals | ParticleEmitter assets | Add spark branching logic | - |
| [LightningBolt/ExplosionBrightspot/init.meta.json](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningExplosion/ExplosionBrightspot/init.meta.json) | Configuration for a brightspot particle emitter | Lightning explosion highlights | ParticleEmitter asset | Adjust size/time curves for dramatic flair | - |

### 1.2 Main Modules
| Name | Description | Use Scenarios | Dependencies | Future Improvements | Notes |
|------|-------------|---------------|--------------|---------------------|-------|
| [ProjectilePresets.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Main/ProjectilePresets.luau) | Defines preset parameters (speed, size, textures) for projectiles | Standardizing projectile behavior | None | Add more presets, data-driven JSON import | - |

### 1.3 Shared Modules
| Name | Description | Use Scenarios | Dependencies | Future Improvements | Notes |
|------|-------------|---------------|--------------|---------------------|-------|
| [Bezier.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/Bezier.luau) | Cubic Bezier interpolation | Smooth animation, movement paths | None | Expose higher-order curves | - |
| [ClickDetector.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/ClickDetector.luau) | Wrapper for ClickDetector with promise/callback support | UI buttons, world click interactions | None | Add debounce/throttle | - |
| [CombatModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CombatModule.luau) | Basic combat logic (attack, defense, states) | Player/NPC combat | [GameplayUtilities.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/GameplayUtilities.luau) | Extract state machine, add network syncing | - |
| [CreateWeld.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CreateWeld.luau) | Helper to weld two parts together | Weapon attachments, vehicle parts | None | Support dynamic breaking | - |
| [FindGroundPos.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/FindGroundPos.luau) | Raycast helper to find ground position | Projectile landing, character placement | Workspace, RaycastService | Cache results for optimization | - |
| [MockPart.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/MockPart.luau) | Creates dummy Parts for testing and effects | Offscreen previews | None | Extend to other Instance types | - |
| [MouseModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/MouseModule.luau) | Abstraction over mouse input events | Custom cursor, mouse-driven aiming | UserInputService | Gesture support | - |
| [PerformanceModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/PerformanceModule.luau) | Tools for profiling and throttling heavy operations | Debugging, frame-rate management | RunService | Visual overlay, logging to file | - |
| [PartCircleModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/PartCircleModule.luau) | Generates circular arrangement of parts | AoE effects, markers | None | 3D and 2D variant | - |
| [ViewportHandler.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/ViewportHandler.luau) | Manages ViewportFrames for 3D previews | UI previews, item showcases | Roblox GUI | Support multiple concurrent viewports | - |
| [OTS.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/OTS.luau) | On-the-spot utility functions | General use | None | Clarify purpose or rename | - |
| [SimplePath.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/SimplePath.luau) | Straight-line path callback over time | Movement scripting | RunService | Integrate obstacle avoidance | - |
| [Velocity.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/Velocity.luau) | Functions for velocity calculation and interpolation | Physics-based movement | None | Add vector smoothing | - |

### 1.4 Templates
| Name | Description | Use Scenarios | Dependencies | Future Improvements | Notes |
|------|-------------|---------------|--------------|---------------------|-------|
| [AbilityTemplate.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/AbilityTemplate.luau) | Base class/template for defining abilities | Creating new ability modules | None | Documentation, examples | - |
| [AmberHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/AmberHit.luau) | Particle and sound logic for amber hits | Ability "Amber" effects | [AbilityTemplate.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/AbilityTemplate.luau) | Parameterize color, timing | - |
| [Baal.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Baal.luau) | Visual and logic for "Baal" ability | Ability "Baal" execution | [AbilityTemplate.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/AbilityTemplate.luau) | Separate FX and logic | - |
| [Lightning.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Lightning.luau) | Lightning effect logic | Ability "Lightning" execution | [LightningBolt/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/init.luau) | Sync with audio, network optimization | - |
| [LightningHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/LightningHit.luau) | Lightning hit particle and sound effect | Ability "Lightning" hit FX | [CameraShaker], [LightningBolt], [RockModule] | Add more lightning types | - |
| [Ayaka.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Ayaka.luau) | Visual FX and camera shake for Ayaka ability | Ability "Ayaka" execution | [CameraShaker], [LightningBolt], [RockModule] | Add more FX, parameterize shake | - |
| [Birdcage.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Birdcage.luau) | Creates a circular particle effect and sound | Ability "Birdcage" execution | [CameraShaker], [RockModule] | Add more geometry options | - |
| [BladeHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/BladeHit.luau) | Electric blade hit effect | Ability "Blade" execution | [CameraShaker], [LightningBolt] | Add more sound/particle variants | - |
| [DarkHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/DarkHit.luau) | Dark hit particle and sound effect | Ability "Dark" execution | [CameraShaker], [RockModule] | Add more visual variants | - |
| [FireballHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/FireballHit.luau) | Fireball hit particle and sound effect | Ability "Fireball" execution | [CameraShaker], [RockModule] | Add more fireball types | - |
| [GateHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GateHit.luau) | Sword gate hit effect | Ability "Gate" execution | [CameraShaker], [LightningBolt] | Add more gate types | - |
| [GateSword.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GateSword.luau) | Sword gate visual effect | Ability "GateSword" execution | [CameraShaker], [LightningBolt] | Add more sword types | - |
| [GeometryHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GeometryHit.luau) | Geometry hit particle and sound effect | Ability "Geometry" execution | [CameraShaker], [RockModule] | Add more geometry types | - |
| [HeartHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/HeartHit.luau) | Heart hit particle and sound effect | Ability "Heart" execution | [CameraShaker], [RockModule] | Add more heart types | - |
| [Hex.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Hex.luau) | Hex circle visual and sound effect | Ability "Hex" execution | [CameraShaker], [LightningBolt] | Add more hex types | - |
| [Ice Meteors Hit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Ice%20Meteors%20Hit.luau) | Ice meteors hit effect | Ability "Ice Meteors" execution | [CameraShaker], [RockModule] | Add more meteor types | - |
| [IceHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/IceHit.luau) | Ice hit particle and sound effect | Ability "Ice" execution | [CameraShaker], [RockModule] | Add more ice types | - |
| [LaserHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/LaserHit.luau) | Laser hit particle and sound effect | Ability "Laser" execution | [CameraShaker], [RockModule] | Add more laser types | - |
| [Meteors Hit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Meteors%20Hit.luau) | Meteor hit effect | Ability "Meteors" execution | [CameraShaker], [RockModule] | Add more meteor types | - |
| [Orb.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Orb.luau) | Orb visual and sound effect | Ability "Orb" execution | [CameraShaker], [LightningBolt] | Add more orb types | - |
| [PoisonGas.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/PoisonGas.luau) | Poison gas visual and sound effect | Ability "PoisonGas" execution | [CameraShaker], [RockModule] | Add more poison types | - |
| [Xiangling.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Xiangling.luau) | Xiangling ability visual and sound effect | Ability "Xiangling" execution | [CameraShaker], [LightningBolt] | Add more Xiangling types | - |
| [Xinyan.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Xinyan.luau) | Xinyan ability visual and sound effect | Ability "Xinyan" execution | [CameraShaker], [RockModule] | Add more Xinyan types | - |

### 1.5 Third-Party Libraries
| Name | Description | Use Scenarios | Dependencies | Future Improvements | Notes |
|------|-------------|---------------|--------------|---------------------|-------|
| [Fusion/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fusion/init.luau) | UI-reactive library for ROBLOX | Building reactive UI screens | None | Upgrade to latest Fusion version | - |
| [Fluent Renewed/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fluent%20Renewed/init.luau) | Fluent UI-inspired widget library | Stylized UI components | [Fusion/init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fusion/init.luau) | Update naming conventions | - |

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
    - [FaceToMouse.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/FaceToMouse.luau)
    - [GameplayUtilities.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/GameplayUtilities.luau)
    - [RockModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule.luau)
    - **RockModule2/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/init.luau)
      - [Styles.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Styles.luau)
      - **Rocks/**
        - **Spike/**
          - [init.meta.json](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/RockModule2/Rocks/Spike/init.meta.json)
    - **CameraShaker/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/init.luau)
      - [CameraShakeInstance.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakeInstance.luau)
      - [CameraShakePresets.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/CameraShaker/CameraShakePresets.luau)
    - **LightningBolt/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/init.luau)
      - [LightningSparks.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningSparks.luau)
      - **LightningExplosion/**
        - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningExplosion/init.luau)
        - **GlareEmitter/**
          - (Emitter assets directory)
        - **PlasmaEmitter/**
          - (Emitter assets directory)
        - **ExplosionBrightspot/**
          - [init.meta.json](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Auxiliary/LightningBolt/LightningExplosion/ExplosionBrightspot/init.meta.json)
  - **Main/**
    - [ProjectilePresets.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Main/ProjectilePresets.luau)
  - **Shared/**
    - [Bezier.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/Bezier.luau)
    - **BezierTweens/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/BezierTweens/init.luau)
      - [Lerps.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/BezierTweens/Lerps.luau)
      - [TweenFunctions.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/BezierTweens/TweenFunctions.luau)
    - [BoatTween.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/BoatTween.luau)
    - [ClickDetector.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/ClickDetector.luau)
    - **CombatHandler/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CombatHandler/init.luau)
      - **CombatHitbox/**
        - [init.meta.json](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CombatHandler/CombatHitbox/init.meta.json)
        - **DmgPoint/**
          - [init.meta.json](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CombatHandler/CombatHitbox/DmgPoint/init.meta.json)
    - [CombatModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CombatModule.luau)
    - [CreateWeld.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/CreateWeld.luau)
    - [FindGroundPos.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/FindGroundPos.luau)
    - [MockPart.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/MockPart.luau)
    - [MouseModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/MouseModule.luau)
    - [PerformanceModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/PerformanceModule.luau)
    - [PartCircleModule.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/PartCircleModule.luau)
    - [ViewportHandler.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/ViewportHandler.luau)
    - [OTS.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/OTS.luau)
    - [SimplePath.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/SimplePath.luau)
    - [Velocity.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Shared/Velocity.luau)
    - ...and other utility scripts
  - **Templates/**
    - [AbilityTemplate.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/AbilityTemplate.luau)
    - **Abilities/**
      - [AmberHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/AmberHit.luau)
      - [Baal.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Baal.luau)
      - [Lightning.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Lightning.luau)
      - [LightningHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/LightningHit.luau)
      - [Ayaka.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Ayaka.luau)
      - [Birdcage.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Birdcage.luau)
      - [BladeHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/BladeHit.luau)
      - [DarkHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/DarkHit.luau)
      - [FireballHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/FireballHit.luau)
      - [GateHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GateHit.luau)
      - [GateSword.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GateSword.luau)
      - [GeometryHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/GeometryHit.luau)
      - [HeartHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/HeartHit.luau)
      - [Hex.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Hex.luau)
      - [Ice Meteors Hit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Ice%20Meteors%20Hit.luau)
      - [IceHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/IceHit.luau)
      - [LaserHit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/LaserHit.luau)
      - [Meteors Hit.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Meteors%20Hit.luau)
      - [Orb.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Orb.luau)
      - [PoisonGas.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/PoisonGas.luau)
      - [Xiangling.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Xiangling.luau)
      - [Xinyan.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/Templates/Abilities/Xinyan.luau)
  - **ThirdParty/**
    - **Fusion/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fusion/init.luau)
      - [External.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fusion/External.luau)
    - **Fluent Renewed/**
      - [init.luau](https://github.com/Analog74/ModuleTest1/blob/master/src/ReplicatedStorage/Modules/ThirdParty/Fluent Renewed/init.luau)
    - **Roact/**
      - (Roact library files and folders)

---

*Report generated on July 17, 2025.*
