# Blood Loss

All wounds bleed. The rate at which a particular wound bleeds is dependent on the players heartrate and perfusion rate. Characters start with 6 liters of blood in their body. As it decreases, you can see different status effects.

| Blood Level (L) | Status Effect                |
| --------------- | ---------------------------- |
| 5.9 - 5.1       | Lost Some Blood              |
| 5.1 - 4.2       | Lost a Lot of Blood          |
| 4.2 - 3.6       | Lost a Large Amount of Blood |
| 3.6 - 3.0       | Lost a Fatal Amount of Blood |

>[!NOTE]
>By default, if the player has less than 3L of blood in their body, they will die.

If a player loses a fatal amount of blood, they will go into [Cardiac Arrest](/Cardiac/Cardiac-Arrest.md).

## Coagulation

In KAM, wounds can close on their own if coagulation is enabled. Every 8 seconds, KAM checks the players HR and # of wounds. If a player has a HR of 20 or more at least one wound, and at least one clotting factor, a random wound will receive the "Unstable Clot" bandage and use up one clotting factor. A player starts with 10 clotting factors, though that number can be increased by administering certain [IV Fluids](/Hemorrhaging/IV-Fluids.md). You can fortify clots from "Unstable Clot" to "Packing Bandage" using [TXA](/Pharmacy/IV-Medication.md#txa).