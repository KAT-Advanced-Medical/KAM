# Detection/Identification & Equipment/Items

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
