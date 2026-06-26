# Radiation Sickness

Acute Radiation Syndrome (ARS) is what a dose actually *does* to a body, and it's the deepest part of the system. Rather than a health bar ticking down, a serious dose sets off a staged cascade through the body's systems — blood, gut, brain — each on its own clock, each hooking into KAT's existing medical sims so the casualty genuinely behaves like someone who's been irradiated.

The important mental model: **the dose lands in an instant, but the sickness unfolds over minutes.** Someone can soak a fatal dose, feel only queasy, and seem fine right up until the systems start failing.

## The tier ladder

Your accumulated dose maps to a severity **tier**, and the tier decides which syndromes switch on. Defaults shown — every threshold is configurable.

| Tier | Dose (default) | Name | What switches on |
|------|----------------|------|------------------|
| **0** | < 1 Gy | None | Nothing |
| **1** | 1–2 Gy | Mild (prodromal) | Nausea/vomiting, pain, fever begins |
| **2** | 2–4 Gy | Moderate (hematopoietic) | Marrow suppression → anemia, won't-clot bleeding, infection risk |
| **3** | 4–6 Gy | Severe (GI) | Dehydration, blood-gas acidosis, heavy vomiting |
| **4** | ≥ 6 Gy | Lethal (neurovascular) | Hypotension, seizures, collapse → cardiac arrest |

Higher tiers don't replace the lower ones — they **stack on top**, and they arrive **faster** (the latent period compresses as the dose climbs, mirroring the real-world "time to vomiting" biomarker that medics use to estimate dose).

```
   DOSE ABSORBED
        |
   [accumulates] --> crosses 1 Gy --> TIER 1  prodromal (nausea, fever)
        |                                |
        |                          crosses 2 Gy --> TIER 2  marrow fails
        |                                              (anemia, bleeding, infection)
        |                                |
        |                          crosses 4 Gy --> TIER 3  gut fails
        |                                              (dehydration, acidosis)
        |                                |
        |                          crosses 6 Gy --> TIER 4  brain/circulation fails
        |                                              (hypotension -> collapse -> arrest)
        v
   higher dose = shorter time before each stage hits
```

---

## The syndromes, in plain terms

### Prodromal (tier 1+)
The early warning. Nausea and vomiting, a creeping rise in pain, and the start of a fever. It's miserable but survivable — and it's the body telling you the real damage is already done and the clock is running.

### Hematopoietic — the marrow (tier 2+)
The classic radiation kill mechanism, just slower than the dramatic stuff. Your bone marrow stops keeping up, and three things follow:

- **Anemia** — your blood volume slowly falls and you can't replace it. A wound that would normally be survivable becomes a problem because you can't rebuild what you lose.
- **Thrombocytopenia** — your blood won't clot properly. Bleeding that should stop with a bandage keeps going.
- **Immunosuppression** — your immune system is on the floor, which opens the door to **wound infection** (below).

### Gastrointestinal — the gut (tier 3+)
Now it's serious. Fluid pours out of the body (dehydration → falling blood volume), the blood chemistry tips into **acidosis**, and the vomiting becomes relentless. This is the tier where casualties start sliding toward hypovolemic shock.

### Neurovascular / CNS — the end (tier 4)
The lethal tier. Blood pressure craters (**hypotension**), brief **seizures** hit, and the casualty collapses into unconsciousness and then cardiac arrest. **This tier does not recover on its own.** If someone reaches it, the only thing that would have helped was not being there.

### Systemic — fever & the screen
Running underneath all of it: a **fever** that climbs with severity, and a **visual effect** — the world desaturates into a sickly grade as you get worse (toggleable, on by default). The visual is your gut-feel warning when you're not staring at the dosimeter.

---

## Recovery

Here's the merciful part: **below the lethal tier, radiation sickness heals on its own.** Once you're out of the radiation (no field, no internal contamination left), your sickness slowly winds back down over minutes — marrow recovers, fever breaks, blood pressure normalises, and the tier ticks back to zero.

- The **accumulated dose** on your dosimeter stays where it is — that's your permanent exposure record — but the *sickness* it caused fades.
- **Filgrastim** speeds this up considerably (see [Treatment](06_treatment_and_triage.md)).
- The **lethal tier is the exception** — it will not spontaneously recover. Everything below it will, given time and support.

---

## Wound infection & sepsis

When your immune system is suppressed (tier 2+) and you have **open or bandaged wounds**, those wounds can become **infected**. Once infected:

- Pain and fever climb, and the wound bleeds in a way that drags your blood volume down.
- Left untreated, the infection worsens into **sepsis** — and sepsis here is **lethal**. A casualty who survives the radiation itself can still die of the infection it let in. This is the realistic sting in the tail of marrow failure.
- **Antibiotics** clear it. It also resolves on its own *if* the casualty's immunity recovers first — so it's a race between your immune system coming back and the infection getting ahead of it.

> **Mission makers:** infection can be switched off entirely with the *Enable wound infection* setting if you don't want sepsis in your mission.

---

## A note for mission makers: this rides on other systems

The physiology layers drive **real KAT medical subsystems** — blood volume, coagulation, blood gas, blood pressure, body temperature. If a subsystem is disabled in the addon options, the matching radiation effect simply doesn't fire (cleanly, no errors), and the rest still work. Which layer needs which subsystem is laid out in the [dependency table in Zeus & mission makers](07_zeus_and_MissionMakers.md). All of them are on by default.

---
