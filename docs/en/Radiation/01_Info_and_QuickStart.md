# Radiation — Player & Mission-Maker Guide

The **Radiation** system is an extension of the **Chemical** addon — the "R" and "N" in CBRN that the gases left on the table. It lives in the same addon, shares the same CBA settings category, and reuses the same decontamination kit and CBRN gear, so if you've already read the [Chemical guide](../Chemical/01_Info_and_QuickStart.md) a lot of this will feel familiar. If you haven't, the short version is: this mod treats hazards as things you prepare for, not things that simply tick your health down.

Where the gases are about a cloud you can usually *see* and an antidote you carry, radiation is quieter and slower. You can't smell it, a mask won't stop most of it, and the dose you soak up today can put you in the ground a quarter of an hour from now with nothing visibly wrong in between. The only way to know what you're standing in is to carry a dosimeter and pay attention to it.

This guide is written for two audiences:

- **Players / medics** — what the four radiation types do, how to shield against them, and how to treat radiation casualties.
- **Mission makers / Zeus** — how to place radiation sources and how to tune the whole thing through CBA settings.

> **A note on units.** Dose is measured in **Gray (Gy)**, the real SI unit of absorbed radiation. As a rough yardstick: a couple of Gy makes you sick, around 4 Gy is a coin-flip for survival without treatment, and 6 Gy and up is the danger zone. The defaults are built around those numbers but every threshold is configurable.

---

## How dose works (the one concept to understand)

There are three different numbers in play, and confusing them is the single most common mistake:

- **Dose rate** — how *hot* the spot you're standing in is, in **Gy/h**. This is what your dosimeter's geiger reads. It measures the field around you; it does **not** care what you're wearing.
- **Accumulated dose** — how much radiation your body has actually *absorbed*, in **Gy**. This is what makes you sick, and **this** is what your shielding reduces. It only ever goes up while you're exposed, and it's permanent.
- **Internal contamination** — radioactive material you've **breathed in**. It sits inside you and keeps delivering dose for a long time after you've left the area. Washing it off does nothing; it has to be chelated out or wait out your body clearing it.

So: the geiger screaming doesn't mean you're being hurt (your suit might be eating it), and the geiger going quiet doesn't mean you're safe (you might be carrying contamination inside you). Watch the *accumulated* dose, not just the rate.

---

## Quick Start

If you only read one section, read this one.

1. **Carry a dosimeter.** The `KAT_Dosimeter` (watch slot) is your only way to see dose rate and accumulated dose. Turn it on, turn the sound on, and let the clicks warn you before the numbers do.
2. **Shielding depends on the type.** There's no single "rad suit." A gas mask matters for alpha (inhalation) and helps against beta; a full CBRN suit stops beta and dents gamma; vehicles and terrain are what cut gamma and neutron. Distance is always your friend.
3. **Dose is cumulative — manage your time.** You can't "heal" the radiation you've already absorbed by leaving. Treat a hot zone like a budget: get in, do the job, get out before the accumulated dose climbs into the danger tiers.
4. **Two kinds of contamination, two different cures.** Surface contamination (on your skin and gear) comes off with the **Decontamination Kit**. Internal contamination (breathed in) does **not** — it needs **Prussian Blue** chelation. Decon and chelation are not interchangeable.
5. **Prepare with KI, treat with supportive care.** Potassium iodide (**KI**) taken *before* exposure reduces uptake. After a serious dose, casualties need real medical care — IV fluids and blood for the anemia and dehydration, antibiotics if wounds get infected, and time.
6. **A lethal dose is lethal.** Below the top tier, radiation sickness is survivable and recovers slowly on its own. At the lethal tier it will not — that casualty needs to never have been there.

---

## Where to go next

- [Radiation types & dose](02_radiation_types_and_dose.md) — alpha, beta, gamma, neutron, and the three ways they dose you.
- [Protection & shielding](03_protection_and_shielding.md) — what actually stops what.
- [Radiation sickness](04_radiation_sickness.md) — what a dose does to the body over time.
- [Detection & items](05_detection_and_items.md) — the dosimeter and the full kit list.
- [Treatment & triage](06_treatment_and_triage.md) — decon, chelation, drugs, and a triage flow.
- [Zeus & mission makers](07_zeus_and_MissionMakers.md) — placing sources and every CBA setting.
- [FAQ & troubleshooting](08_faq_and_troubleshooting.md) — the gotchas.

---
