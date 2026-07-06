# Items Featured in the Mod

A feature introduced by this mod enables you to find all the medical-related items under a dedicated **“Medical”** category in the arsenal.

{% hint style="warning" %}
**Important Notes:**

* Not all items are required for a successful treatment — some are auxiliary and can help you improve your performance.
* Using some items or performing self-treatment may require medical/doctor permissions — check your or the host's in-game addon settings.
* Most medicines do not work instantly — you need to wait for the full effect.
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

### Use Classification (Row Tags)

* **[C]**: Shockable Cardiac Arrest treatment medicines (One-time use only / Red colour equivalent).
* **[S]**: Surgery items (Depends on settings / Orange colour equivalent).
* **No Tag / Yellow**: No limit.
* **Blue Text**: Pain Suppressor*

---

## 💊 Field Medications & Autoinjectors

* <span style="color:blue">**Morphine Autoinjector**</span>: **Suppresses pain** (0.8), decreases HR, decreases BP
  * *Duration:* 30 min | *Max Dose:* 4 | *Max Deviation:* 2 | *Action:* Limbs
  * *Class:* `ACE_morphine`

* **Adenosine Autoinjector:** Decreases HR, decreases BP
  * *Duration:* 2 min | *Max Dose:* 6 | *Max Deviation:* 2 | *Action:* Limbs
  * *Class:* `ACE_adenosine`

* **Epinephrine Autoinjector:** Increases HR, increases BP, **boosts wake-up chances**, stamina drain rate is reduced by 50%, slight stamina boost, slows down bleeding and transfusion by 15%
  * *Duration:* 2 min | *Max Dose:* 6 | *Max Deviation:* 4 | *Action:* Limbs
  * *Class:* `ACE_epinephrine`

* **IV Epinephrine:** Increases HR, increases BP, **boosts wake-up chances**, slows down bleeding and transfusion by 30%
  * *Duration:* 2 min | *Max Dose:* 4 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_epinephrineIV`

* **Norepinephrine:** Increases HR, increases BP, slows down bleeding and transfusion by 30%
  * *Duration:* 6 min | *Max Dose:* 12 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_norepinephrine`

* **Nitroglycerin:** Increases HR, decreases BP, speeds up bleeding and transfusion by 30%
  * *Duration:* 6 min | *Max Dose:* 6 | *Max Deviation:* 4 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_nitroglycerin`

* **Phenylephrine:** Decreases HR, increases BP, slows down bleeding and transfusion by 50%
  * *Duration:* 6 min | *Max Dose:* 6 | *Max Deviation:* 4 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_phenylephrine`

* **Phenylephrine Autoinjector:** Decreases HR, increases BP, slows down bleeding and transfusion by 30%
  * *Duration:* 6 min | *Max Dose:* 6 | *Max Deviation:* 4 | *Action:* Limbs, Torso
  * *Class:* `kat_phenylephrineAuto`

* <span style="color:blue">**CWMP**</span>: **Suppresses pain** (0.2), increases HR slightly, decreases BP. Max Relief: 0.5. 4 pills per item.
  * *Duration:* 10 min | *Max Dose:* 6 | *Max Deviation:* 4 | *Action:* Head
  * *Class:* `kat_Painkiller`

* **Ammonium Carbonate:** Increases HR, **assists revival** (see Essential Values). 10 uses per item.
  * *Duration:* 30 sec | *Max Dose:* 10 | *Max Deviation:* 2 | *Conditions:* Unconscious | *Action:* Head
  * *Class:* `kat_Carbonate`

* **TXA:** See **Coagulation**
  * *Duration:* 2 min | *Max Dose:* 3 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_TXA`

* **EACA:** See **Coagulation**
  * *Duration:* 10 min | *Max Dose:* 10 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_EACA`

* <span style="color:blue">**Ketamine**</span>: **Suppresses pain** (0.8), increases HR, increases BP, causes chromatic aberration
  * *Duration:* 15 min | *Max Dose:* 2 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_ketamine`

* <span style="color:blue">**Fentanyl**</span>: **Suppresses pain** (1), decreases HR, decreases BP, causes chromatic aberration. Opioid Relief: 1.5
  * *Duration:* 15 min | *Max Dose:* 1 | *Max Deviation:* 1 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_fentanyl`

* <span style="color:blue">**Nalbuphine**</span>: **Suppresses pain** (0.6), decreases HR, decreases BP. Opioid Relief: 1.2
  * *Duration:* 15 min | *Max Dose:* 2 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_nalbuphine`

* **[C] Amiodarone:** Increases AED chances (by 8% - 20%), 33% chance to cause bradycardia
  * *Duration:* 2 min | *Max Dose:* 4 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_amiodarone`

* **[C, S]** <span style="color:blue">**Lidocaine**</span>: **Suppresses pain** (0.2), increases AED chances by 8%, suppresses pain during surgery and NPWT. Max Relief: 0.6
  * *Duration:* 2 min | *Max Dose:* 2 | *Max Deviation:* 4 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_lidocaine`

* **[C] Atropine:** Increases HR, treats bradycardia, cures chemical intoxication
  * *Duration:* 2 min | *Max Dose:* 4 | *Max Deviation:* 2 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_atropine`

* <span style="color:blue">**Pervitin**</span>: Multistage stamina drug, increases HR, increases BP, **suppresses pain** (0.5). After stamina boost is over, stamina drain will become greater than regular. Side effects: chromatic aberration and weapon sway. 8 uses per item.
  * *Duration:* 10 min | *Max Dose:* 2 | *Max Deviation:* 1 | *Action:* Head
  * *Class:* `kat_Pervitin`

* <span style="color:blue">**Penthrox**</span>: **Suppresses pain** (0.6), decreases HR, increases BP. Max Relief: 0.6
  * *Duration:* 5 min | *Max Dose:* 4 | *Max Deviation:* 2 | *Action:* Head
  * *Class:* `kat_Penthrox`

* **Caffeine:** Stamina drug, refills stamina, increases HR slightly. 15 uses per item.
  * *Duration:* 30 min | *Max Dose:* 4 | *Max Deviation:* 4 | *Action:* Head
  * *Class:* `kat_Caffeine`

* **Naloxone:** Treats morphine, fentanyl, and nalbuphine overdose in 1:1 ratio and clears all their effects
  * *Action:* Head
  * *Class:* `kat_naloxone`

* <span style="color:blue">**Bubble Wrap**</span>: **Suppresses pain** (0.05). 50 uses per item. Accessed via ACE menu (Ctrl + Win).
  * *Class:* `kat_Bubble_Wrap`

---

## 🪓 Advanced Surgical Tools & Sedation (S)

* **[S]** <span style="color:blue">**Etomidate**</span>: **Suppresses pain**, reduces HR, anesthetic
  * *Duration:* 45 sec | *Max Dose:* 10 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_etomidate`

* **[S] Lorazepam:** Reduces BP, sedates the patient, 33% chance to cause bradycardia
  * *Duration:* 1 min | *Max Dose:* 3 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_lorazepam`

* **[S] Flumazenil:** Removes the sedation
  * *Duration:* 1 min | *Max Dose:* 3 | *Conditions:* IV/IO inserted | *Action:* Limbs, Torso
  * *Class:* `kat_flumazenil`

* **[S] REBOA:** When placed, blocks bleeding to the legs and torso
  * *Action:* Limbs
  * *Class:* `kat_reboa`

* **[S] Ultrasound:** Allows placement of REBOAs and diagnosing of airway issues, breathing complications, and cardiac status. Also allows the Pericardial Tap action.
  * *Action:* Torso
  * *Class:* `kat_ultrasound`

* **[S] Bone Plate:** A metal piece screwed into a bone
  * *Action:* Limbs
  * *Class:* `kat_plate`

* **[S] Clamp:** Used for clamping a wound
  * *Action:* Limbs
  * *Class:* `kat_clamp`

* **[S] Dressing Vacuum (NPWT):** Personal Aid Kit equivalent that only affects a selected body part. Apply NPWT Dressing on the selected body part to bandage and stitch its wounds.
  * *Action:* Limbs
  * *Class:* `kat_vacuum`

* **[S] Retractor:** Used for exposing fractures
  * *Action:* Limbs
  * *Class:* `kat_retractor`

* **[S] Scalpel:** Used for performing incisions
  * *Action:* Limbs
  * *Class:* `kat_scalpel`

---

## 🎒 Tactical Field Equipment & Airway Management

### Airway & Breathing

* **Guedel Tube:** Prevents obstructions from happening.  
  * *Condition:* Unconscious, no occlusion | *Action:* Head
  * *Class:* `kat_guedel`
* **King LT:** Prevents obstructions and occlusions from happening.  
  * *Condition:* Unconscious, no occlusion | *Action:* Head
  * *Class:* `kat_larynx`
* **Accuvac:** A device used to remove occlusion from airways.  
  * *Condition:* Unconscious | *Action:* Head
  * *Class:* `kat_accuvac`
* **Manual Suction Pump:** A single-use device used to remove occlusion from airways.  
  * *Condition:* Unconscious | *Action:* Head
  * *Class:* `kat_suction`
* **BVM:** Patient not breathing: Slows down SpO2 loss. Patient breathing: Increases SpO2 restoring ratio. For better effect, Portable Oxygen Tank can be used.  
  * *Condition:* Airways are clear, unconscious | *Action:* Head
  * *Class:* `kat_BVM`
* **Pocket BVM:** Compact BVM version. Cannot utilize Portable Oxygen Tank.  
  * *Condition:* Airways are clear, unconscious | *Action:* Head
  * *Class:* `kat_pocketBVM`
* **Portable Oxygen Tank:** Comes in two volumes (150L or 300L). Used to provide oxygen for BVM. Oxygen can be refilled at medical facilities/vehicles (ACE interaction). Medical facilities/vehicles act as infinite oxygen sources for BVM actions, if performed by them.  
  * *Condition:* -
  * *Class:* `kat_oxygenTank_150` / `kat_oxygenTank_300`

### Trauma & Circulation Diagnostics

* **AAT Kit:** Used for needle decompression and fluid draining.  
  * *Condition:* - | *Action:* Torso
  * *Class:* `kat_aatKit`
* **NCD Kit:** Used for needle decompression.  
  * *Condition:* - | *Action:* Torso
  * *Class:* `kat_ncdKit`
* **Chest Seal:** Dressing used for treating pneumothorax.  
  * *Condition:* - | *Action:* Torso
  * *Class:* `kat_chestSeal`
* **Stethoscope:** Allows the diagnosis of thorax injuries.  
  * *Condition:* - | *Action:* Torso
  * *Class:* `kat_stethoscope`
* **Pulse Oximeter:** Monitors PR and SpO2.  
  * *Condition:* No active pulse oximeter on patient’s body | *Action:* Limbs
  * *Class:* `kat_Pulseoximeter`
* **Nasall Cannula:** Monitors ETCo2 and Respiratory Rate when a Vitals Monitor is attached.  
  * *Condition:* - | *Action:* Head
  * *Class:* `kat_nasal`
* **CoagSense:** See Coagulation.  
  * *Condition:* - | *Action:* Limbs
  * *Class:* `kat_coag_sense`

### Infusions, Access & Utility

* **16g IV:** Intravenous needle, used before administering fluids on limbs.  
  * *Condition:* - | *Action:* Limbs
  * *Class:* `kat_IV_16`
* **FAST IO:** Intraosseous needle, used before administering fluids on the torso.  
  * *Condition:* - | *Action:* Torso
  * *Class:* `kat_IO_FAST`
* **Field Blood Transfusion Kit:** Used to take blood from players/AI.  
  * *Condition:* Enough inventory space, donor has at least 3.6l of blood (default settings) | *Action:* Limbs, Torso
  * *Class:* `KAT_Empty_bloodIV_500` / `KAT_Empty_bloodIV_250`
* **AED:** Automated External Defibrillator, the X-series version has a vitals monitoring function.  
  * *Condition:* Unconscious, not undergoing CPR | *Action:* Torso
  * *Class:* `kat_AED` / `kat_X_AED`
* **Surgical Kit:** Used for wounds stitching.  
  * *Condition:* - | *Action:* Limb, Torso, Head
  * *Class:* `ACE_surgicalKit`
* **Personal Aid Kit:** Removes all injuries.  
  * *Condition:* Patient is stable
  * *Class:* `ACE_personalAidKit`
* **IV Stand:** Allows administering saline from a stand.
  * *Class:* `Land_IntravenStand_01_empty_F`
* **Stretcher:** Enables transporting wounded soldiers.
  * *Class:* `kat_CarryStretcherBag`
* **Helistretcher:** Enables transporting wounded soldiers by a helicopter.
  * *Class:* `kat_helistretcher`
