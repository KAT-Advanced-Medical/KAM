# Coagulation & Biochemical Buffers

## Automated Clotting Systems
* **Clot Factor Expenditure:** Simulated coagulation serves as a natural system response that auto-bandages bleeding lesions. When open wounds register, factor counts drain from the active reservoir based on structural sizing:
  $$\text{Small Lesion: } -1 \text{ Factor} \quad\Vert\quad \text{Medium Lesion: } -2 \text{ Factors} \quad\Vert\quad \text{Large Lesion: } -4 \text{ Factors}$$
* **Factor Recovery Loops:** Regenerated via whole blood/plasma administration or through automated internal regeneration cycles. High surplus counts naturally decay down to standard values over time.

## CoagSense Diagnostics
The CoagSense reader checks coagulation factor counts against standard physiological baselines.

* **Very Low INR:** $\le 50\%$ of baseline pool reserves.
* **Slightly Below Normal INR:** $50\% \longleftrightarrow 75\%$ of baseline pool reserves.
* **Normal INR:** $75\% \longleftrightarrow 125\%$ of baseline pool reserves.
* **Slightly Above Normal INR:** $125\% \longleftrightarrow 150\%$ of baseline pool reserves.
* **Very High INR:** $\ge 150\%$ of standard pool baseline values.

---

## Tactical Anti-Fibrinolytics Field Guide

### Tranexamic Acid (TXA)
* **Coagulation Disabled Mode:** Auto-applies standard packing bandage compression algorithms across all damaged areas every 6 seconds over a total 120-second active window.
* **Coagulation Active Mode:** Doubles natural factor recovery generation speeds when values track below regular lines. Directs the vascular simulation engine to apply robust, highly structural **TXA Clots** instead of standard fragile variations over open vessel tears.
* **Failure Window:** TXA clots carry an absolute 30% chance of sudden mechanical failure and renewal of bleeding, tracking between the 5-minute mark and a maximum 10-minute lifecycle window.

### Epsilon-Aminocaproic Acid (EACA)
* **Coagulation Disabled Mode:** Sequentially applies surgical stitches to all lesions every 6 seconds until external wounds are closed or the patient flatlines.
* **Coagulation Active Mode:** Mode rules align directly with standard TXA enhancements.
* **Combination Synergies:** Running TXA and EACA concurrently inside the circulatory stream upgrades output structures directly into resilient **EACA Clots**. These enhanced variants feature a low 10% detachment risk, delaying degradation tracking until 10 to 20 minutes have elapsed.
