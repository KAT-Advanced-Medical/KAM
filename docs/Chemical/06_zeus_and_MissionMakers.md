# Zeus & Mission makers

---

## Delivering Gas (Mission Makers & Zeus)

There are several ways to put gas on the map.

### Gas module (`kat_module_gas`)

The most direct method. In the editor it's under **Modules → KAT → "Create contaminated area / object"**, and the same module is available in **Zeus**.

- **Gas Type** dropdown:

  | Value | Label |
  |-------|-------|
  | 0 | Tear gas (Level 0) |
  | 1 | Chlorine (Level 1) *(default)* |
  | 2 | Phosgene (Level 1) |
  | 3 | Mustard gas (Level 2) |
  | 4 | Sarin (Level 2) |
  | 5 | VX (Level 2) |

- **Radius** — area size in metres (default 20).
- **IsSealable** — if synced to an object, allows the leak to be sealed with a sealant tube.

### Mortars (82 mm)

Load these single-round magazines into a player-crewed 82 mm mortar (`ACE_mortar_82mm`):

| Round | Agent |
|-------|-------|
| `KAT_1Rnd_82mm_Mo_Type0` | Chlorine |
| `KAT_1Rnd_82mm_Mo_Type0_Cluser` | Chlorine (cluster) |
| `KAT_1Rnd_82mm_Mo_TypeCS` | CS / tear gas |
| `KAT_1Rnd_82mm_Mo_Type2` | Phosgene |
| `KAT_1Rnd_82mm_Mo_Type3` | Mustard |
| `KAT_1Rnd_82mm_Mo_Type4` | Sarin |
| `KAT_1Rnd_82mm_Mo_Type5` | VX |

Hand them out via the **`ACE_Box_82mm_Mo_Gas`** ammo box, which contains 8× chlorine, 8× chlorine cluster, 8× CS, and 4× each of phosgene, mustard, sarin, and VX.

> **AI mortar restriction:** AI-crewed mortars are deliberately limited to **choking agents only** (CS, chlorine, and chlorine cluster). Nerve and blister agents are restricted to deliberate, player-driven placement so the AI can't casually drop a sarin barrage.

### Other delivery

- **`KAT_M7A3`** — M7A3 hand-thrown CS gas grenade.
- **`KAT_Gas_TripWireMine_Mag`** — tripwire mine that releases gas when triggered.
- **CAS munitions** — `KAT_CAS_M43_*` laser-guided cluster bomb and `KAT_CAS_R_80mm_GAS_*` rocket pod, for aircraft loadouts.

---

## Mission Configuration (CBA Settings)

All of the below live under **CBA Settings → KAT - ADV Medical: Chemical**. Defaults are realistic; tune them to fit your mission's pace and lethality. Times are in seconds.

### Protection & Gear

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Accepted gas masks | `G_AirPurifyingRespirator_01_F`, `kat_mask_M50`, `kat_mask_M04` | text | Mask classnames that protect against gas |
| Available CBRN Suit Uniforms | `'U_C_CBRN_Suit_01_Blue_F'` | text | **Uniform classnames that count as full CBRN protection** (required for mustard/sarin/VX) |
| Gas masks durability | 900 | 1–3600 | Seconds of protection before the filter is spent |
| Gas Mask Sound Volume | 1 | 0–2 | Loudness of the breathing sound while masked |
| Enable Stamina Loss when using Gas Mask | off | on/off | Masked units tire faster |
| Show Poisoning | on | on/off | Whether poisoning/intoxication appears in the medical menu |
| Enable Smell Hint | on | on/off | Whether unmasked units get the one-shot smell hint |
| Enable Gas particle effects | on | on/off | Whether visible gas-cloud particles are spawned (turn off for performance, or to hide clouds) |

> **The one setting you'll most often change** is *Available CBRN Suit Uniforms*. It's an editbox of **quoted, comma-separated classnames**, e.g. `'U_C_CBRN_Suit_01_Blue_F','U_B_CBRN_Suit'`. Add the suits your loadout mods provide, or Level 2 agents will affect everyone wearing anything else.

### CS Gas (Level 0)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Drop Weapon Chance | 0 | 0–1 | Chance per check to drop your weapon while in tear gas |

### Chlorine (Level 1)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Chlorine: Onset Time | 30 | 0–3600 | Seconds in the cloud before chlorine symptoms begin |

### Phosgene (Level 1)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Phosgene: Onset Min | 120 | 0–3600 | Earliest the delayed pulmonary edema can appear |
| Phosgene: Onset Max | 360 | 0–3600 | Latest the delayed pulmonary edema can appear |

### Mustard (Level 2)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Mustard: Eye Onset Min | 40 | 0–3600 | Earliest eye injuries appear |
| Mustard: Eye Onset Max | 100 | 0–3600 | Latest eye injuries appear |
| Mustard: Burn Onset Min | 100 | 0–3600 | Earliest skin burns appear |
| Mustard: Burn Onset Max | 240 | 0–3600 | Latest skin burns appear |

### Sarin (Level 2)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Sarin: Vomit Time | 30 | 0–3600 | Seconds to vomiting |
| Sarin: Unconsciousness Time | 60 | 0–3600 | Seconds to unconsciousness |
| Sarin: Cardiac Arrest Time | 90 | 0–3600 | Seconds to (fatal) cardiac arrest |

### VX (Level 2)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| VX: Vomit Time | 60 | 0–3600 | Seconds to vomiting |
| VX: Unconsciousness Time | 120 | 0–3600 | Seconds to unconsciousness |
| VX: Cardiac Arrest Time | 240 | 0–3600 | Seconds to (fatal) cardiac arrest |
| VX: Cloud Lifetime | 600 | 0–3600 | How long VX clouds persist |

### Contamination & Decontamination

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| Contamination Tick Interval | 40 | 1–3600 | Seconds between re-poison ticks for mustard/VX until deconned |
| Decontamination Duration | 8 | 1–600 | How long the decon self-action takes |

### Identification (Detector & M8 Paper)

| Setting | Default | Range | What it does |
|---------|---------|-------|--------------|
| M8 Paper Use Duration | 3 | 1–600 | How long the M8 wipe action takes |
| Cloud ID Memory | 30 | 0–3600 | How long the last-cloud agent is remembered (drives M8 paper and detector) |
| M8 Paper Display Time | 8 | 1–600 | How long the M8 result stays on screen |

---
