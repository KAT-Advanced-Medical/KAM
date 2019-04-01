class ACE_Medical_Treatment {
        class IV {
            class BloodIV;
            class BloodIV_500;
            class BloodIV_250;

            class BloodIV_O: BloodIV {
                bloodType = "O";
                compatibility[] = {"O", "A", "B", "AB"};
            };
            class BloodIV_A: BloodIV {
                bloodType = "A";
                compatibility[] = {"A", "AB"};
            };
            class BloodIV_B: BloodIV {
                bloodType = "B";
                compatibility[] = {"B", "AB"};
            };
            class BloodIV_AB: BloodIV {
                bloodType = "AB";
                compatibility[] = {"AB"};
            };

            class BloodIV_O_500: BloodIV_500 {
                bloodType = "O";
                compatibility[] = {"O", "A", "B", "AB"};
            };
            class BloodIV_A_500: BloodIV_500 {
                bloodType = "A";
                compatibility[] = {"A", "AB"};
            };
            class BloodIV_B_500: BloodIV_500 {
                bloodType = "B";
                compatibility[] = {"B", "AB"};
            };
            class BloodIV_AB_500: BloodIV_500 {
                bloodType = "AB";
                compatibility[] = {"AB"};
            };

            class BloodIV_O_250: BloodIV_250 {
                bloodType = "O";
                compatibility[] = {"O", "A", "B", "AB"};
            };
            class BloodIV_A_250: BloodIV_250 {
                bloodType = "A";
                compatibility[] = {"A", "AB"};
            };
            class BloodIV_B_250: BloodIV_250 {
                bloodType = "B";
                compatibility[] = {"B", "AB"};
            };
            class BloodIV_AB_250: BloodIV_250 {
                bloodType = "AB";
                compatibility[] = {"AB"};
            };
        };
        class Medication {
            class Atropine {
                //change for effect from Atropine. Anomalie here, if you give more it will push your heart rate
                hrIncreaseLow[] = {15, 20, 20};
                hrIncreaseNormal[] = {10, 15, 15};
                hrIncreaseHigh[] = {5, 10, 10};
            };
            class Painkillers {
                painReduce = 1.2; // increased from 0.7
                timeInSystem = 120; // reduced from 600
                maxDose = 10;
                inCompatableMedication[] = {};
                // will push your blood pressure and leave your heart rate
                // The viscosity of a fluid is a measure of its resistance to gradual deformation by shear stress or tensile stress. For liquids, it corresponds to the informal concept of "thickness".
                // This value will increase/decrease the viscoty of the blood with the percentage given. Where 100 = max. Using the minus will decrease viscosity
                viscosityChange = 5;
                // item class name
                itemClassName = "kat_PainkillerItem";
            };
        };
};
