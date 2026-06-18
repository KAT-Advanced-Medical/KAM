# Advanced Cardiac Arrest Management

## Diagnostic Rhythms & Defibrillator EKG Profiles
When a patient experiences cardiac arrest, the heart maps onto one of four internal electronic states. 

<table>
  <tr style="background-color:#2c3e50; color:white;">
    <th style="padding:8px;">Type</th>
    <th style="padding:8px;">Classification</th>
    <th style="padding:8px;">AED Mode</th>
    <th style="padding:8px;">Field Pharmacology Guidance</th>
  </tr>
  <tr>
    <td style="padding:8px;"><b>VT</b></td>
    <td>Ventricular Tachycardia</td>
    <td style="color:green; font-weight:bold;">Shockable</td>
    <td>Epinephrine, Amiodarone, Lidocaine</td>
  </tr>
  <tr style="background-color:#f8f9fa;">
    <td style="padding:8px;"><b>VF</b></td>
    <td>Ventricular Fibrillation</td>
    <td style="color:green; font-weight:bold;">Shockable</td>
    <td>Epinephrine, Amiodarone</td>
  </tr>
  <tr>
    <td style="padding:8px;"><b>PEA</b></td>
    <td>Pulseless Electrical Activity</td>
    <td style="color:red; font-weight:bold;">Non-Shockable</td>
    <td>Epinephrine + Immediate Manual CPR</td>
  </tr>
  <tr style="background-color:#f8f9fa;">
    <td style="padding:8px;"><b>Asystole</b></td>
    <td>Flatline State</td>
    <td style="color:red; font-weight:bold;">Non-Shockable</td>
    <td>Epinephrine + Continuous Manual CPR</td>
  </tr>
</table>

### Mechanical Deterioration Flow
Arrest states systematically degrade downward over time:
$$\text{VT} \longrightarrow \text{VF} \longrightarrow \text{PEA} \longrightarrow \text{Asystole}$$
*Exception:* Exsanguination past the fatal blood limit (< 3.6L) triggers an immediate crash directly into Asystole. Executing successful CPR/AED interventions systematically bumps the underlying cardiac index up one level (e.g., Asystole back to PEA). Active CPR slows down the countdown timer to death by exactly 50%.

---

## Reversible Arrest Etiologies: The H&T Profiles
Patients presenting with the conditions below trigger a Pulseless Electrical Activity (PEA) loop. If these underlying drivers are not reversed, the heart remains locked in arrest regardless of ongoing chest compressions.

* **Hypovolemia:** Blood volume loss exceeding 2.4 Liters (Patient status displays "Lost a Fatal Amount of Blood").
* **Hypoxia:** Severe respiratory failure where internal $SpO_2$ measurements register below the default critical 80% boundary.
* **Hydrogen Ion Excess (Acidosis):** Severe metabolic pH imbalances driven by aggressive unbuffered normal saline over-infusions.
* **Tension Pneumothorax:** Unrelieved stage-4 mechanical pressure inside the chest wall cavity.
* **Tamponade:** Fluid build-up inside the pericardial sack, triggered when trauma bypasses the deep penetrating injury threshold without causing a pneumothorax.

---

## Defibrillation Procedures

### Standard AED Operation
1. Enforce safety perimeter—verify no team units are actively executing CPR or BVM cycles.
2. Open target chest inventory window and select **Attach AED Pads**.
3. Select **Analyze Rhythm**:
   * *Shock Advised:* Allow the capacitors to auto-charge. Upon hearing the solid status audio, apply shock. Administer field pharmacology blocks directly preceding the electrical release (Limit: 1 med dose per shock).
   * *No Shock Advised:* Immediately transition into structural manual CPR iterations, push Epinephrine line, and reassess electronic distal pulse indices every 2 minutes.

### AED-X (Advanced Systems) Features
The X-Series platform unlocks manual control systems alongside an integrated digital monitor panel:
* Grants access to manual capacitor charge and safety disarm sequences.
* Powers real-time visual assessment of the patient's underlying cardiac waveforms directly on-screen.
