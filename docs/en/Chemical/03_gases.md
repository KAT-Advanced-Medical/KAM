## The Six Agents (Gases)

A bird's-eye comparison first, then the details.

| Agent | Class | Tier | Cloud look | Smell | Onset | Lethality | Treatment |
|-------|-------|------|-----------|-------|-------|-----------|-----------|
| **CS / Tear gas** | Riot control | 0 | White / pale | None | Immediate | Non-lethal | Leave the cloud; wears off |
| **Chlorine** | Choking | 1 | Greenish-yellow | Sharp chlorine | Builds with exposure | **High if heavily dosed** | Oxygen + Dexamethasone |
| **Phosgene** | Choking | 1 | Pale grey-white | Faint fresh hay | **Delayed, dose-dependent** | **Lethal at any felt dose** | Oxygen + Dexamethasone |
| **Mustard** | Blister | 2 | Brown-yellow | Garlic / mustard | Builds over minutes | **High if untreated** | Decon kit + Dexamethasone (+ wound care) |
| **Sarin** | Nerve (G) | 2 | Nearly invisible | None | Fast (~90 s to death) | **Very high** | ATNAA |
| **VX** | Nerve (V) | 2 | Oily amber | None | Slower but persistent | **Very high** | ATNAA **and** decon kit |

### CS / Tear Gas (Level 0)

The non-lethal one. CS is a riot-control irritant — it won't injure anyone medically, but it's miserable to be in. A gas mask protects the airway; note that CS still affects the **eyes** even through an oxygen mask, so it's not something you can simply ignore.

- **Cloud:** white / pale, lasts about 60 seconds.
- **Effect:** there's a configurable chance of dropping your weapon while inside the cloud (off by default — set *Drop Weapon Chance* above 0 to enable it).
- **Treatment:** none needed. Step out and it passes after about 30 seconds (*CS Gas Duration*).
- **Delivery of note:** the `KAT_M7A3` hand grenade is a dedicated CS gas grenade.

### Chlorine (Level 1)

The classic choking agent and the direct descendant of the legacy "toxic gas." A gas mask blocks it completely.

- **Cloud:** greenish-yellow, lingers around 200 seconds — the longest-lasting of the conventional clouds.
- **Smell (unmasked):** *"You smell chlorine in the air..."*
- **Symptoms:** damage accumulates the whole time you are in the cloud, and builds faster the deeper in you are — the fringe is survivable, the centre is not. You start coughing, breathing gets fast and shallow, and SpO2 falls.
- **Treatment:** a heavy dose kills in roughly eight minutes if nobody intervenes. **Oxygen** buys time, **Atropine** stops the deterioration, and **Dexamethasone** cures it. See [Inhalation & Chemical Lung Injury](../Respiratory/03_inhalation_injury.md).

### Phosgene (Level 1) — the silent killer

Phosgene is what makes a gas mask feel essential. It's a choking agent like chlorine, but its danger is *time*. You can breathe a lethal dose, feel completely fine, walk away, and collapse minutes later.

- **Cloud:** pale grey-white, lasts about 90 seconds.
- **Smell (unmasked):** *"You catch a faint smell of fresh hay..."* — easy to dismiss, which is the point.
- **Any dose you can feel is eventually fatal.** Unlike the other agents there is no “mildly gassed” outcome with phosgene: roughly five seconds in the thick of it, or half a minute at the fringe, is enough to commit you. Below that it clears; above it, you die in ten to fifteen minutes unless treated.
- **Symptoms:** nothing at first. Then pulmonary edema hits — coughing, fast shallow breathing and collapsing SpO2 — *even though you left the cloud long ago*. **The latency scales with how much you breathed:** a whiff can take the full six minutes, a lungful crashes you in two.
- **Treatment:** **oxygen** first — it will hold even a badly dosed casualty. Then **Dexamethasone** to cure it. Atropine only stops it getting worse. The trick is realising you were dosed before the symptoms arrive.
- **Important:** M8 paper reads **NEGATIVE** for phosgene — detection paper does not react to choking agents. Don't trust a clean M8 result as "all clear."

### Mustard / Yperite (Level 2) — gets worse over time

A blister agent that requires the full CBRN suit. Mustard doesn't kill quickly; it disables, and it keeps hurting you long after you've left the cloud because it contaminates your skin and gear.

- **Cloud:** thick brown-yellow, lasts about 120 seconds.
- **Smell (unmasked):** *"You smell garlic and mustard..."*
- **Progression (with default timings):**
  1. **On contact:** skin contamination is applied immediately (visible in the medical menu).
  2. **~40–100 s:** eye injuries set in — heavy vision impairment, possibly both eyes.
  3. **~100–240 s:** chemical burn wounds open up across the body, with inhalation lung injury and rising pain. Note this is **not** a pneumothorax — a chest seal will do nothing.
  4. **Every 40 s thereafter:** while you remain contaminated, the burns keep re-applying. Leaving the cloud does **not** stop this.
- **Treatment:** the **Decontamination Kit** stops the contamination and cancels the pending eye/burn timers. Burns and eye injuries that have already happened are treated as normal wounds through ACE/KAT medical. The lung injury needs **oxygen** and **Dexamethasone** on top.

### Sarin (Level 2) — fast nerve agent

A G-series nerve agent and the fastest killer in the set. Requires the full CBRN suit. What makes sarin terrifying is that the cloud is **nearly invisible and odourless** — you may not know you're in it until the symptoms start.

- **Cloud:** faint warm tint, very hard to see; lasts about 90 seconds.
- **Smell:** none.
- **Progression (default timings, from first exposure):**
  - **30 s:** vomiting begins.
  - **60 s:** unconsciousness.
  - **90 s:** cardiac arrest → death if untreated.
- **Treatment:** the **ATNAA auto-injector**. Administered before the cardiac-arrest deadline, it clears the nerve-agent exposure and **aborts the cardiac arrest before it fires**. With default timings you have a 90-second window from exposure. Atropine does *not* abort the nerve chain. Sarin also causes mild lung injury from bronchial secretions, so a survivor may still need oxygen.

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
