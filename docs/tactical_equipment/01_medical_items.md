# Items Featured in the Mod

A feature introduced by this mod enables you to find all the medical-related items under a dedicated **“Medical”** category in the arsenal. 

{% hint style="warning" %}
**Important Notes:**
*   Not all items are required for a successful treatment — some are auxiliary and can help you improve your performance.
*   Using some items or performing self-treatment may require medical/doctor permissions — check your or the host's in-game addon settings.
*   Most medicines do not work instantly — you need to wait for the full effect.
{% endhint %}

---

## 🩺 Core Systems & Mechanics

### Pain & Unconsciousness
* **Pain Scale (0 to 1):** Pain reduction is given on a `0 - 1` scale, `1` being the ability to suppress severe pain.
* **The Threshold Risk:** Pain suppression exceeding the `0.5` point on the pain scale brings a risk of losing consciousness once hit.
* **Hit Zones:** It’s worth considering that hits to the head have a higher chance of causing unconsciousness than hits to other body parts.

### Vital Signs Glossary
* **BP:** Blood Pressure  
* **HR / PR:** Heart Rate / Pulse Rate  
* **SpO2:** Oxygen Saturation in the blood  
* **Bradycardia:** HR drops by 40 BPM within 2 minutes and lasts for 20 minutes.

### Medication Control Limits
* **Max Dose:** Max number of safe uses of the medication.
* **Max Dose Deviation:** A number of additional doses that can be given with the risk of overdose up to the combined `Max Dose + Max Dose Deviation`. Any doses higher will cause an overdose.  
* **Max Relief:** The amount of pain the pain med can manage. If pain is over this value, the effectiveness of the med will be one quarter of normal.  
* **Opioid Relief:** Increases the damage threshold of the unit by multiplying this number with the base damage threshold for as long as the medication is in the system.

---

## 🏷️ Table Legend & Action Scopes

{% columns %}
{% column %}
### Use Classification (Row Tags)
* **[C]**: Shockable Cardiac Arrest treatment medicines (One-time use only / Red colour equivalent).
* **[S]**: Surgery items (Depends on settings / Orange colour equivalent).
* **No Tag / Yellow**: No limit.
* **Blue Text**: Pain Suppressor.
{% endcolumn %}

{% column %}
### Treatment Zones (Action Column)
* **H**: Head 
* **T**: Torso 
* **L**: Limbs
{% endcolumn %}
{% endcolumns %}

---

## 💊 Field Medications & Autoinjectors

| Tag | Name | Description / Effects | Time in Body | Max Dose | Max Deviation | Conditions | Action |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| | <span style="color:blue">**Morphine Autoinjector**</span> | **Suppresses pain** (0.8), decreases HR, decreases BP | 30 min | 4 | 2 | - | **L** |
| | **Adenosine Autoinjector** | Decreases HR, decreases BP | 2 min | 6 | 2 | - | **L** |
| | **Epinephrine Autoinjector** | Increases HR, increases BP, **boosts wake-up chances**, stamina drain rate is reduced by 50%, slight stamina boost, slows down bleeding and transfusion by 15% | 2 min | 6 | 4 | - | **L** |
| | **IV Epinephrine** | Increases HR, increases BP, **boosts wake-up chances**, slows down bleeding and transfusion by 30% | 2 min | 4 | 2 | IV/IO inserted | **L, T** |
| | **Norepinephrine** | Increases HR, increases BP, slows down bleeding and transfusion by 30% | 6 min | 12 | 2 | IV/IO inserted | **L, T** |
| | **Nitroglycerin** | Increases HR, decreases BP, speeds up bleeding and transfusion by 30% | 6 min | 6 | 4 | IV/IO inserted | **L, T** |
| | **Phenylephrine** | Decreases HR, increases BP, slows down bleeding and transfusion by 50% | 6 min | 6 | 4 | IV/IO inserted | **L, T** |
| | **Phenylephrine Autoinjector** | Decreases HR, increases BP, slows down bleeding and transfusion by 30% | 6 min | 6 | 4 | - | **L, T** |
| | <span style="color:blue">**CWMP**</span> | **Suppress pain** (0.2), increase HR slightly, decrease BP, 4 pills per item. Has a max relief of 0.5. | 10 min | 6 | 4 | - | **H** |
| | **Ammonium Carbonate** | Increases HR, **assists revival** (see Essential Values), 10 uses per item | 30 sec | 10 | 2 | Unconscious | **H** |
| | **TXA** | See **Coagulation** | 2 min | 3 | 2 | IV/IO inserted | **L, T** |
| | **EACA** | See **Coagulation** | 10 min | 10 | 2 | IV/IO inserted | **L, T** |
| | <span style="color:blue">**Ketamine**</span> | **Suppresses pain** (0.8), increases HR, increases BP, causes chromatic aberration | 15 min | 2 | 2 | IV/IO inserted | **L, T** |
| | <span style="color:blue">**Fentanyl**</span> | **Suppresses pain** (1), decreases HR, decreases BP, causes chromatic aberration. Has an opioid relief of 1.5 | 15 min | 1 | 1 | IV/IO inserted | **L, T** |
| | <span style="color:blue">**Nalbuphine**</span> | **Suppresses pain** (0.6), decreases HR, decreases BP. Has an opioid relief of 1.2 | 15 min | 2 | 2 | IV/IO inserted | **L, T** |
| **C** | **Amiodarone** | Increases AED chances (by 8% - 20%), 33% chance to cause bradycardia | 2 min | 4 | 2 | IV/IO inserted | **L, T** |
| **C, S** | <span style="color:blue">**Lidocaine**</span> | **Suppresses pain** (0.2), Increases AED chances by 8%, suppresses pain during surgery and NPWT, Max Relief of 0.6 | 2 min | 2 | 4 | IV/IO inserted | **L, T** |
| **C** | **Atropine** | Increases HR, treats bradycardia, cures chemical intoxication | 2 min | 4 | 2 | IV/IO inserted | **L, T** |
| | <span style="color:blue">**Pervitin**</span> | Multistage stamina drug, increases HR, increases BP, **suppresses pain** (0.5). After stamina boost is over, stamina drain will become greater than regular. Chromatic aberration and weapon sway as side effects. 8 uses per item | 10 min | 2 | 1 | - | **H** |
| | <span style="color:blue">**Penthrox**</span> | **Suppresses pain** (0.6), decreases HR, increases BP. Has a max relief of 0.6. | 5 min | 4 | 2 | - | **H** |
| | **Caffeine** | Stamina drug, refills stamina, increases HR slightly. 15 uses per item. | 30 min | 4 | 4 | - | **H** |
| | **Naloxone** | Treats morphine, fentanyl and nalbuphine overdose in 1:1 ratio and clears their all effects | - | - | - | - | **H** |
| | <span style="color:blue">**Bubble Wrap**</span> | **Suppresses pain** (0.05). 50 uses per item. Accessed via ACE menu (ctrl + win) | - | - | - | - | - |

---

## 🪓 Advanced Surgical Tools & Sedation (S)

| Tag | Name | Description / Effects | Time in Body | Max Dose | Required Condition | Action |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **S** | <span style="color:blue">**Etomidate**</span> | **Suppresses pain**, reduces HR, anesthetic | 45 sec | 10 | IV/IO inserted | **L, T** |
| **S** | **Lorazepam** | Reduces BP, sedates the patient, 33% chance to cause bradycardia | 1 min | 3 | IV/IO inserted | **L, T** |
| **S** | **Flumazenil** | Removes the sedation | 1 min | 3 | IV/IO inserted | **L, T** |
| **S** | **REBOA** | Surgical item that when placed, can block bleeding to the legs and torso | - | - | - | **L** |
| **S** | **Ultrasound** | Allows for the placement of REBOAs and the diagnosing of airway issues, breathing complications, and cardiac status. Also allows the Pericardial Tap action | - | - | - | **T** |
| **S** | **Bone Plate** | A metal piece screwed into a bone | - | - | - | **L** |
| **S** | **Clamp** | Used for clamping a wound | - | - | - | **L** |
| **S** | **Dressing vacuum (NPWT)** | Personal Aid Kit equivalent that only affects a selected body part. Apply NPWT Dressing on the selected body part in order to bandage and stitch its wounds. | - | - | - | **L** |
| **S** | **Retractor** | Used for exposing fractures | - | - | - | **L** |
| **S** | **Scalpel** | Used for performing incisions | - | - | - | **L** |

---

## 🎒 Tactical Field Equipment & Airway Management

### Airway & Breathing
* **Guedel Tube:** Prevents obstructions from happening.  
  * *Condition:* Unconscious, no occlusion | *Action:* **H**
* **King LT:** Prevents obstructions and occlusions from happening.  
  * *Condition:* Unconscious, no occlusion | *Action:* **H**
* **Accuvac:** A device used to remove occlusion from airways.  
  * *Condition:* Unconscious | *Action:* **H**
* **Manual Suction Pump:** A single-use device used to remove occlusion from airways.  
  * *Condition:* Unconscious | *Action:* **H**
* **BVM:** Patient not breathing: Slows down SpO2 loss. Patient breathing: Increases SpO2 restoring ratio. For better effect, Portable Oxygen Tank can be used.  
  * *Condition:* Airways are clear, unconscious | *Action:* **H**
* **Pocket BVM:** Compact BVM version. Cannot utilize Portable Oxygen Tank.  
  * *Condition:* Airways are clear, unconscious | *Action:* **H**
* **Portable Oxygen Tank:** Comes in two volumes (150L or 300L). Used to provide oxygen for BVM. Oxygen can be refilled at medical facilities/vehicles (ACE interaction). Medical facilities/vehicles act as infinite oxygen sources for BVM actions, if performed by them.  
  * *Condition:* - | *Action:* **-**

### Trauma & Circulation Diagnostics
* **AAT Kit:** Used for needle decompression and fluid draining.  
  * *Condition:* - | *Action:* **T**
* **NCD Kit:** Used for needle decompression.  
  * *Condition:* - | *Action:* **T**
* **Chest Seal:** Dressing used for treating pneumothorax.  
  * *Condition:* - | *Action:* **T**
* **Stethoscope:** Allows the diagnosis of thorax injuries.  
  * *Condition:* - | *Action:* **T**
* **Pulse Oximeter:** Monitors PR and SpO2.  
  * *Condition:* No active pulse oximeter on patient’s body | *Action:* **L**
* **Nasall Cannula:** Monitors ETCo2 and Respiratory Rate when a Vitals Monitor is attached.  
  * *Condition:* - | *Action:* **H**
* **CoagSense:** See Coagulation.  
  * *Condition:* - | *Action:* **L**

### Infusions, Access & Utility
* **16g IV:** Intravenous needle, used before administering fluids on limbs.  
  * *Condition:* - | *Action:* **L**
* **FAST IO:** Intraosseous needle, used before administering fluids on the torso.  
  * *Condition:* - | *Action:* **T**
* **Field Blood Transfusion Kit:** Used to take blood from players/AI.  
  * *Condition:* Enough inventory space, donor has at least 3.6l of blood (default settings) | *Action:* **L, T**
* **AED:** Automated External Defibrillator, the X-series version has a vitals monitoring function.  
  * *Condition:* Unconscious, not undergoing CPR | *Action:* **T**
* **Surgical Kit:** Used for wounds stitching.  
  * *Condition:* - | *Action:* **L, T, H**
* **Personal Aid Kit:** Removes all injuries.  
  * *Condition:* Patient is stable | *Action:* **-**
* **IV Stand:** Allows administering saline from a stand.
* **Stretcher:** Enables transporting wounded soldiers.
* **Helistretcher:** Enables transporting wounded soldiers by a helicopter.
