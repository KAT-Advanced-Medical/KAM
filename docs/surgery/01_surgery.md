# Field Surgery & Advanced Diagnostics

## Ultrasound Imaging Matrix
* **Operational Rules:** Run on the chest wall under the **Surgery Context Selection Tab**. Placing a casualty into an "Imaged State" maps out real-time diagnostic output fields across three structural regions:
  * *Airway Status:* (Currently defaults to optimal baseline operation).
  * *Cardiac Performance:* Flags profiles as **Shockable** (VT/VF lines), **Unshockable** (PEA/Asystole lines), **Tamponade** patterns, or **Normal**.
  * *Thoracic Cavity:* Identifies structural **Pneumothorax**, **Hemopneumothorax**, or advanced **Tension Pneumothorax** states.
* **Procedure Activation:** Maintaining an active "Imaged State" serves as a dependency to execute specialized field interventions, specifically Pericardial Taps and REBOA insertions.

---

## Specialized Invasive Interventions

### Pericardial Tap
Involves advancing a needle into the pericardial sac to draw off restrictive fluid collections. Resolves active cardiac effusion and structural tamponade states, restoring standard cardiac sizing metrics. Successfully performing this operation consumes the active diagnostic state, resetting the patient back to an "Unimaged State".

### REBOA Balloon Catheterization
Resuscitative Endovascular Balloon Occlusion of the Aorta (REBOA) threads a balloon-tipped catheter through the femoral artery to manually block down-stream blood loss.

<div style="font-family:serif; border-left:3px solid #3498db; padding-left:12px; margin:10px 0;">
  <b>[ZONE I OCCLUSION]:</b> Catheter advanced high into the core aortic arch. Complete mechanical arrest of all arterial blood flow across the central chest cavity down through the lower limbs.<br>
  <b>[ZONE III OCCLUSION]:</b> Balloon inflated at the base abdominal junction. Shuts off all arterial perfusion elements exclusively across lower limbs.
</div>

* **Insertion Steps:** Demands an active "Imaged State" paired with a REBOA Catheter box inside the kit inventory. Insertion occurs over the right lower extremity, blocking all bleeding lower vectors and dropping the casualty back into an "Unimaged State".
* **Catheter Adjustment Management:** Advancing or removing the module can be performed without requiring a secondary active ultrasound sweep.
""",

    "docs/chemical/06_fractures.md": """# Fracture Classification & Surgical Management

## Field Assessment Protocols
* **Action:** Choose individual injured skeletal limbs and execute **Check Fracture** within the diagnostic interaction panel.
* **Surgical Efficiency Requirement:** Execution of advanced open realignment techniques must track at high speed. Delays can cause the patient to emerge early from anesthesia, triggering immediate pain spikes and rapid cardiac arrest under specific server rules.

---

## Orthopedic Surgical Workflows

### Simple Fracture Management
1. Inject or administer target systemic analgesics (**Morphine**, **Penthrox**, or **Lidocaine** arrays).
2. Execute field **Closed Reduction** alignment techniques. Apply Splints to finish.

### Complex / Open Fracture Surgery Setup
*Review server-specific Anesthesia configurations prior to cutting:*
* *Anesthesia Induced Apnea:* Surgery demands total unconscious sedation paired with continuous general anesthesia metrics.
* *Strict Unconsciousness Required:* The surgical pipeline instantly fails if any patient consciousness indicators register.
* *Awake Pain Tolerance Settings:* Realignment is accessible while awake but inflicts massive, severe pain inputs.

<div style="background-color:#f1f2f6; border:1px solid #ced6e0; padding:15px; border-radius:4px; font-size:10.5pt;">
  <b>[STEP 1: SEDATION BLOCK]</b> &rarr; Push <i>Lorazepam</i> line to establish baseline sedation metrics.<br>
  <b>[STEP 2: GENERAL ANESTHESIA]</b> &rarr; Push <i>Etomidate</i> profile. Re-administer injection cycles strictly <b>every 35 seconds</b>.<br>
  <b>[STEP 3: PRIMARY INCISION]</b> &rarr; Open soft tissues with <i>Scalpel</i> module over target sector.<br>
  <b>[STEP 4: SKELETAL EXPOSURE]</b> &rarr; Deploy <i>Retractor</i> units to open and expose bone fragments.<br>
  <b>[STEP 5: OPEN REDUCTION METHOD PREPARATION]</b><br>
  &nbsp;&nbsp;&bull; <i>Compound Variant:</i> Irrigate open track area using exactly 250ml Normal Saline crystalloids.<br>
  &nbsp;&nbsp;&bull; <i>Comminuted Variant:</i> Apply surgical <i>Clamp</i> modules to stabilize fragments.<br>
  <b>[STEP 6: INTERNAL FIXATION]</b> &rarr; Secure structural <i>Bone Plate</i> sets directly into target alignment lines.<br>
  <b>[STEP 7: EMERGENCE PHASE]</b> &rarr; Halt <i>Etomidate</i> anesthesia loops.<br>
  <b>[STEP 8: REVERSAL AGENTS]</b> &rarr; Push <i>Flumazenil</i> line to clear residual sedation elements.<br>
  <b>[STEP 9: WAKE PROTOCOL]</b> &rarr; Execute manual Reorient Patient action or administer Ammonium Carbonate.
</div>
