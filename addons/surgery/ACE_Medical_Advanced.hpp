class ACE_Medical_Advanced {
    class Treatment {
        class Medication {
            class Atropine {
                //change for effect from Atropine. Anomalie here, if you give more it will push your heart rate
                hrIncreaseLow[] = {0, 0, 0};
                hrIncreaseNormal[] = {0, 0, 0};
                hrIncreaseHigh[] = {0, 0, 0};
            };
            class Painkillers {
                // copied from ACE. Just a reminder
                painReduce = 1.1; // increased from 0.7
                timeInSystem = 120;
                maxDose = 10;
                inCompatableMedication[] = {};
                // will push your blood pressure and leave your heart rate
                // The viscosity of a fluid is a measure of its resistance to gradual deformation by shear stress or tensile stress. For liquids, it corresponds to the informal concept of "thickness".
                // This value will increase/decrease the viscoty of the blood with the percentage given. Where 100 = max. Using the minus will decrease viscosity
                viscosityChange = 2;
                // item class name
                itemClassName = "kat_PainkillerItem";
            };
            class Carbonate {
                // copied from ACE. Just a reminder
                painReduce = 0; // increased from 0.7
                timeInSystem = 120;
                maxDose = 10;
                inCompatableMedication[] = {};
                // will push your blood pressure and leave your heart rate
                // The viscosity of a fluid is a measure of its resistance to gradual deformation by shear stress or tensile stress. For liquids, it corresponds to the informal concept of "thickness".
                // This value will increase/decrease the viscoty of the blood with the percentage given. Where 100 = max. Using the minus will decrease viscosity
                viscosityChange = 2;
                // item class name
                itemClassName = "kat_CarbonateItem";
            };
        };
    };
};
