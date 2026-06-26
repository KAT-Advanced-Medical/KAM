# Detection & Equipment

You cannot see, smell, or feel radiation. Without a device you have no idea whether the room you just walked into is harmless or already killing you — so detection isn't optional here the way it sometimes is with a visible gas cloud.

## The Dosimeter (your geiger)

The `KAT_Dosimeter` is a worn device (watch slot, like the chemical JCAD). It's your eyes for radiation: a small HUD with the dose readout, plus the classic geiger clicks.

**Turning it on** — three independent steps, mirroring how the JCAD works:

1. **Show the HUD** — press the dosimeter key (**P** by default) to bring the readout up.
2. **Enable the dosimeter** — a self-action that switches on the live dose-*rate* reading. Until you do this, the HUD shows your accumulated dose but the rate reads `--`.
3. **Enable the sound** — a separate self-action that turns on the geiger clicks. The clicks get faster as the dose rate climbs, and go silent when you're in clean air.

There are matching **Disable** / **Sound off** self-actions to turn each back off.

**What it shows:**

- **Accumulated dose (Gy)** — always visible. Your running total of absorbed radiation. This is the number that decides how sick you get.
- **Dose rate (Gy/h)** — visible once enabled. How hot your current spot is. Remember: this reads the *field*, not what you absorb, so it ignores your shielding.

> The geiger reads the environment, so it'll keep clicking if **you** are contaminated even in clean air — that's the surface contamination making you a source. If the clicks won't stop after you've left a zone, survey/decon yourself.

> **Asset note:** the dosimeter currently borrows the chemical detector's model and the geiger sounds reuse the detector's chime samples as placeholders. The numbers and behaviour are real; dedicated art and click audio are planned.

## Rad Survey (diagnostic)

A medical action — **Radiation Survey** — that points the dosimeter at a casualty and reports:

- their **surface contamination** level (as a %),
- the **dominant radiation type** they're carrying,
- and the **ambient dose rate** at them.

Requires a dosimeter in your kit. Use it on a casualty before you start treating to know whether you need to decon them (and to know whether *you're* about to get dosed working on them).

## Dose Estimation (triage diagnostic)

A second medical action — **Estimate Radiation Dose** — for triage. It reads the casualty's exposure and reports:

- their **exact accumulated dose** in Gy,
- a **prognosis** band (from "no ARS expected" up to "likely lethal without intensive treatment"),
- and the **time-to-vomiting** biomarker, if they've vomited.

This is your tool for deciding who's salvageable and who isn't when you have more casualties than supplies.

---

## Equipment & Items

Everything radiation-related, plus the shared decon kit. All available through ACE Arsenal.

| Item | Classname | Purpose | How to use |
|------|-----------|---------|------------|
| Dosimeter | `KAT_Dosimeter` | Reads dose rate + accumulated dose; geiger clicks | Watch slot; key **P** + self-actions to enable/sound |
| Potassium Iodide (KI) | `kat_potassiumIodide` | **Prophylaxis** — reduces uptake if taken before/early | *Take Potassium Iodide* (self + medic) |
| Prussian Blue | `kat_prussianBlue` | **Chelation** — speeds clearing of internal contamination | *Administer Prussian Blue* (self + medic) |
| Antibiotics | `kat_antibiotics` | Fights radiation wound infection / sepsis | *Administer Antibiotics* (self + medic) |
| Filgrastim (G-CSF) | `kat_filgrastim` | Speeds marrow / sickness recovery | *Administer Filgrastim* (self + medic) |
| Antiemetic | `kat_antiemetic` | Suppresses radiation-sickness vomiting | *Administer Antiemetic* (self + medic) |
| Decontamination Kit | `kat_decon_kit` | Removes **surface** contamination (shared with Chemical) | *Decontaminate* (shown when contaminated) |
| Radioactive Source | `kat_radSource` | A carryable/placeable point source | Editor/Zeus object; ACE *Pick up* / *Drop* |

> The decon kit and the CBRN mask/suit are the **same items** the [Chemical](../Chemical/05_detection_identification_items.md) side uses — radiation reuses them rather than adding duplicates. The drugs and the dosimeter are radiation's own additions.

> **What decon does and doesn't do:** the decon kit clears **surface** contamination only. It will not touch internal contamination (use Prussian Blue) and it does nothing to the dose you've already absorbed. See [Treatment & triage](06_treatment_and_triage.md).

---
