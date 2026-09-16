## The Six Agents (Gases)

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
- **Treatment:** none needed. Step out and it passes after about 30 seconds (*CS Gas Duration*).
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
