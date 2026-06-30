# Protection & Shielding

There is no single "radiation suit" that makes you immune. Different gear stops different types, and the most penetrating types (gamma, neutron) aren't really stopped by anything you can *wear* — only by mass, distance, and cover. Shielding here is about **slowing the dose you accumulate**, not switching the danger off.

## The shielding matrix

How much each piece of gear protects you, by type. "Strong" means it cuts the absorbed dose hard; "none" means don't bother.

| Type | Gas mask | Full CBRN suit | Rad-gear uniform | Vehicle / cover |
|------|----------|----------------|------------------|-----------------|
| **Alpha** | **Decisive** (stops inhalation) | Decisive | Decisive | Decisive |
| **Beta** | Some | **Strong** | Strong | Good |
| **Gamma** | Negligible | Slight | Moderate | Moderate |
| **Neutron** | None | Negligible | Some | Some |

A few things to read out of that table:

- **Alpha** is all-or-nothing and it's about your airway. With a mask you barely accumulate anything; without one you breathe it in. Every other piece of gear "stops" alpha too, but the mask is the one that matters because inhalation is the real route.
- **Beta** is where a CBRN suit earns its keep — it nearly stops beta and saves you from the burns. A mask alone won't.
- **Gamma and neutron** can't be out-dressed. The honest answers are **distance**, **putting mass between you and the source**, and **time spent**. A vehicle helps; a uniform doesn't do much.

> **The key nuance, one more time:** your gear reduces the **accumulated dose**, not the geiger **rate**. Standing in a gamma field in a vehicle, the dosimeter rate looks the same — but the dose you're banking is lower. Judge protection by the dose total, not the rate.

### What counts as "rad-gear"

Rad-gear is a mission-defined whitelist of uniforms that count as radiation-protective, separate from the CBRN suit list. Out of the box it's empty — mission makers populate it via the *Radiation-protective uniforms* CBA setting (see [Zeus & mission makers](07_zeus_and_MissionMakers.md)). It's the lever for adding whatever anti-rad suits your loadout mods provide.

The gas mask and full CBRN suit are the **same items** the [Chemical](../Chemical/02_protection.md) side uses — a worn, filtered mask and a whitelisted CBRN uniform. Radiation doesn't add new wearables; it reuses the CBRN kit and adds the uniform whitelist on top.

---

## Contamination: external vs internal

This split is the heart of radiation treatment, so it gets its own section. There are **two** kinds of contamination and they could not be more different.

### External (surface) contamination

Radioactive dust settling on your skin and gear. It:

- **Reads on a geiger** — it makes *you* a weak source, so your own dosimeter keeps clicking even after you've left the area.
- **Doses you and the people next to you** (see cross-contamination below).
- **Comes off with the Decontamination Kit.** Washing it off is the whole fix.
- Slowly weathers away on its own over time.

### Internal contamination

Radioactive material you've **breathed in** (mostly from alpha/beta dust without a mask). It:

- **Does not read on a geiger** — it's inside you, invisible to a survey.
- **Keeps converting to whole-body dose** for a long time, so your accumulated dose climbs even in clean air.
- **Cannot be washed off.** Decon does nothing. It needs **Prussian Blue** chelation to speed elimination, or your body slowly clears it on its own.

> **The trap:** a casualty walks out of a contaminated area, you decon them, the geiger goes quiet — and they keep getting sicker. That's internal contamination. Decon cleaned the surface; the dose is coming from the inside. Reach for Prussian Blue, not the decon kit.

---

## Cross-contamination

A contaminated casualty isn't just a patient — they're a **source**. Surface contamination makes a unit emit a weak beta/gamma field of their own, which means:

- Their **own** dosimeter reads hot even in clean air.
- **Medics treating them accumulate dose**, and a clean responder standing next to a contaminated casualty will see their own geiger tick up.
- A **rad survey** on the casualty (see [Detection & items](05_detection_and_items.md)) reads their contamination level and dominant type so you know what you're dealing with.

The fix is the same: **decon the casualty** to remove the surface contamination, and the field they emit disappears with it. Until then, treat them like the hot object they are — work fast, and don't loiter.

---
