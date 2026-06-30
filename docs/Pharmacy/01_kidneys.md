# **Kidney Function** {#kidney-function}

---

Checking Kidney function is done through the **Examine Patient** tab using the **"Check Breathing"** action on the patient's head.

Kidney function is modeled using an **acidosis index** (internally tracked as `externalPh`) that goes from `0` (ideal/healthy) to `3000` (critical failure/arrest). The system checks these values every 20 seconds.

## 🩺 Kidney States

*   **Normal (Healthy)**  
    *   **Acidosis Index:** `0` to `999`  
    *   **Behavior:** The body naturally filters out the acidosis, restoring the index back to `0` by **decreasing it by 60 points every 20 seconds**.

*   **Pressure**  
    *   **Acidosis Index:** `1000` to `1999`  
    *   **Behavior:** The body struggles to filter the acidity. The index **decreases by only 30 points every 20 seconds** until it drops below `1000` (returning to the Normal state).  
    *   **Physiological Effect:** Triggers a systemic reaction (simulated as a medication) that:
        *   Takes 15 seconds to reach maximum effect.
        *   Lasts for **20 minutes** in the body.
        *   **Increases Heart Rate by 30 BPM** and raises Blood Pressure.

*   **Fail**  
    *   **Acidosis Index:** `2000` to `3000`  
    *   **Behavior:** The kidneys fail completely. Natural recovery stops, and the acidosis index **does not decrease on its own**.  
    *   **Physiological Effect:** 
        *   At `2000 - 2999`: Has a **25% chance every 20 seconds** to trigger Kidney Function Arrest, which immediately causes Cardiac Arrest.
        *   At `3000`: Causes a **100% chance** of Kidney Function Arrest (immediate Cardiac Arrest).

---

## 🧪 Treatment & Restoration

To lower the acidosis index and restore kidney function:
*   **Dialysis:** Done inside a medical vehicle/facility. This completely resets the acidosis index to `0` (ideal).
*   **Transfusions:** Administering **Blood** or **Plasma** reduces the acidosis index (adds negative values).
*   **Avoid Saline Excess:** Administering **Saline** *increases* the acidosis index. Excessive saline use is the primary cause of kidney pressure and failure.

For specific volume adjustments, see the [Fluids](03_fluids.md) documentation.

---

## 👃 Diagnostic Breath Profiles

The **Check Breathing** action checks the patient's actual blood pH (which starts at `7.4` under normal conditions). Note that actual blood pH is distinct from the 0-3000 acidosis index.

| Check Breath Result | Blood pH Value | Clinical State |
| :---: | :---: | :---: |
| **Good (ok)** | $\ge 7.2$ | Normal |
| **Mild (slightly fruity)** | $6.9 \le \text{pH} < 7.2$ | Acidosis / Kidney Pressure |
| **Stink (harsh and metallic)** | $< 6.9$ | Severe Acidosis / Kidney Failure |
