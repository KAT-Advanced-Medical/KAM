# Treatment & Triage

Radiation treatment is less about a single antidote and more about managing a casualty through a sickness that plays out over time. There's no "cure the radiation" button — there's removing what's still dosing them, slowing the damage, and supporting the body's systems while it recovers (or deciding it can't).

## The one distinction that runs everything: decon vs chelation

Two kinds of contamination, two completely separate cures. Mixing them up is the classic mistake.

| Contamination | Where it is | Cleared by | NOT cleared by |
|---------------|-------------|-----------|----------------|
| **Surface (external)** | On skin & gear | **Decontamination Kit** | Prussian Blue |
| **Internal** | Breathed in, inside the body | **Prussian Blue** (chelation) | The decon kit / washing |

- **Decon** scrubs the surface. It stops the casualty reading hot on a geiger and stops them cross-contaminating others.
- **Prussian Blue** chelates — it binds internal radionuclides so the body clears them faster, cutting off the internal dose that otherwise keeps climbing for ages.

Neither one undoes dose already absorbed. They stop *further* dosing from contamination; the sickness from what's already in still has to be ridden out.

---

## Treatment reference

Match what you've found to what you reach for.

| What you see / know | Use | Notes |
|---------------------|-----|-------|
| Casualty reads hot on a survey; geiger won't stop | **Decontamination Kit** | Clears surface contamination + stops cross-contamination |
| Dose keeps climbing in clean air (breathed it in) | **Prussian Blue** | Chelation; the only thing that touches internal contamination |
| *Before* entering a hot area | **Potassium Iodide (KI)** | Prophylactic — reduces uptake; useless after the fact |
| Vomiting from radiation sickness | **Antiemetic** | Suppresses the vomiting for a while |
| Infected wound / heading toward sepsis | **Antibiotics** | Clears infection; essential if infection is enabled |
| Slow to recover after a survivable dose | **Filgrastim (G-CSF)** | Speeds marrow/sickness recovery |
| Anemia, low blood volume, dehydration | **IV Blood / Saline** | Standard KAT fluids — radiation drains blood volume, so top it up |
| Radiation burns, open wounds | Standard ACE/KAT wound care | Treat as ordinary injuries |

> **Timing is everything with the two anti-rad drugs.** KI only helps **before** uptake — it's a pre-exposure tablet, not a treatment. Prussian Blue is the opposite — it's for **after**, to speed clearing what's already inside. Carry KI for planned entries into hot zones; carry Prussian Blue for after the fact.

---

## Triage flow

```
   Radiation casualty
          |
   Is it safe for YOU? (survey them; decon if they're hot, or you'll get dosed too)
          |
   Estimate the dose (Estimate Radiation Dose action)
          |
     +----+-------------------------+--------------------------+
     |                              |                          |
  survivable tier            lethal tier                 contaminated
  (mild-severe)              (>6 Gy default)             (surface / internal)
     |                              |                          |
  support & speed            comfort / triage            DECON (surface)
  recovery:                  out — will not              PRUSSIAN BLUE (internal)
   - IV fluids/blood         self-recover                     |
   - antibiotics if                                     stops further dosing
     infected
   - antiemetic
   - filgrastim
   - time
     |
  recovers over minutes; accumulated dose stays on record
```

The short version of supportive care for a survivable casualty: **stop the contamination (decon/chelate), replace the blood they're losing (IV), keep infection out (antibiotics), make them comfortable (antiemetic), and speed the marrow back (filgrastim).** Then time does the rest.

---

## Prophylaxis: the smart play

The cheapest treatment is the one you take before anything happens. If you know you're going into a contaminated area:

- **Take KI first** — it reduces how much radioiodine your body takes up while you're in there.
- **Mask and suit up** per the [shielding rules](03_protection_and_shielding.md) — the mask especially, to keep internal contamination out.
- **Carry a dosimeter and watch the accumulated dose**, not just the rate. Leave before it climbs into the tiers you can't walk back from.

A prepared unit can work a hot zone and recover. An unprepared one finds out about the dose when the vomiting starts.

---
