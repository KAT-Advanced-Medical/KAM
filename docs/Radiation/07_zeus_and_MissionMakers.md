# Zeus & Mission Makers

How to put radiation on the map, and how to tune every part of it.

## Placing radiation sources

A source emits any mix of the four types, each with its own strength in **Gy/h**. You author that mix either by hand (the four per-type fields) or by picking a **preset** that fills them for you.

### Radiation module (`kat_module_radiation`)

In the editor under **Modules → KAT**, and the same module is available in **Zeus** as a curator module. Its attributes:

- **Preset** — a dropdown that fills the four strength fields for you. Pick `Custom` to use the fields directly, or any named preset to auto-fill them.
- **Alpha / Beta / Gamma / Neutron (Gy/h)** — the per-type strengths. Used when Preset is `Custom`; a named preset overrides them.
- **Radius** — area size in metres.
- **Point source** — if enabled, the source falls off with the inverse-square law (a hot spot) instead of linearly across the radius (an area/zone).

Sync the module to a `LocationArea` trigger for a zone, or enable **Point source** for a localised hotspot. The **Zeus** version opens the same attributes dialog — picking a preset there auto-fills the four fields before you confirm.

### Source presets

| Preset | Alpha | Beta | Gamma | Neutron | Reads like |
|--------|-------|------|-------|---------|-----------|
| **Custom** | — | — | — | — | Use the four fields |
| **Cobalt-60** | 0 | 0 | 50 | 0 | A strong sealed gamma source |
| **Reactor** | 0 | 0 | 40 | 20 | Reactor core / criticality |
| **Fallout** | 0 | 30 | 20 | 0 | Settled fallout dust |
| **Alpha Emitter** | 50 | 5 | 0 | 0 | Plutonium-style inhalation hazard |
| **Dirty Bomb** | 20 | 30 | 25 | 0 | A bit of everything |

> Strengths are **Gy/h** — the dose rate at the reference point (the centre for zones, ~1 m for point sources). With the defaults, a casualty in a ~500 Gy/h gamma field reaches the lethal tier in roughly 40 seconds; a 50 Gy/h source like Cobalt-60 is a "minutes" hazard. Scale to the pace you want.

### Carryable radioactive source (`kat_radSource`)

A placeable object (editor and Zeus) that acts as a point source you can pick up. ACE-interact to **Pick up radioactive source** — held point-blank it pours whole-body dose into you and concentrates skin dose on your hands and arms (handling burns). **Drop** it to set it back down. Great for "carry the canister to the disposal site" objectives.

> **Asset note:** `kat_radSource` uses a placeholder jerry-can model for now (see `OPTIONAL_TODO.md`).

### Quick console source (testing)

To drop a source at your feet without placing a module — handy for testing — run this as the server:

```sqf
["kat_chemical_addRadSource", [getPosASL player, 30, [0,0,500,0], "linear", "testRad", {true}, []]] call CBA_fnc_serverEvent;
```

The array is `[alpha, beta, gamma, neutron]` in Gy/h. Remove it with:

```sqf
["kat_chemical_removeRadSource", "testRad"] call CBA_fnc_serverEvent;
```

---

## Mission Configuration (CBA Settings)

Everything below lives under **CBA Settings → KAT - ADV Medical: Chemical**, in the **"10. Radiation"** subcategory (radiation shares the chemical addon's settings category). Times are in seconds; dose values in Gray.

### Master & display

| Setting | Default | What it does |
|---------|---------|--------------|
| Enable radiation | on | Master switch for the whole system |
| Show sickness messages | on | Whether radiation-sickness hints appear on screen |
| Radiation visual effect | on | The desaturated screen effect while irradiated/sick (client-side) |

### Dose thresholds (Gy)

| Setting | Default | What it does |
|---------|---------|--------------|
| Mild dose threshold | 1 | Dose at which mild (prodromal) sickness begins |
| Moderate dose threshold | 2 | Dose at which the hematopoietic tier begins |
| Severe dose threshold | 4 | Dose at which the GI tier begins |
| Lethal dose threshold | 6 | Dose at which the neurovascular (lethal) tier begins |

### Stage timings

| Setting | Default | What it does |
|---------|---------|--------------|
| Prodromal delay | 120 | Time to the first prodromal symptoms |
| Hematopoietic delay | 600 | Time to marrow-suppression onset |
| GI delay | 480 | Time to GI-syndrome onset |
| CNS delay | 180 | Time to neurovascular onset |
| Cardiac delay | 300 | Time to the fatal cardiac event |

> Higher tiers compress these delays automatically — a massive dose makes the stages arrive much faster than a borderline one.

### Shielding

| Setting | Default | What it does |
|---------|---------|--------------|
| Mask protection factor | 1.0 | Global effectiveness multiplier for gas-mask shielding |
| CBRN suit protection factor | 1.0 | Global multiplier for CBRN-suit shielding |
| Rad-gear protection factor | 1.0 | Global multiplier for rad-gear-uniform shielding |
| Vehicle protection factor | 1.0 | Global multiplier for vehicle shielding |
| Radiation-protective uniforms | *(empty)* | **Whitelist of uniform classnames that count as rad-gear** |

> *Radiation-protective uniforms* is the radiation equivalent of the CBRN-suit whitelist — a quoted, comma-separated list of classnames. Populate it with whatever anti-rad suits your loadout mods provide.

### Contamination

| Setting | Default | What it does |
|---------|---------|--------------|
| Inhalation factor | 0.1 | How much unmasked exposure becomes internal contamination |
| Internal dose conversion rate | 0.001 | How fast internal contamination converts to whole-body dose |
| Internal decay rate | 0.0005 | How fast the body clears internal contamination on its own |
| Contamination deposition | 0.02 | How fast surface contamination builds up |
| Contamination decay | 0.002 | How fast surface contamination weathers away |
| Cross-contamination strength | 5 | How strong a field a contaminated casualty emits (Gy/h scale) |
| Local exposure distance | 1.5 | Within this range of a point source, skin dose concentrates on arms/hands |
| Skin burn threshold | 5 | Local skin dose per radiation-burn wound |

### Drugs

| Setting | Default | What it does |
|---------|---------|--------------|
| KI protection factor | 0.5 | How much KI reduces uptake while active |
| KI duration | 3600 | How long a KI dose protects |
| Chelation duration | 600 | How long Prussian Blue accelerates internal clearance |
| Chelation factor | 5 | How much faster chelation clears internal contamination |
| Antibiotic duration | 600 | How long antibiotics suppress infection |
| Antiemetic duration | 900 | How long an antiemetic suppresses vomiting |
| Filgrastim duration | 1800 | How long filgrastim accelerates recovery |
| Filgrastim recovery multiplier | 3 | How much faster sickness recovers while filgrastim is active |

### Physiology

| Setting | Default | What it does |
|---------|---------|--------------|
| Anemia rate (ml/s) | 2 | Blood-volume loss from marrow suppression (scaled by severity) |
| GI fluid loss (ml/s) | 3 | Blood-volume loss from GI dehydration |
| GI acidosis rate | 0.05 | Per-second drop in blood-gas bicarbonate/pH |
| CNS hypotension (mmHg) | 40 | Maximum blood-pressure drop at the lethal tier |
| Maximum fever (°C) | 2 | Peak temperature rise from radiation sickness |
| Recovery rate (Gy/s) | 0.01 | How fast sickness heals once out of radiation (below lethal) |

### Infection

| Setting | Default | What it does |
|---------|---------|--------------|
| Enable wound infection | on | Whether immunosuppressed wounds can get infected → sepsis |
| Infection chance | 0.05 | Per-second base chance of infection (scaled by immunosuppression) |
| Infection progression rate | 0.02 | How fast an untreated infection worsens |
| Sepsis blood loss (ml/s) | 15 | Blood loss at full infection — drives lethal septic shock |

---

## Subsystem dependencies (important)

The physiology layers drive **other KAT medical subsystems**. If one is disabled in addon options, the matching radiation effect is **cleanly skipped** (no errors) and everything else keeps working. They all default **ON**, so this is usually a "don't accidentally turn it off" check.

| Radiation effect | Needs this subsystem ON | Setting |
|------------------|------------------------|---------|
| Thrombocytopenia (won't-clot bleeding) | KAT Pharmacy → Coagulation | `kat_pharma_coagulation` |
| Anemia regeneration impairment | KAT Vitals → Fluid Shift | `kat_vitals_enableFluidShift` |
| GI acidosis (blood-gas pH/HCO3) | KAT Breathing → Enable | `kat_breathing_enable` |
| CNS hypotension (blood pressure) | KAT Circulation → Enable | `kat_circulation_enable` |
| Fever (body temperature) | KAT Hypothermia → Enable Hypothermia | `kat_hypothermia_hypothermiaActive` |

> To exercise the full system on **AI** casualties, keep **KAT Vitals → Simple Medical OFF** — simple medical bypasses the detailed vitals loop the radiation effects ride on. Players always get the full sim.

---
