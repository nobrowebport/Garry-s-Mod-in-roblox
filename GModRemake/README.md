# GMod Remake (Roblox)

This is a Garry's Mod sandbox for Roblox Studio. The gameplay code is new. The content comes from **your own Garry's Mod install** and is converted locally:

| GMod content | Converted to | How Roblox loads it |
|---|---|---|
| `.mdl/.vvd/.vtx` models: props, physgun, toolgun, balloon, thruster | Mesh data in `src/ReplicatedStorage/GModAssets` | Built into `EditableMesh` → `MeshPart` while the game runs |
| `gm_flatgrass.bsp`, `gm_construct.bsp` | Brushes, displacements, water, static props, sky in `GModAssets/Maps` | Ordinary Parts/WedgeParts with the real textures on each face (no special permissions needed) |
| `.vtf` textures | PNGs in `<Studio>/content/textures/gmr` | Prop textures go into `EditableImage` (so Colour and Paint work); map textures load straight from `rbxasset://` |
| Derma skin, notice icons, silkicons, spawn icons, HL2/Roboto fonts (+ Tahoma/Verdana from Windows) | `<Studio>/content/textures/gmr`, `content/fonts` | GMod-style HUD, notifications and spawn menu |
| `.wav` sounds: physgun, toolgun, impacts, UI, thrusters | WAVs in `<Studio>/content/sounds/gmr` | `rbxasset://sounds/gmr/...` (local audio) |

> ⚠️ **The built place contains Valve and Facepunch content. Keep it on your PC and never publish or upload it.**

## Setup
1. Run `setup.bat`. It does three things:
   - runs `tools/export-gmod.js`, which reads `C:\Program Files (x86)\Steam\steamapps\common\GarrysMod`; pass `--gmod "<path>"` if yours is elsewhere
   - builds `GModRemake.rbxlx`
   - installs the GMR Link plugin
2. Open `GModRemake.rbxlx` in Studio.
3. Turn on **Game Settings → Security → Allow Mesh / Image APIs**. Without it, props and guns fall back to textured boxes. The map doesn't need it.
4. Press **Play**.

To change the map, set `Map` in `src/ReplicatedStorage/Shared/Config.luau` to `"gm_flatgrass"` or `"gm_construct"`, then run `node tools/build.js`.

Studio updates delete the installed sounds and textures. Run `setup.bat` again after an update.

### Checking the converted content
`node tools/debug/render.js props` and `node tools/debug/render.js viewmodel Physgun idle 0` draw the exported models and viewmodels to `gmod-export/renders/`, so you can check them without Studio.

### If something looks wrong
These switches are in `Config.luau`:
- `FlipWinding = true` if meshes look inside-out.
- `FlipV = true` if textures look upside-down.

## Controls
| Key | Action |
|---|---|
| **F1** | Main menu (Start New Game / map select, Find Multiplayer Game, Options, Disconnect) |
| Hold **Tab** | Scoreboard |
| Hold **Q** | Spawn menu (Props / Tools / Utilities) |
| **1 / 2 / 3** | Physgun / Toolgun / Hands |
| LMB (physgun) | Grab a prop. Scroll changes distance, **E** + mouse rotates, **RMB** freezes it |
| **R** | Physgun: unfreeze the aimed prop. Toolgun: clear the half-finished selection |
| **Shift** / **Ctrl** | Run / crouch (Source movement: friction, air strafing) |
| **Z** | Undo |
| **V** | Noclip |
| **F** | Flashlight |
| **G** | Toggle your thrusters |

## Linking Studio instances
1. Run `start-relay.bat`.
2. Press Play in each Studio you want to link.
3. Other Studios' players show up as name-tagged avatars, their props are mirrored, and chat is forwarded.
4. On another PC, enter the relay machine's LAN IP in **Spawn menu → Utilities**.

## Layout
- `tools/export-gmod.js` is the converter. Its readers for VPK, VTF, MDL/VVD/VTX, BSP, VMT and WAV are in `tools/gmod/`.
- `src/ReplicatedStorage/Shared/Assets.luau` turns mesh data into EditableMesh parts.
- `src/StarterPlayerScripts/Modules/Visuals.luau` puts the real meshes onto props, weapons and the map.
- `src/ServerScriptService/Modules/MapBuilder.luau` sets up map collision, spawns and the sky.
