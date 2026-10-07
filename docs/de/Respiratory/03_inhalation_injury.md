# **Inhalation & Chemical Lung Injury**

---

Some injuries damage the lungs from the inside without ever breaking the chest wall. Breathing chlorine, phosgene or mustard vapour floods the alveoli and destroys gas exchange, but the ribs are intact, the chest rises evenly, and there is no wound to seal.

{% hint style="danger" %}
**This is not a pneumothorax.** A chest seal, needle decompression and a chest tube will all do nothing for it. Reaching for them wastes the minutes the casualty actually has.
{% endhint %}

---

## 🩺 What It Looks Like

Lung injury is graded rather than on/off. It builds over roughly a minute after exposure rather than appearing all at once, so a casualty will visibly deteriorate in front of you — and once it peaks, it stays there. Saturation takes a further three to five minutes to fall all the way, so a badly gassed casualty gets worse for several minutes after they think they are clear.

| Severity | Respiratory Rate | SpO2 (room air) | What you see |
| :--- | :---: | :---: | :--- |
| **Mild pulmonary irritation** | slightly raised | ~96% | Faintly short of breath, easily missed |
| **Chemical pneumonitis** | noticeably fast | ~90% | Visible distress, cyanosis beginning |
| **Severe pulmonary oedema** | very fast | 70% and falling | Severe distress, deep cyanosis, heading for unconsciousness |

At the top of the scale a casualty on room air will die in a matter of minutes. On oxygen they will hold.

---

## 🩺 The Distinguishing Sign

The trap is that rapid breathing plus falling SpO2 also describes a tension pneumothorax. What separates them is **EtCO2**.

*   **Chest trauma:** the casualty moves less air overall, so EtCO2 tracks with their breathing.
*   **Inhalation injury:** the casualty moves plenty of air, it just cannot reach the blood. **Respiratory rate climbs and SpO2 falls while EtCO2 stays flat.**

That mismatch — working hard, breathing fast, saturation dropping, EtCO2 unchanged — is the signature of inhalation injury, and it is the fastest way to rule out a pneumothorax on a monitor.

---

## 🩺 Diagnosis

| Method | Finding |
| :--- | :--- |
| **Listen** | **Coughing** every 30 seconds or so, audible to anyone within 15 m. Usually the first sign, and often how you find the casualty in the first place |
| **Auscultate (Stethoscope)** | **Crackles** — wet, fine popping, distinct from the short breath of a PTX or the cracking of a hemothorax |
| **Inspect Chest** | *"Chest rises evenly, no penetrating wound. Breathing is rapid and laboured."* The explicit absence of asymmetry is the finding that rules out chest trauma |
| **Check Breathing** | **Shallow** at mild, **Very Shallow** from pneumonitis upward |
| **Pulse Oximeter** | Falling SpO2 with a rising respiratory rate |
| **Capnography (EtCO2)** | Flat while the respiratory rate climbs — see above |

{% hint style="info" %}
By default, inhalation injury is **not** listed in the medical menu — you have to examine the casualty to find it. Mission makers can switch it on with *Show lung injury in medical menu*.

It also produces **no "Intoxication" entry**, and no chemical screen effect. Those belong to chemical poisoning, which is a separate thing — a casualty can have one without the other, and a nerve-agent casualty should not be labelled as poisoned lungs. What you do get is the coughing above, and the generic low-SpO2 screen effect once saturation has fallen far enough.
{% endhint %}

---

## 🩺 Treatment

Four tools, and only the last one actually cures.

| Step | Tool | What it does |
| :--- | :--- | :--- |
| **1. Oxygen** | Oxygen Mask, Portable Oxygen Tank | **A bridge, not a cure.** Raises SpO2, and halves how fast the injury worsens — roughly doubling your working window. But it does not stop it |
| **2. Stop the source** | Decontamination Kit | Stops mustard or VX contamination re-dosing the casualty. Without this the injury keeps being driven back up |
| **3. Halt progression** | Atropine | **Stops the deterioration dead.** The casualty holds where they are instead of sliding toward death. It does **not** reverse damage already done |
| **4. Cure** | **Dexamethasone** | Corticosteroid. Takes an immediate bite out of the injury, then resolves the rest over a few minutes. **This is the only thing that clears it** |

{% hint style="danger" %}
**Chemical lung injury does not stabilise — it gets worse.** An untreated chlorine casualty is unconscious in about five minutes and dead in about eight. Mustard takes around eleven. Phosgene, once its latency expires, kills in under five.
{% endhint %}

### Trauma is different from chemistry

This is the one place the two diverge, and it matters at the bedside:

*   **Trauma** — blast lung, smoke inhalation, aspiration. The damage is done, then **static**. It holds where it peaked and waits for you.
*   **Chemical** — chlorine, phosgene, mustard. The agent keeps destroying tissue after you leave the cloud, so the injury **climbs toward death** until something stops it.

Severity also decides whether it progresses at all:

| Severity | What happens untreated |
| :--- | :--- |
| Trivial (below mild) | Clears on its own. Brushing the edge of a cloud leaves nothing |
| Mild | **Holds.** Symptomatic and survivable, but it will never kill you |
| Pneumonitis or worse | **Progresses** toward death. This is the dose that becomes ARDS |

Because severity comes from how much you actually breathed, this sorts itself out: a dash through the fringe resolves, a moderate dose leaves you lastingly unwell, a full lungful kills you.

{% hint style="warning" %}
**Atropine used to cure gas outright. It no longer does.** If you inject a gassed casualty and they stay sick, that is working as intended — it stopped them dying. Give Dexamethasone to actually clear it.
{% endhint %}

{% hint style="danger" %}
**Oxygen hides the problem.** A casualty on a mask can read a comfortable 97% while the injury underneath climbs to maximum. Pull the mask to move them and they may die within seconds. If you are giving oxygen, **auscultate** — the crackles are still there, and they are your only warning.
{% endhint %}

---

## 🩺 Not Just Chemicals

Lung injury lives in the breathing system rather than the chemical one, so anything that floods or scars the alveoli can cause it — chemical agents today, and smoke inhalation, blast lung or aspiration in future. The diagnosis and the treatment ladder above are the same whatever caused it.

**For mod and mission makers:** raise `kat_breathing_setLungInjury` with `[_unit, _severity, _cause]` to inflict it, or set `KAT_LungInjury_Exclusion` to `true` on a unit to opt it out entirely.

---

## 📊 Settings

Under **CBA Settings → KAT - ADV Medical: Breathing → Lung Injury Settings**.

| Setting | Default | Range | What it does |
| :--- | :---: | :---: | :--- |
| Enable lung injury | on | on/off | Master switch. Off reverts to the old all-or-nothing air poisoning behaviour |
| Alveolar surface loss | 0.6 | 0–0.9 | How much usable lung surface is lost at maximum severity. Drives respiratory rate, not saturation |
| Shunt fraction | 0.6 | 0–0.9 | Oxygen transfer lost at maximum severity. Supplemental oxygen overcomes this part proportionally |
| Diffusion barrier (mmHg) | 25 | 0–200 | Fixed barrier oxygen **cannot** overcome. Raise it and severe injury stops being survivable on oxygen alone |
| Onset duration | 100 | 1–3600 | Seconds for severity to climb from none to maximum |
| Recovery duration (treated) | 900 | 1–7200 | Seconds for maximum severity to clear **once Dexamethasone has been given**. Nothing happens without it |
| Chemical progression speed | 1 | 0–5 | How fast untreated chemical injury worsens. **0 disables it** — everything then simply holds until treated. Never affects blast or smoke injury |
| Desaturation speed | 1.5 | 0–5 | How much faster SpO2 falls at maximum injury. At 1.5, severe injury becomes dangerous in about four minutes; 0 uses the normal rate |
| Dexamethasone immediate effect | 0.35 | 0–1 | Severity removed instantly by one dose |
| Dexamethasone recovery multiplier | 4 | 1–10 | How much faster recovery runs while the drug is active |
| Dexamethasone duration | 600 | 1–3600 | How long one dose keeps accelerating recovery |

Under **KAT - ADV Medical: Breathing → Thorax injuries Settings**:

| Setting | Default | Range | What it does |
| :--- | :---: | :---: | :--- |
| Show lung injury in medical menu | **off** | on/off | Off by default so medics must examine the casualty rather than reading severity off a list |

Under **KAT - ADV Medical: Chemical → Contamination & Decontamination**:

| Setting | Default | Range | What it does |
| :--- | :---: | :---: | :--- |
| Lung Injury Rate Multiplier | 1 | 0.1–5 | Scales how fast inhaled gas accumulates into injury. Raise it for short training scenarios |

---

**See also:** [Breathing & Thorax Injuries](02_breathing_injuries.md) for penetrating chest trauma, and the [Chemical Warfare Guide](../Chemical/01_Info_and_QuickStart.md) for the agents that cause this.
