# Human Homeostasis & Vitals Loop

The core engine links cardiovascular metrics, respiratory exchanges, and biochemical buffers together into a single interconnected loop.

<table>
  <tr style="background-color:#1a252f; color:white;">
    <th>Metric Type</th>
    <th>Ideal Profile</th>
    <th>Stable Boundary</th>
    <th>Critical / Lethal Limit</th>
  </tr>
  <tr>
    <td><b>Heart Rate (HR)</b></td>
    <td>80 BPM</td>
    <td>&gt; 40 BPM</td>
    <td>&le; 20 BPM (Arrest Threshold) / &gt; 220 BPM (Max Limit)</td>
  </tr>
  <tr style="background-color:#f8f9fa;">
    <td><b>Blood Pressure (BP)</b></td>
    <td>120 / 80 mmHg</td>
    <td>&gt; 60 / &gt; 50 mmHg</td>
    <td>&le; 50/40 mmHg (If HR &lt; 40) / &gt; 285/190 mmHg</td>
  </tr>
  <tr>
    <td><b>Oxygen Saturation (SpO2)</b></td>
    <td>100%</td>
    <td>&gt; 85%</td>
    <td>&lt; 75% (Unconsciousness Boundary) / &lt; 65% (Lethal)</td>
  </tr>
  <tr style="background-color:#f8f9fa;">
    <td><b>Total Blood Volume</b></td>
    <td>6.0 Liters</td>
    <td>&gt; 5.1 Liters</td>
    <td>&lt; 3.6 Liters (Minimum for HR) / &lt; 3.0 Liters (Lethal)</td>
  </tr>
</table>

---

## Pulmonary Ventilation / Perfusion (V/Q Matching)
* **Base Ratio:** Normal internal ventilation to metabolic lung perfusion matches at a standard $V/Q = 0.8$ index.
* **Anaerobic Compensation:** During severe hemorrhage, the V/Q scales upward to a maximum limit of $1.2$ near 1.5 liters of lost volume to compensate for anaerobic respiration spikes.
* **Cardiorespiratory Coupling:** Elevating Heart Rate ($Q$) inherently expands respiratory demand ($V$). If respiratory pathways cannot match the target threshold, secondary degradation to systemic blood gas values ($PaCO_2$ and $PaO_2$) begins immediately.
* **Tidal Volume Restriction:** Thoracic trauma (PTX/TPTX/HPTX) and pulmonary edema crush internal tidal volumes, forcing the respiratory rate to spike to maintain stable minute ventilation.

---

## Blood Gas Tension Calculations
* **$PaCO_2$ Parameters:** Measures active carbon dioxide pressure in circulating blood (Normal: 35–45 mmHg). Collected tracking errors approximate End-Tidal CO2 ($ETCO_2$) within a 3 to 10 mmHg margin below real pressure. Accumulates when breathing ventilation falls short of active cardiac demand, heavily driving metabolic acidosis calculations.
* **$PaO_2$ & Alveolar Links ($PAO_2$):** Partial oxygen pressures scale based directly on localized atmospheric barometric values and fraction of inspired oxygen inputs ($FiO_2$). Airway collapse drops internal values to zero. 
* **Oxygen Dissociation Tracking:** $SpO_2$ metrics derive directly via a sigmoidal model calculated against active $PaO_2$ ranges (Normal: 85–95% $PaO_2$). This dynamic curve slips laterally based on current body temperature and core systemic pH balances:
  * *Right Curve Shifts:* Induced by hyperthermia or dropping pH states (Acidosis).
  * *Left Curve Shifts:* Induced by hypothermia or rising pH states (Alkalosis).

---

## Core Temperature & Interstitial Fluid Shifts
* **Thermoregulation Baseline:** The system regulates toward a setpoint of 37°C, constantly bleeding off heat into local ambient grid maps. Massive circulatory volume depletion accelerates heat loss, worsened by infusing unheated field fluids.
* **Thermal Field Equipment:**
  * *Hand Warmers:* Placed directly onto individual limbs or the central chest box. Generates focused auxiliary heat elements over a 1-hour lifecycle. Fully consumed upon use.
  * *Fluid Warmers:* Reusable modules mounted cleanly on active IV lines to pre-heat cold incoming fluids.
* **Fluid Space Recruiting:** To defend total blood volume during hemorrhage, the body recruits standard plasma volumes directly out of the internal 10-liter interstitial reservoir, supplemented by a 0.5-liter emergency erythrocyte pool inside the spleen. 
* **Gradient Recoiling:** Once external vessel leaks are closed, interstitial recruitment tracks forward up to a maximum 60% extracellular gradient margin.
