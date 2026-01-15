class ACE_Medical_Treatment {
    class IV {
        volume = 1000;
        ratio[] = {};
        type = "Blood";
        rateCoef = 1;
        //Platelets per ML
        platelets = 0;
        // How much does the pain get reduced?
        painReduce = 0;
        // How much will the heart rate be increased when the HR is low (below 55)? {minIncrease, maxIncrease}
        hrIncreaseLow[] = {0, 0};    // _heartRate < 55
        hrIncreaseNormal[] = {0, 0}; // 55 <= _heartRate <= 110
        hrIncreaseHigh[] = {0, 0};   // 110 < _heartRate

        // How long until this medication has disappeared
        timeInSystem = 120;
        // How long until the maximum effect is reached
        timeTillMaxEffect = 30;
        // How many of this type of medication can be in the system before the patient overdoses?
        maxDose = 4;
        // The number of doses over maxDose where there is a chance to overdose.
        // Example with maxDose = 4 and maxDoseDeviation = 2: Dose 4: Safe | Dose 5 and 6: Possible overdose | Dose 7: Guaranteed overdose
        maxDoseDeviation = 2;
        // The dose of the medication, to allow for different dose amounts of the same medication
        dose = 2.5;
        // Function to execute upon overdose. Arguments passed to call back are 0: unit <OBJECT>, 1: medicationClassName <STRING>
        onOverDose = "";
        // The viscosity of a fluid is a measure of its resistance to gradual deformation by shear stress or tensile stress. For liquids, it corresponds to the informal concept of "thickness". This value will increase/decrease the viscoty of the blood with the percentage given. Where 100 = max. Using the minus will decrease viscosity
        viscosityChange = 0;
        // How much does the medication constrict/dilate the patient's blood vessels?
        alphaFactor = 0;
        // Max amount of pain the medication can remove
        maxRelief = 0;
        // Reduction of damage from wounds
        opioidRelief = 0;
        // How strong should opioid Respiratory Depression be be
        opioidDepression = 0;
        // How strong should opioid visuals be
        opioidEffect = 0;
        //multiplier to respiratory rate
        respiratoryRate = 0;
        //multiplier to contractility
        contractility = 0;
        //multiplier to nausea
        nauseaMult = 0;
        //is this drug a sedation drug
        sedation = "false";
        paralysis = "false";
        ph = 0;
        ca = 0;


        incompatibleMedication[] = {};

        class BloodIV {
            volume = 1000;
            ratio[] = {"Plasma", 1};
            rateCoef = 0.6;
            platelets = 0.025;
            ph = -0.010;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            ca = -0.012;
        };
        class BloodIV_500: BloodIV {
            volume = 500;
        };
        class BloodIV_250: BloodIV {
            volume = 250;
        };
        class PlasmaIV: BloodIV {
            volume = 1000;
            ratio[] = {"Blood", 1};
            type = "Plasma";
            rateCoef = 1;
            platelets = 0.25;
            ca = 0.006;
            ph = -0.006;
        };
        class PlasmaIV_500: PlasmaIV {
            volume = 500;
        };
        class PlasmaIV_250: PlasmaIV {
            volume = 250;
        };
        class SalineIV: BloodIV {
            volume = 1000;
            type = "Saline";
            ratio[] = {};
            rateCoef = 1.4;
            platelets = 0;
            ph = 0.018;
            ca = 0.004;
        };
        class SalineIV_500: SalineIV {
            volume = 500;
        };
        class SalineIV_250: SalineIV {
            volume = 250;
        };
        class SalineIV100: SalineIV {
            volume = 100;
        };
        class BloodIV_O: BloodIV {
            volume = 1000;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
        };
        class BloodIV_O_N: BloodIV {
            volume = 1000;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
        };
        class BloodIV_A: BloodIV {
            volume = 1000;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
        };
        class BloodIV_A_N: BloodIV {
            volume = 1000;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
        };
        class BloodIV_B: BloodIV {
            volume = 1000;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
        };
        class BloodIV_B_N: BloodIV {
            volume = 1000;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
        };
        class BloodIV_AB: BloodIV {
            volume = 1000;
            bloodType = "AB";
            compatibility[] = {"AB"};
        };
        class BloodIV_AB_N: BloodIV {
            volume = 1000;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
        };

        class BloodIV_O_500: BloodIV_500 {
            volume = 500;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
        };
        class BloodIV_O_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
        };
        class BloodIV_A_500: BloodIV_500 {
            volume = 500;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
        };
            class BloodIV_A_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
        };
        class BloodIV_B_500: BloodIV_500 {
            volume = 500;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
        };
        class BloodIV_B_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
        };
        class BloodIV_AB_500: BloodIV_500 {
            volume = 500;
            bloodType = "AB";
            compatibility[] = {"AB"};
        };
        class BloodIV_AB_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
        };

        class BloodIV_O_250: BloodIV_250 {
            volume = 250;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
        };
        class BloodIV_O_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
        };
        class BloodIV_A_250: BloodIV_250 {
            volume = 250;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
        };
        class BloodIV_A_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
        };
        class BloodIV_B_250: BloodIV_250 {
            volume = 250;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
        };
        class BloodIV_B_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
        };
        class BloodIV_AB_250: BloodIV_250 {
            volume = 250;
            bloodType = "AB";
            compatibility[] = {"AB"};
        };
        class BloodIV_AB_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
        };
        class FBTKBloodIV_500: BloodIV_500 {
            volume = 500;
            ratio[] = {"Blood", 1};
            rateCoef = 0.6;
            platelets = 0.1;
            ph = 0;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            ca = 0;
        };
        class FBTKBloodIV_O_500: FBTKBloodIV_500 {
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
        };
        class FBTKBloodIV_O_N_500: FBTKBloodIV_500 {
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_A_500: FBTKBloodIV_500 {
            bloodType = "A";
            compatibility[] = {"A", "AB"};
        };
        class FBTKBloodIV_A_N_500: FBTKBloodIV_500 {
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_B_500: FBTKBloodIV_500 {
            bloodType = "B";
            compatibility[] = {"B", "AB"};
        };
        class FBTKBloodIV_B_N_500: FBTKBloodIV_500 {
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_AB_500: FBTKBloodIV_500 {
            bloodType = "AB";
            compatibility[] = {"AB"};
        };
        class FBTKBloodIV_AB_N_500: FBTKBloodIV_500 {
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
        };
        class FBTKBloodIV_250: BloodIV_250 {
            volume = 500;
            ratio[] = {"Blood", 1};
            rateCoef = 0.6;
            platelets = 0.1;
            ph = 0;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            ca = 0;
        };
        class FBTKBloodIV_O_250: FBTKBloodIV_250 {
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
        };
        class FBTKBloodIV_O_N_250: FBTKBloodIV_250 {
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_A_250: FBTKBloodIV_250 {
            bloodType = "A";
            compatibility[] = {"A", "AB"};
        };
        class FBTKBloodIV_A_N_250: FBTKBloodIV_250 {
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_B_250: FBTKBloodIV_250 {
            bloodType = "B";
            compatibility[] = {"B", "AB"};
        };
        class FBTKBloodIV_B_N_250: FBTKBloodIV_250 {
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
        };
        class FBTKBloodIV_AB_250: FBTKBloodIV_250 {
            bloodType = "AB";
            compatibility[] = {"AB"};
        };
        class FBTKBloodIV_AB_N_250: FBTKBloodIV_250 {
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
        };
        class RingersLactateIV: SalineIV {
            volume = 1000;
            rateCoef = 1.4;
            type = "Ringers Lactate";
            platelets = 0;
            ph = 0.012;
            ca = -0.006;
        };
        class RingersLactateIV_500: RingersLactateIV {
            volume = 500;
            rateCoef = 1.4;
            type = "Ringers Lactate";
        };
        class RingersLactateIV_250: RingersLactateIV {
            volume = 250;
            rateCoef = 1.4;
            type = "Ringers Lactate";
        };
        class PackedRBCIV_500: BloodIV {
            volume = 500;
            rateCoef = 0.4;
            type = "PackedRBC";
            platelets = 0.1;
            ca = -0.018;
            ph = 0.028;
        };
        class PackedRBCIV_250: PackedRBCIV_500 {
            volume = 250;
            rateCoef = 0.4;
            type = "PackedRBC";
        };
        class Platelets_100: BloodIV {
            volume = 100;
            rateCoef = 0.8;
            type = "Platelets";
            platelets = 2;
            ca = 0.002;
            ph = -0.006;
        };
        class KAT_DrawBlood500: BloodIV {
            volume = 1;
            rateCoef = 1.2;
            type = "FBTK_500";
            platelets = 0;
            ca = 0;
            ph = 0;
        };
        class KAT_DrawBlood250: BloodIV {
            volume = 1;
            rateCoef = 1.2;
            type = "FBTK_250";
            platelets = 0;
            ca = 0;
            ph = 0;
        };
        class Morphine_IVInfusion: SalineIV_250 {
            painReduce = 0.2;
            hrIncreaseLow[] = {-1, -3};
            hrIncreaseNormal[] = {-1, -3};
            hrIncreaseHigh[] = {-1, -4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            viscosityChange = -3;
            opioidRelief = 1.05;
            respiratoryRate = -0.05;
            volume = 250;
            rateCoef = 1.4;
            type = "Morphine_IVInfusion";
        };
        class Epinephrine_IVInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {3, 5};
            hrIncreaseNormal[] = {3, 6};
            hrIncreaseHigh[] = {3, 7};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            alphaFactor = -0.05;
            volume = 250;
            rateCoef = 1.4;
            contractility = 0.1;
            type = "Epinephrine_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Etomidate_IVInfusion: SalineIV_250 {
            painReduce = 0.2;
            hrIncreaseLow[] = {-1, -3};
            hrIncreaseNormal[] = {-1, -3};
            hrIncreaseHigh[] = {-1, -4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            viscosityChange = 0;
            volume = 250;
            rateCoef = 1.4;
            type = "Etomidate_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Doxapram_IVInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            respiratoryRate = 0.1;
            opioidDepression = -0.05;
            volume = 250;
            rateCoef = 1.4;
            type = "Doxapram_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Nitroglycerin_IVInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            volume = 250;
            rateCoef = 1.4;
            alphaFactor = 0.05;
            viscosityChange = -2;
            contractility = -0.05;
            type = "Nitroglycerin_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Norepinephrine_IVInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            volume = 250;
            rateCoef = 1.4;
            alphaFactor = -0.1;
            viscosityChange = 4;
            type = "Norepinephrine_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Morphine_IVInfusion100: SalineIV_250 {
            painReduce = 0.2;
            hrIncreaseLow[] = {-1, -3};
            hrIncreaseNormal[] = {-1, -3};
            hrIncreaseHigh[] = {-1, -4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            viscosityChange = -3;
            opioidRelief = 1.05;
            respiratoryRate = -0.05;
            volume = 100;
            rateCoef = 1.4;
            type = "Morphine_IVInfusion";
        };
        class Epinephrine_IVInfusion100: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {3, 5};
            hrIncreaseNormal[] = {3, 6};
            hrIncreaseHigh[] = {3, 7};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            alphaFactor = -0.05;
            volume = 100;
            rateCoef = 1.4;
            contractility = 0.1;
            type = "Epinephrine_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Etomidate_IVInfusion100: SalineIV_250 {
            painReduce = 0.2;
            hrIncreaseLow[] = {-1, -3};
            hrIncreaseNormal[] = {-1, -3};
            hrIncreaseHigh[] = {-1, -4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            viscosityChange = 0;
            volume = 100;
            rateCoef = 1.4;
            type = "Etomidate_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Doxapram_IVInfusion100: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            respiratoryRate = 0.1;
            opioidDepression = -0.05;
            volume = 100;
            rateCoef = 1.4;
            type = "Doxapram_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Nitroglycerin_IVInfusion100: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            volume = 100;
            rateCoef = 1.4;
            alphaFactor = 0.1;
            viscosityChange = -2;
            contractility = -0.05;
            type = "Nitroglycerin_IVInfusion";
            incompatibleMedication[] = {};
        };
        class Norepinephrine_IVInfusion100: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {1, 3};
            hrIncreaseNormal[] = {1, 3};
            hrIncreaseHigh[] = {1, 4};
            timeInSystem = 3;
            timeTillMaxEffect = 1;
            dose = 2.5;
            volume = 100;
            rateCoef = 1.4;
            alphaFactor = -0.1;
            viscosityChange = 4;
            type = "Norepinephrine_IVInfusion";
            incompatibleMedication[] = {};
        };
        class HypertonicSalineIV_500: SalineIV {
            volume = 500;
            type = "Hypertonic Saline";
            ratio[] = {};
            rateCoef = 1.3;
            platelets = 0;
            ph = 0.035;
            ca = 0.012;
        };
        class HypertonicSalineIV_250: HypertonicSalineIV_500 {
            volume = 250;
        };
        class HypertonicSalineIV_100: HypertonicSalineIV_500 {
            volume = 100;
        };
        class HextendIV: PlasmaIV {
            volume = 1000;
            type = "Hextend";
            ratio[] = {};
            rateCoef = 1.3;
            platelets = 0;
            ph = 0.02;
            ca = 0.01;
        };
        class HextendIV_500: HextendIV {
            volume = 500;
        };
        class HextendIV_250: HextendIV {
            volume = 250;
        };
    };
};
