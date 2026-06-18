# Chemical Warfare — Player & Mission-Maker Guide

The **Chemical** addon adds a realistic CBRN (Chemical, Biological, Radiological, Nuclear) warfare layer on top of KAT Advanced Medical. Instead of a single generic "toxic gas," the battlefield now has six distinct agents — from non-lethal riot control all the way up to persistent nerve agents — each with its own cloud, symptoms, protective requirements, and treatment.

It is built to reward preparation. A unit that masks up, carries detection paper, and packs the right antidotes can walk through a contaminated area and live. A unit that doesn't will find out — often several minutes later — exactly which agent it walked into.

This guide is written for two audiences:

- **Players / medics** — what the gases do, how to survive them, and how to treat casualties.
- **Mission makers / Zeus** — how to deliver gas and how to tune everything through CBA settings.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Protection Tiers](#protection-tiers)
3. [The Six Agents](#the-six-agents)
4. [How Symptoms Progress](#how-symptoms-progress)
5. [Detection & Identification](#detection--identification)
6. [Treatment Reference](#treatment-reference)
7. [Equipment & Items](#equipment--items)
8. [Delivering Gas (Mission Makers & Zeus)](#delivering-gas-mission-makers--zeus)
9. [Mission Configuration (CBA Settings)](#mission-configuration-cba-settings)
10. [FAQ & Troubleshooting](#faq--troubleshooting)
---

## Quick Start

If you only read one section, read this one.

1. **Mask up.** A gas mask stops CS, chlorine, and phosgene outright. It does **not** stop mustard, sarin, or VX — those need a full CBRN suit (mask **and** a whitelisted uniform).
2. **Identify the threat.** Use **M8 detection paper** for nerve and blister agents, the **JCAD detector** for a live readout, and your nose for the choking agents (some have a tell-tale smell).
3. **Treat by agent class:**
   - Choking agents (chlorine, phosgene) → **Atropine**
   - Nerve agents (sarin, VX) → **ATNAA auto-injector**
   - Blister/persistent contamination (mustard, VX) → **Decontamination Kit**
4. **Decon if you're contaminated.** Mustard and VX stick to your skin and keep poisoning you every 40 seconds even after you've left the cloud. The decon kit is the only thing that stops that.
5. **VX needs both.** ATNAA stops the nerve symptoms; the decon kit stops the re-contamination. Use one without the other and VX will eventually finish the job.

---

## Protection Tiers

Every agent is assigned a **protection tier** that tells you what gear you need to survive it. The tier shown in module dropdowns is about *required protection*, not how dangerous the agent is.

| Tier | Gear required | Agents |
|------|---------------|--------|
| **Level 0** | None (a mask still protects the airway; eyes are still affected by CS) | CS / Tear gas |
| **Level 1** | Gas mask | Chlorine, Phosgene |
| **Level 2** | **Full CBRN suit** — gas mask **and** a whitelisted uniform | Mustard, Sarin, VX |

### What counts as protection

- **Gas mask** — any mask in the accepted-masks list. Out of the box that's `G_AirPurifyingRespirator_01_F`, `kat_mask_M50`, and `kat_mask_M04`. A mask must actually be worn and still have filter life remaining.
- **Filter life** — masks last **15 minutes** of active protection by default. When the filter is spent, the mask stops protecting you. Carry a **gas mask filter** (`kat_gasmaskFilter`) and use the *Replace gas mask filter* self-action to reset it.
- **CBRN suit** — for Level 2 agents the mask alone is not enough. You also need a uniform that the mission has whitelisted. The default whitelist contains the vanilla CBRN suit (`U_C_CBRN_Suit_01_Blue_F`); mission makers add their own (see [CBA settings](#mission-configuration-cba-settings)).

> **Common mistake:** wearing a mask into a mustard or sarin cloud and assuming you're safe. You're not. Level 2 agents go through the skin — only the full suit stops them.

---

## The Six Agents

A bird's-eye comparison first, then the details.

| Agent | Class | Tier | Cloud look | Smell | Onset | Lethality | Treatment |
|-------|-------|------|-----------|-------|-------|-----------|-----------|
| **CS / Tear gas** | Riot control | 0 | White / pale | None | Immediate | Non-lethal | Leave the cloud; wears off |
| **Chlorine** | Choking | 1 | Greenish-yellow | Sharp chlorine | ~30 s in cloud | Low–moderate | Atropine |
| **Phosgene** | Choking | 1 | Pale grey-white | Faint fresh hay | **Delayed 2–6 min** | High (sneaky) | Atropine |
| **Mustard** | Blister | 2 | Brown-yellow | Garlic / mustard | Builds over minutes | Moderate, disabling | Decon kit (+ wound care) |
| **Sarin** | Nerve (G) | 2 | Nearly invisible | None | Fast (~90 s to death) | **Very high** | ATNAA |
| **VX** | Nerve (V) | 2 | Oily amber | None | Slower but persistent | **Very high** | ATNAA **and** decon kit |

### CS / Tear Gas (Level 0)

The non-lethal one. CS is a riot-control irritant — it won't injure anyone medically, but it's miserable to be in. A gas mask protects the airway; note that CS still affects the **eyes** even through an oxygen mask, so it's not something you can simply ignore.

- **Cloud:** white / pale, lasts about 60 seconds.
- **Effect:** there's a configurable chance of dropping your weapon while inside the cloud (off by default — set *Drop Weapon Chance* above 0 to enable it).
- **Treatment:** none needed. Step out and it passes.
- **Delivery of note:** the `KAT_M7A3` hand grenade is a dedicated CS gas grenade.

### Chlorine (Level 1)

The classic choking agent and the direct descendant of the legacy "toxic gas." A gas mask blocks it completely.

- **Cloud:** greenish-yellow, lingers around 200 seconds — the longest-lasting of the conventional clouds.
- **Smell (unmasked):** *"You smell chlorine in the air..."*
- **Symptoms:** after roughly **30 seconds** of exposure you start coughing and pick up air poisoning (shown as intoxication in the medical menu).
- **Treatment:** **Atropine**. This is the backwards-compatible behaviour — anything that worked on the old toxic gas still works on chlorine.

### Phosgene (Level 1) — the silent killer

Phosgene is what makes a gas mask feel essential. It's a choking agent like chlorine, but its danger is *time*. You can breathe a lethal dose, feel completely fine, walk away, and collapse minutes later.

- **Cloud:** pale grey-white, lasts about 90 seconds.
- **Smell (unmasked):** *"You catch a faint smell of fresh hay..."* — easy to dismiss, which is the point.
- **Symptoms:** nothing at first. Then, **2 to 6 minutes after exposure** (randomised per victim), pulmonary edema hits — coughing and badly reduced breathing depth, *even though you left the cloud long ago*.
- **Treatment:** **Atropine** clears it. The trick is realising you were dosed before the symptoms arrive.
- **Important:** M8 paper reads **NEGATIVE** for phosgene — detection paper does not react to choking agents. Don't trust a clean M8 result as "all clear."

### Mustard / Yperite (Level 2) — gets worse over time

A blister agent that requires the full CBRN suit. Mustard doesn't kill quickly; it disables, and it keeps hurting you long after you've left the cloud because it contaminates your skin and gear.

- **Cloud:** thick brown-yellow, lasts about 120 seconds.
- **Smell (unmasked):** *"You smell garlic and mustard..."*
- **Progression (with default timings):**
  1. **On contact:** skin contamination is applied immediately (visible in the medical menu).
  2. **~40–100 s:** eye injuries set in — heavy vision impairment, possibly both eyes.
  3. **~100–240 s:** chemical burn wounds open up across the body, with lung damage and rising pain.
  4. **Every 40 s thereafter:** while you remain contaminated, the burns keep re-applying. Leaving the cloud does **not** stop this.
- **Treatment:** the **Decontamination Kit** is the cure — it clears the contamination and cancels the pending eye/burn timers. Burns and eye injuries that have already happened are treated as normal wounds through ACE/KAT medical. Atropine only suppresses the airway symptom, not the contamination.

### Sarin (Level 2) — fast nerve agent

A G-series nerve agent and the fastest killer in the set. Requires the full CBRN suit. What makes sarin terrifying is that the cloud is **nearly invisible and odourless** — you may not know you're in it until the symptoms start.

- **Cloud:** faint warm tint, very hard to see; lasts about 90 seconds.
- **Smell:** none.
- **Progression (default timings, from first exposure):**
  - **30 s:** vomiting begins.
  - **60 s:** unconsciousness.
  - **90 s:** cardiac arrest → death if untreated.
- **Treatment:** the **ATNAA auto-injector**. Administered before the cardiac-arrest deadline, it clears the nerve-agent exposure and **aborts the cardiac arrest before it fires**. With default timings you have a 90-second window from exposure. Atropine does *not* work on nerve agents.

### VX (Level 2) — slow, persistent, and the hardest to treat

The other nerve agent, V-series. VX trades sarin's speed for persistence. The cloud lingers for **ten minutes** by default, and like mustard it contaminates the skin — so curing the nerve symptoms once is not enough.

- **Cloud:** oily amber, visibly persistent; lasts about 600 seconds (10 minutes).
- **Smell:** none.
- **Progression (default timings):**
  - **60 s:** vomiting.
  - **120 s:** unconsciousness.
  - **240 s:** cardiac arrest.
- **The catch — it re-poisons you.** VX sets *both* nerve-agent exposure *and* skin contamination. ATNAA clears the nerve exposure and stops the current symptom chain, but the contamination tick fires every 40 seconds and re-applies VX, starting a fresh symptom chain each time.
- **Treatment:** you need **two** items:
  1. **ATNAA** — aborts the active nerve-agent symptom chain.
  2. **Decontamination Kit** — clears the skin contamination so the tick stops re-poisoning you.

  Use only the ATNAA and VX will keep coming back. Use only the decon and the already-running symptom chain still kills you. This dual requirement is the whole point of VX.

---

## How Symptoms Progress

Some agents are about a single timeline; the lethal ones are about deadlines you have to beat. The diagrams below use the **default** timings — all of them are configurable.

### Mustard — escalating contamination

```
  EXPOSURE
     |
     |  contamination applied immediately (skin + gear)
     v
  [ 0s ]------------------------------------------------------>
     :
     :  ~40-100s    EYE INJURIES (vision impaired, possibly both eyes)
     :     |
     :     v  ~100-240s    SKIN BURNS begin (wounds + lung damage + pain)
     :        |
     :        v  every 40s    RE-APPLIED while still contaminated
     :           |               (leaving the cloud does NOT stop this)
     :           v
   DECON KIT  --> clears contamination + cancels pending timers --> safe
```

### Sarin — the 90-second clock

```
  EXPOSURE
     |
  [ 0s ]--------[ 30s ]--------[ 60s ]--------[ 90s ]----> DEATH
                  |              |              |
                vomit       unconscious    cardiac arrest
     \________________ ATNAA window ________________/
        Inject any time before 90s to abort the chain.
```

### VX — slower clock, but it resets

```
  EXPOSURE (sets BOTH nerve exposure AND skin contamination)
     |
  [ 0s ]--------[ 60s ]--------[ 120s ]--------[ 240s ]----> DEATH
                  |               |               |
                vomit        unconscious     cardiac arrest

   ATNAA  --> clears nerve exposure, aborts THIS chain
      |
      |  ...but every 40s the contamination tick re-poisons you,
      |     starting a NEW chain --------------------------------+
      |                                                          |
   DECON KIT --> clears contamination, stops the tick <---------+
                 (you are only truly safe once BOTH are done)
```

### Phosgene — the delayed ambush

```
  EXPOSURE
     |
  [ 0s ]======== no symptoms, feels fine ========[ 2-6 min ]----> COLLAPSE
                                                       |
                                          pulmonary edema:
                                          coughing + reduced breathing
                                          (fires even after leaving the cloud)
                  ATROPINE clears it -- before or after onset.
```

### Chlorine — straightforward

```
  IN CLOUD ---[ ~30s ]---> coughing + air poisoning ---> ATROPINE clears it
```

---

## Detection & Identification

Knowing *what* you walked into decides whether you reach for atropine, an ATNAA, or a decon kit. You have three tools.

### M8 / M9 Detection Paper

Single-use paper that reacts to nerve and blister agents on contact. Use the **Use M8 Detection Paper** self-action (a 3-second wipe). The result appears as a paper-style readout on screen for about 8 seconds, then the paper is consumed.

| Agent | M8 result | Stain colour |
|-------|-----------|--------------|
| Sarin | **G-Series Nerve** | Yellow |
| VX | **V-Series Nerve** | Green / dark green |
| Mustard | **Blister Agent** | Red |
| CS, Chlorine, Phosgene, clean air | **No mark = Clean** | — |

> M8 paper genuinely cannot detect choking agents — a NEGATIVE result does **not** mean the air is safe, only that there's no nerve or blister agent present. For chlorine and phosgene, trust your nose and the JCAD detector instead.

The paper reads your most recent cloud exposure, remembered for **30 seconds** after you leave. Test promptly.

### JCAD Chemical Detector

A worn detector (`KAT_ChemicalDetector`, watch slot). Turn it on through its *JCAD* self-action menu, where you can also toggle the warning tone. When you're in or have recently been in a cloud, its top line shows the **detected agent name** (for example "SARIN", "MUSTARD"; chlorine reads "TOXIC GAS") along with an intensity reading from 0.00 (cloud edge) to 1.00 (dead centre). In clean air it falls back to showing the clock, reverting roughly 30 seconds after you leave a cloud.

### Smell

Unmasked units get a one-time text hint the first time they enter certain clouds:

| Agent | Hint |
|-------|------|
| Chlorine | "You smell chlorine in the air..." |
| Phosgene | "You catch a faint smell of fresh hay..." |
| Mustard | "You smell garlic and mustard..." |
| Sarin / VX | *(odourless — no hint, which is exactly what makes them dangerous)* |

Wearing a gas mask suppresses the hint, and each unit only gets each smell once per life. This can be disabled mission-wide via the *Enable Smell Hint* setting.

### Visual cloud cheat-sheet

| Cloud colour | Likely agent |
|--------------|--------------|
| White / pale | CS |
| Greenish-yellow | Chlorine |
| Pale grey-white | Phosgene |
| Thick brown-yellow | Mustard |
| Almost invisible, faint warm shimmer | Sarin |
| Oily amber, slow to disperse | VX |

> If a mission has turned off the *Enable Gas particle effects* setting, clouds are invisible regardless of agent — fall back on M8 paper, the JCAD detector, and smell to know what you're in.

---

## Treatment Reference

Match the symptom you see in the medical menu to the right item.

| What you see / know | Agent class | Item to use | Notes |
|---------------------|-------------|-------------|-------|
| Intoxication / air poisoning, coughing | Chlorine, Phosgene | **Atropine** | Works during or after onset; this is the legacy behaviour |
| "Nerve Agent Exposure" (red), vomiting, heading to cardiac arrest | Sarin, VX | **ATNAA auto-injector** | Must beat the cardiac-arrest deadline; aborts the chain |
| "Skin Contamination" (orange), recurring burns | Mustard, VX | **Decontamination Kit** | Stops the 40-second re-poison tick; cancels pending mustard timers |
| Eye injuries, burn wounds | Mustard (after onset) | Standard ACE/KAT wound care | Treat as ordinary injuries once they've appeared |
| Both contamination **and** nerve exposure | **VX** | **ATNAA + Decon Kit** | Both are required — see VX above |

### Treating a casualty — quick flow

```
   Casualty down in / after a chemical attack
              |
   Is it safe for YOU? (mask / suit on, or move them out)
              |
   Identify the agent (M8 paper, JCAD, symptoms in menu)
              |
      +-------+-----------------------------+
      |       |                             |
  choking   nerve agent              skin contamination
  (intox)   (red line)               (orange line)
      |       |                             |
  ATROPINE  ATNAA  -----> still contaminated? --> DECON KIT
              |                                       |
       (beat the cardiac                     (stops re-poisoning)
        arrest deadline)
              |
   Then treat residual wounds, burns, eye injuries as normal.
```

> ATNAA mirrors atropine's profile (a heart-rate boost, up to 3 doses, applied to arms or legs) but is specifically the nerve-agent antidote. Keep both in a medic's kit — atropine for the chokers, ATNAA for the nerves.

---

## Equipment & Items

| Item | Classname | Weight | Purpose | How to use |
|------|-----------|--------|---------|------------|
| M8 Detection Paper | `kat_m8paper` | 0.1 kg | Identifies nerve/blister agents | *Use M8 Detection Paper* self-action |
| M291 Decontamination Kit | `kat_decon_kit` | 4 kg | Removes mustard/VX skin contamination | *Decontaminate* self-action (only shown when contaminated) |
| ATNAA Auto-injector | `kat_atnaa` | 0.5 kg | Nerve-agent antidote (sarin, VX) | *Administer ATNAA* in the medical menu |
| JCAD Chemical Detector | `KAT_ChemicalDetector` | — | Live agent identification & intensity | *JCAD* self-action menu (turn on / warning tone) |
| Gas Mask Filter | `kat_gasmaskFilter` | 1 kg | Resets spent mask filter life | *Replace gas mask filter* self-action |
| Sealant Tube | `kat_sealant` | 3 kg | Seals leaking contaminated objects | Seal action on a sealable source |

> `kat_atnaa` lives in the **pharma** addon; everything else is in **chemical**. All items are available through ACE Arsenal.

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

## FAQ & Troubleshooting

**My gas mask isn't protecting me from the mustard/sarin/VX cloud.**
That's intended. Level 2 agents go through the skin — you need a full CBRN suit, meaning a mask **and** a uniform that's on the *Available CBRN Suit Uniforms* whitelist. Check that your unit's uniform classname is in that setting.

**I left the cloud but I'm still taking damage / coughing.**
Two possibilities. If it's mustard or VX, you're **contaminated** — the agent is still on you and re-poisons you every 40 seconds. Use a **Decontamination Kit**. If it's phosgene, the **delayed onset** has caught up with you (2–6 minutes after exposure) — use **Atropine**.

**I gave the casualty ATNAA but they went into cardiac arrest anyway.**
For sarin, the ATNAA has to be administered **before** the cardiac-arrest deadline (90 seconds by default). For VX, ATNAA alone isn't enough — the skin contamination re-applies the agent and starts a new chain, so you must **also** use a decon kit. Re-administer ATNAA and follow up with decon.

**M8 paper says NEGATIVE but people are getting sick.**
M8 paper only detects nerve and blister agents. Chlorine and phosgene are choking agents and will always read NEGATIVE — that's realistic. Use the JCAD detector or smell hints for those.

**Nothing shows up in the medical menu.**
Check the *Show Poisoning* setting is enabled. If it's off, poisoning and intoxication are intentionally hidden from the menu.

**AI mortars never fire sarin/VX/mustard.**
Correct — AI mortars are restricted to choking agents by design. Use the gas module, Zeus, or a player-crewed mortar to deploy the Level 2 agents.

---
Last editet: 18.06.2026
