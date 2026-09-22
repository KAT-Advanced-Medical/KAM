# **Arterial Blood Gas (ABG) Testing** {#arterial-blood-gas}

---

Arterial Blood Gas (ABG) testing lets a medic pull a precise, numeric snapshot of a patient's actual internal blood chemistry — **PaCO2**, **PaO2**, **SpO2**, **HCO3**, and **pH** — instead of relying on the approximated vitals and visual symptoms available elsewhere. It is a diagnostic confirmation tool: the acid-base state it reveals is the same one driving [Kidney Function (Acidosis)](01_kidneys.md) and the [Respiratory System](../Respiratory/01_airways_and_lungs.md) behind the scenes, but ABG testing is the only way to read it as exact figures rather than an indirect symptom or status label.

{% hint style="info" %}
ABG testing is disabled by default. A host must enable the **"Enable ABG Testing"** CBA setting before any of the actions below appear.
{% endhint %}

## 🩺 Values Measured

| Value | Meaning | Normal (baseline) |
| :--- | :--- | :---: |
| **PaCO2** | Partial pressure of arterial CO2 | 40 mmHg |
| **PaO2** | Partial pressure of arterial O2 | 90 mmHg |
| **SpO2** | Arterial oxygen saturation | 96% |
| **HCO3** | Bicarbonate (buffering capacity) | 24 mEq/L |
| **pH** | Blood acidity/alkalinity | 7.4 |

The result is a snapshot taken at the moment the sample is drawn. It does **not** update afterward even if the patient's condition changes — it is a lab result from that point in time, not a live monitor.

---

## 🧪 Procedure

Drawing, testing, and reading a result are three separate steps, and can be carried out by different medics at different locations.

{% stepper %}
{% step %}
### 1. Draw Arterial Sample
As a medic, select **Draw Arterial Sample** on one of the patient's limbs (Left/Right Arm or Leg) in the *Advanced Treatment* section.
* Takes 10 seconds and requires medic status.
* Requires an **established IV or IO** on the selected limb — but only when the **"Blood Drawing Require IV/IO"** setting is enabled (see note below).
* On success, a blood sample item is added to the medic's inventory.
{% endstep %}

{% step %}
### 2. Test the Sample
Carry the sample to a **medical vehicle** (any vehicle ACE recognizes as one). Open the interaction menu on it and select **Run ABG Test**, then the sample entry matching the patient's name.
* This consumes the sample item and prints the raw reading to the screen.
* The medic receives a result item in exchange, to be applied to the patient afterward.
{% endstep %}

{% step %}
### 3. Apply the Result
Interact with the **same patient the sample was drawn from** and select **ABG Test → Apply *[Patient]* Test**.
* Only results drawn from that specific patient are listed — a result cannot be applied to the wrong patient.
* This consumes the result item and writes the reading onto the patient.
{% endstep %}

{% step %}
### 4. Review in the Medical Menu
Open the **Medical Menu** on the patient and click **ABG Results** to reveal the panel. Applied values are shown per field; anything not yet tested displays as `--.-`.
* The **Reset** button clears all recorded ABG readings for that patient.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
**Blood Drawing Require IV/IO:** an optional CBA setting (default off) shared with regular blood draws for transfusion bags. When enabled, both regular and arterial blood draws require an established IV/IO on the selected limb. When disabled, blood can be drawn from any valid limb without one.
{% endhint %}

{% hint style="warning" %}
Samples and results are reclaimed automatically if left untested/unapplied for **20 minutes** (item lost, medic disconnected, vehicle destroyed, etc.), freeing the slot for other patients. Server-wide, only 20 samples and 20 results can be in flight at once — don't let them sit for too long.
{% endhint %}
