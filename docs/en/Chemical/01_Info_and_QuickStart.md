# Chemical Warfare — Player & Mission-Maker Guide

The **Chemical** addon adds a realistic CBRN (Chemical, Biological, Radiological, Nuclear) warfare layer on top of KAT Advanced Medical. Instead of a single generic "toxic gas," the battlefield now has six distinct agents — from non-lethal riot control all the way up to persistent nerve agents — each with its own cloud, symptoms, protective requirements, and treatment.

It is built to reward preparation. A unit that masks up, carries detection paper, and packs the right antidotes can walk through a contaminated area and live. A unit that doesn't will find out — often several minutes later — exactly which agent it walked into.

This guide is written for two audiences:

- **Players / medics** — what the gases do, how to survive them, and how to treat casualties.
- **Mission makers / Zeus** — how to deliver gas and how to tune everything through CBA settings.

---

## Quick Start

If you only read one section, read this one.

1. **Mask up.** A gas mask stops CS, chlorine, and phosgene outright. It does **not** stop mustard, sarin, or VX — those need a full CBRN suit (mask **and** a whitelisted uniform).
2. **Identify the threat.** Use **M8 detection paper** for nerve and blister agents, the **JCAD detector** for a live readout, and your nose for the choking agents (some have a tell-tale smell).
3. **Get out — but understand that leaving is not a cure.** Roughly twenty seconds in the thick of a chlorine cloud commits you — and phosgene needs only about five: the damage already in your lungs keeps getting worse after you leave, and untreated it kills in about eight minutes. Running out early genuinely helps, because dose depends on how deep you were and for how long. Running out late does not save you.
4. **Treat by agent class:**
   - Choking agents (chlorine, phosgene) → **oxygen** to hold SpO2 up, **Atropine** to stop it worsening, **Dexamethasone** to cure it
   - Nerve agents (sarin, VX) → **ATNAA auto-injector**
   - Blister/persistent contamination (mustard, VX) → **Decontamination Kit**
5. **Decon if you're contaminated.** Mustard and VX stick to your skin and keep poisoning you every 40 seconds even after you've left the cloud. The decon kit is the only thing that stops that.
6. **VX needs both.** ATNAA stops the nerve symptoms; the decon kit stops the re-contamination. Use one without the other and VX will eventually finish the job.

---
