class ACE_Medical_Advanced {
    class Treatment {
        class IV {
            class BloodIV;
            class BloodIV_500;
            class BloodIV_250;

            class BloodIV_O_RhP: BloodIV {
				volume = 1000;
                bloodType = "O+";
                compatibility[] = {"O+", "A+", "B+", "AB+"};
            };
            class BloodIV_O_RhN: BloodIV {
				volume = 1000;
                bloodType = "O-";
                compatibility[] = {"O+", "O-", "A+", "A-", "B+","B-", "AB+", "AB-"};
            };
            class BloodIV_A_RhP: BloodIV {
				volume = 1000;
                bloodType = "A+";
                compatibility[] = {"A+", "AB+"};
            };
            class BloodIV_A_RhN: BloodIV {
				volume = 1000;
                bloodType = "A-";
                compatibility[] = {"A+", "A-", "AB+", "AB-"};
            };
            class BloodIV_B_RhP: BloodIV {
				volume = 1000;
                bloodType = "B+";
                compatibility[] = {"B+", "AB+"};
            };
            class BloodIV_B_RhN: BloodIV {
				volume = 1000;
                bloodType = "B-";
                compatibility[] = {"B+","B-", "AB+", "AB-"};
            };
            class BloodIV_AB_RhP: BloodIV {
				volume = 1000;
                bloodType = "AB+";
                compatibility[] = {"AB+"};
            };
            class BloodIV_AB_RhN: BloodIV {
				volume = 1000;
                bloodType = "AB-";
                compatibility[] = {"AB+","AB-"};
            };

            class BloodIV_O_500_RhP: BloodIV_500 {
				volume = 500;
                bloodType = "O+";
                compatibility[] = {"O+", "A+", "B+", "AB+"};
            };
            class BloodIV_O_500_RhN: BloodIV_500 {
				volume = 500;
                bloodType = "O-";
                compatibility[] = {"O+", "O-", "A+", "A-", "B+","B-", "AB+", "AB-"};
            };
            class BloodIV_A_500_RhP: BloodIV_500 {
				volume = 500;
                bloodType = "A+";
                compatibility[] = {"A+", "AB+"};
            };
             class BloodIV_A_500_RhN: BloodIV_500 {
				volume = 500;
                bloodType = "A-";
                compatibility[] = {"A+", "A-", "AB+", "AB-"};
            };
            class BloodIV_B_500_RhP: BloodIV_500 {
				volume = 500;
                bloodType = "B+";
                compatibility[] = {"B+", "AB+"};
            };
            class BloodIV_B_500_RhN: BloodIV_500 {
				volume = 500;
                bloodType = "B-";
                compatibility[] = {"B+","B-", "AB+", "AB-"};
            };
            class BloodIV_AB_500_RhP: BloodIV_500 {
				volume = 500;
                bloodType = "AB+";
                compatibility[] = {"AB+"};
            };
            class BloodIV_AB_500_RhN: BloodIV_500 {
				volume = 500;
                bloodType = "AB-";
                compatibility[] = {"AB+","AB-"};
            };

            class BloodIV_O_250_RhP: BloodIV_250 {
				volume = 250;
                bloodType = "O+";
                compatibility[] = {"O+", "A+", "B+", "AB+"};
            };
            class BloodIV_O_250_RhN: BloodIV_250 {
				volume = 250;
                bloodType = "O-";
                compatibility[] = {"O+", "O-", "A+", "A-", "B+","B-", "AB+", "AB-"};
            };
            class BloodIV_A_250_RhP: BloodIV_250 {
				volume = 250;
                bloodType = "A+";
                compatibility[] = {"A+", "AB+"};
            };
            class BloodIV_A_250_RhN: BloodIV_250 {
				volume = 250;
                bloodType = "A-";
                compatibility[] = {"A+", "A-", "AB+", "AB-"};
            };
            class BloodIV_B_250_RhP: BloodIV_250 {
				volume = 250;
                bloodType = "B+";
                compatibility[] = {"B+", "AB+"};
            };
            class BloodIV_B_250_RhN: BloodIV_250 {
				volume = 250;
                bloodType = "B-";
                compatibility[] = {"B+","B-", "AB+", "AB-"};
            };
            class BloodIV_AB_250_RhP: BloodIV_250 {
				volume = 250;
                bloodType = "AB+";
                compatibility[] = {"AB+"};
            };
            class BloodIV_AB_250_RhN: BloodIV_250 {
				volume = 250;
                bloodType = "AB-";
                compatibility[] = {"AB+","AB-"};
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
                // copied from ACE. Just a reminder
                painReduce = 1.2; // increased from 0.7
                timeInSystem = 120;
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
};
