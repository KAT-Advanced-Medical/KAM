# **Kidney Function** {#kidney-function}

---

Checking Kidney function is done through the Examine Patient tab (“Check Breathing” action used on head). Kidney function is dependent on pH coefficient which mod mechanics measure in 0-1500 scale. Upon reaching 1500, effects coming from all states are reset. The script checking values is run every 20 seconds. Particular pH intervals result in one of the following states occurring:

* **Normal**  
  * pH ≥ 750  
  * 50 pH points restored each 20 seconds until pH 1500 is reached

* **Pressure**  
  * pH \> 0 ⋀ pH \< 750  
  * A script imitating a “medicine” is run  
    * 15 sec till max effect  
    * 20 minutes in the body  
    * HR increases by 30 BPM  
    * BP increases  
  * 25 pH points restored each 20 seconds until pH 750 (**Normal**) is reached

* **Fail**  
  * pH \= 0  
  * 50% chance of Kidney Function Arrest which leads to Cardiac Arrest  
  * no pH points are restored

* Restoring ideal pH level  
  * Dialysis in a medical vehicle  
  * Administering fluids until pH 1500 is reached (see **Fluids**)

| Check Breath Result | “pH” Value |
| :---: | :---: |
| Stink (harsh and metallic) | \<0 ; 250\) |
| Mild (slightly fruity) | \<250 ; 750\) |
| Good (ok) | \<750 ; 1500\> |
