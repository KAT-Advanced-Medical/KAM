# **Fluids & Blood Compatibility** {#fluids-and-blood-compatibility}

---

Administering fluids is essential for restoring lost volume, but different fluids have distinct physiological impacts on **Kidney Function (Acidosis)** and **Coagulation (Clotting Factors)**.

## 🩺 Fluid Properties & Effects

When a fluid bag is successfully administered, it updates the patient's acidosis index (internally `externalPh`, where `0` is ideal and `3000` is critical failure) and adds coagulation factors to their clotting pool.

| Fluid Type | Bag Size | Acidosis Index Change | Coagulation Factors Added |
| :--- | :---: | :---: | :---: |
| **Saline** | 1000ml | +750 (worsens acidosis) | +0 |
| | 500ml | +350 (worsens acidosis) | +0 |
| | 250ml | +150 (worsens acidosis) | +0 |
| **Plasma** | 1000ml | -500 (improves acidosis) | +20 |
| | 500ml | -250 (improves acidosis) | +10 |
| | 250ml | -100 (improves acidosis) | +5 |
| **Blood (Generic)** | 1000ml | -800 (improves acidosis) | +16 |
| | 500ml | -400 (improves acidosis) | +8 |
| | 250ml | -200 (improves acidosis) | +4 |
| **Blood (Typed)** | 1000ml | -800 (improves acidosis) | +12 |
| | 500ml | -400 (improves acidosis) | +8 |
| | 250ml | -200 (improves acidosis) | +4 |

*Note: For more information about the acidosis index, see [Kidney Function](01_kidneys.md).*

---

## 🩸 Blood Group Compatibility

Transfusing typed blood requires ensuring compatibility between the donor blood bag and the recipient patient. 

### Rh Factor Rules
*   **Rh Negative (-)** blood can be given to **both Rh Negative (-) and Rh Positive (+)** recipients of compatible types.
*   **Rh Positive (+)** blood can **only** be given to **Rh Positive (+)** recipients.

### Compatibility Matrix

| Recipient Type | Compatible Blood Types |
| :--- | :--- |
| **O-** | O- |
| **O+** | O-, O+ |
| **A-** | O-, A- |
| **A+** | O-, O+, A-, A+ |
| **B-** | O-, B- |
| **B+** | O-, O+, B-, B+ |
| **AB-** | O-, A-, B-, AB- |
| **AB+** | *Universal Recipient* (All blood types compatible) |

*   **Universal Donor:** **O-** blood can be safely transfused to any recipient type.
*   **Universal Recipient:** Patients with **AB+** blood can receive any blood type.

---

## ⚠️ Blood Poisoning

Transfusing an incompatible blood type triggers a severe physiological reaction.

*   **Onset:** An incompatible transfusion immediately inflicts the **"BloodPoisoning"** condition in the patient's system.
*   **Consequence:** If the poisoning is not resolved, the patient will suffer **immediate Cardiac Arrest after 150 seconds (2.5 minutes)**.
*   **Treatment:** To cure blood poisoning, administer a **CWMP (Combat Wound Medication Pack)**. This will safely remove the poisoning condition from the patient's system.
