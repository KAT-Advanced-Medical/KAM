## **Coagulation**

Coagulation is a feature of this mod that partially replicates the bodies natural ability to heal itself and stop bleeding from open wounds. It does so with coagulation factors, which act as automatic bandages.  
If you are hit and an open wound is caused, a script will start to run and bandage that wound, removing factors from your pool of factors based on the size of the wound, (Small=1, Medium=2, Large=4)  
You can regain factors one of two ways  
	 

1. Replenishment via Plasma or Blood Transfusion, which can fully refill your factor pool and potentially overfill it. Or  
2. Natural Regeneration, which is limited in how many factors can be regenerated and is slower

If you have more factors then what the normal amount is, factors will slowly degenerate and be removed from the pool until a normal amount is reached 

---

### **TXA**

If coagulation is disabled, TXA applies the equivalent of a packing bandage every 6 seconds to all parts of the body for 120 seconds.  
If coagulation is enabled, pushing TXA doubles the amount of factors naturally regained if the amount of factors in system is below normal, and causes the clotting system to apply a TXA clot instead of “unstable clot” on bleeding wounds \- TXA does not cause wound clotting on its own but makes the clots stronger.  
TXA clots have a 30% chance of falling off, starting after 5 minutes have elapsed to a maximum of 10 minutes

---

### **EACA**

If coagulation is disabled, EACA Stitches a wound every 6 seconds until all wounds are stitched unless the patient dies  
If coagulation is enabled, pushing EACA doubles the amount of factors naturally regained if the amount of factors in system is below normal, and causes the clotting system to apply a TXA clot instead of “unstable clot” on bleeding wounds,  
If TXA is in the system at the same time as EACA, EACA will cause the coagulation system to apply EACA clots.  
EACA clots have a 10% chance of falling off, starting after 10 minutes have elapsed to a maximum of 20 minutes

---

### **CoagSense**

CoagSense is a device that measures the ability of your blood to clot, and will give a reading based on how many clotting factors are left in the pool in relation to the normal amount  
There are 5 levels:

* Very low INR: 50% or less of the default amount of factors,  
* Slightly below normal INR: 50% \- 75% of the default amount of factors,  
* Normal INR: 75% \- 125% of the default amount of factors,  
* Slightly Above normal INR: 125% \- 150% of the default amount of factors,   
* Very high INR: 150% or more of the default amount of factors,

Each is an indication on how many factors are left, in a percentage
