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

> **Tracking what you've given:** every radiation drug logs to the patient's **triage card** in the medical menu when administered (with a tally on repeat doses), so you can see at a glance what's already on board.

---

## Treating a casualty — quick flow

```
   Radiation casualty (down or sick)
            |
   1. MAKE IT SAFE FOR YOU
      Survey them. If they read hot, DECON first — a contaminated
      casualty doses you the whole time you're working on them.
            |
   2. STOP THE DOSING
      - DECON KIT      -> clears surface contamination
      - PRUSSIAN BLUE  -> clears internal (inhaled) contamination
      - move them clear of any radiation field
      (until dosing stops, nothing you do below will hold)
            |
   3. ESTIMATE THE DOSE   (Estimate Radiation Dose action)
            |
      +-----+----------------------------------------+
      |                                              |
  SURVIVABLE (mild–severe)                   LETHAL (top tier, >6 Gy)
      |                                              |
  supportive care:                          INTENSIVE CARE (hard, ~15 min):
   - IV blood/saline  (anemia, fluids)        keep alive: IV or vasopressor
   - antibiotics      (if infected)           cure (all at once, sustained):
   - antiemetic       (vomiting)                filgrastim + antibiotics
   - filgrastim       (speeds recovery)         + STEM-CELL RESCUE
      |                                          (source already removed)
  recovers over minutes;                      -> see "Intensive care for
  accumulated dose stays on record               lethal doses" below
            |
   4. MOP UP
      Treat radiation burns and open wounds as normal ACE/KAT injuries.
```

The short version of supportive care for a survivable casualty: **stop the contamination (decon/chelate), replace the blood they're losing (IV), keep infection out (antibiotics), make them comfortable (antiemetic), and speed the marrow back (filgrastim).** Then time does the rest. A **lethal** casualty needs all of that *plus* the sustained intensive-care protocol below — they will not recover on supportive care alone.

---

## Intensive care for lethal doses

A lethal dose (the top tier, ≥ 6 Gy by default) **will not recover on its own** — but it's survivable if a medic commits to a hard, ~15-minute intensive-care fight. There are two layers: keep them alive, then actually cure them. (Mission makers can switch this off with *Lethal dose curable*, making the top tier terminal again.)

### Layer 1 — keep them alive
A lethal casualty collapses unconscious and starts a hidden "time to arrest" clock. **Circulatory support holds that clock off:**

- an **active IV line** (blood or saline), **or**
- a **vasopressor** in their system (epinephrine / norepinephrine).

Let support lapse and the clock runs out → **cardiac arrest**, at which point it's a full CPR / defibrillator / rhythm-management emergency (the normal cardiac-arrest system, advanced rhythm and all). Support is the bare minimum just to stop them dying — it does **not** cure anything.

### Layer 2 — actually cure them
Their radiation sickness only winds down while the **entire intensive-care stack is sustained at once**:

1. **Source removed** — fully deconned *and* chelated (Prussian blue), out of any field. While any dose is still coming in, nothing improves.
2. **Circulatory support** — the IV or vasopressor from Layer 1.
3. **Filgrastim** — kept topped up.
4. **Antibiotics** — kept topped up (and the only thing stopping sepsis finishing them off in parallel).
5. **Stem-Cell / Marrow Rescue** (`kat_stemCells`) — the pivot. Medic-only, slow to administer, and re-dosed as it wears off. **Without it, full support only *holds* them — alive but never improving.** With it, the sickness finally starts to clear.

Sustain all five and severity grinds down over roughly **12–16 minutes**, after which they drop out of the danger zone and finish recovering normally. Drop any one and the cure **stalls**.

### They stay unstable until it's done
Bringing someone back from arrest doesn't make them safe. While they're still heavily irradiated their system keeps **crashing back into arrest** — even on an IV — and (with advanced rhythm on) throws **VF/VT far more often**. Both taper off as the cure progresses, so the way to *stop* the re-crashes is to push the cure down, not just park them on a pressor. Expect to resuscitate the same patient more than once before they're out of the woods.

> This is deliberately brutal: one medic with a couple of items can't do it. It takes the full kit, constant re-dosing, and someone watching the monitor for the next arrest — a genuine team effort to save one person.

---

## Prophylaxis: the smart play

The cheapest treatment is the one you take before anything happens. If you know you're going into a contaminated area:

- **Take KI first** — it reduces how much radioiodine your body takes up while you're in there.
- **Mask and suit up** per the [shielding rules](03_protection_and_shielding.md) — the mask especially, to keep internal contamination out.
- **Carry a dosimeter and watch the accumulated dose**, not just the rate. Leave before it climbs into the tiers you can't walk back from.

A prepared unit can work a hot zone and recover. An unprepared one finds out about the dose when the vomiting starts.

---
