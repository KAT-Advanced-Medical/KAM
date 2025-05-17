class ACE_ADDON(Medical_Treatment) {
    class Medication {
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
        dose = 1;
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

        class Epinephrine {
            painReduce = 0;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {5, 25};
            hrIncreaseHigh[] = {5, 20};
            timeInSystem = 120;
            timeTillMaxEffect = 10;
            dose = 1;
            maxDose = 6;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            alphaFactor = -0.15;
            onOverDose = "";
        };
        class EpinephrineIV {
            painReduce = 0;
            hrIncreaseLow[] = {5, 30};
            hrIncreaseNormal[] = {10, 30};
            hrIncreaseHigh[] = {5, 30};
            timeInSystem = 300;
            timeTillMaxEffect = 10;
            dose = 1;
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            alphaFactor = -0.3;
            onOverDose = "";
        };
        class Morphine {
            painReduce = 0.6;
            hrIncreaseLow[] = {-2, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 60;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            viscosityChange = -0;
        };
        class MorphineIV {
            painReduce = 0.8;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -20};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 900;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            viscosityChange = -15;
            opioidRelief = 1.3;
        };
        class Adenosine {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 180;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            viscosityChange = 0;
        };
        class AdenosineIV {
            painReduce = 0;
            hrIncreaseLow[] = {-7, -10};
            hrIncreaseNormal[] = {-15, -20};
            hrIncreaseHigh[] = {-15, -25};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            viscosityChange = 0;
        };
        class Carbonate {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {15, 20};
            timeInSystem = 30;
            timeTillMaxEffect = 2;
            dose = 1;
            maxDose = 10;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class TXA {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 240;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 3;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
         class TXAAuto {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 90;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 3;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Norepinephrine {
            painReduce = 0;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 15};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 12;
            incompatibleMedication[] = {};
            viscosityChange = 25;
            alphaFactor = -0.3;
            onOverDose = "";
        };
        class Phenylephrine {
            painReduce = 0;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 6;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            viscosityChange = 50;
            alphaFactor = -0.5;
            onOverDose = "";
        };
        class PhenylephrineAuto {
            painReduce = 0;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 6;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            viscosityChange = 25;
            alphaFactor = -0.3;
        };
        class Nitroglycerin {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {10, 15};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 6;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            viscosityChange = -25;
            alphaFactor = 0.3;
            onOverDose = "";
        };
        class Fentanyl {
            painReduce = 1;
            hrIncreaseLow[] = {-10, -5};
            hrIncreaseNormal[] = {-15, -10};
            hrIncreaseHigh[] = {-20, -10};
            timeInSystem = 900;
            timeTillMaxEffect = 20;
            dose = 1;
            maxDose = 1;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            viscosityChange = -10;
            onOverDose = "";
            opioidRelief = 0.2;
            opioidEffect = 0.18;
            opioidDepression = 0.18;
        };
        class Ketamine {
            painReduce = 0.8;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {10, 15};
            timeInSystem = 900;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            viscosityChange = 10;
            onOverDose = "";
            opioidEffect = 0.17;
            opioidDepression = 0.17;
        };
        class Nalbuphine {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 900;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            viscosityChange = -5;
            onOverDose = "";
            opioidRelief = 0.1;
        };
        class CWMP {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 360;
            timeTillMaxEffect = 45;
            dose = 1;
            maxDose = 6;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            viscosityChange = -5;
            onOverDose = "";
            maxRelief = 0.4;
        };
        class PainKillers {
            painReduce = 0.35;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -17};
            timeInSystem = 420;
            timeTillMaxEffect = 60;
            maxDose = 5;
            incompatibleMedication[] = {};
            onOverDose = "";
            maxRelief = 0.5;
        };
        class Atropine {
            painReduce = 0;
            hrIncreaseLow[] = {20, 40};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 4;
            incompatibleMedication[]= {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Amiodarone {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0, 0};
            hrIncreaseNormal[] = {0, 0, 0};
            hrIncreaseHigh[] = {0, 0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 4;
            incompatibleMedication[]= {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Lidocaine {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, 0, 0};
            hrIncreaseNormal[] = {0, 0, 0};
            hrIncreaseHigh[] = {0, 0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 4;
            incompatibleMedication[]= {};
            onOverDose = "";
            maxRelief = 0.6;
        };
        class EACA {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 600;
            timeTillMaxEffect = 60;
            dose = 1;
            maxDose = 10;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Etomidate {
            painReduce = 0.4;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-15, -20};
            hrIncreaseHigh[] = {-20, -30};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 10;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Flumazenil {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 3;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Lorazepam {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 3;
            incompatibleMedication[] = {};
            viscosityChange = -15;
            onOverDose = "";
        };
        class Pervitin {
            painReduce = 0.5;
            hrIncreaseLow[] = {15, 25};
            hrIncreaseNormal[] = {15, 30};
            hrIncreaseHigh[] = {15, 25};
            timeInSystem = 600;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 2;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
            opioidEffect = 0.2;
        };
        class Caffeine {
            painReduce = 0;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 1800;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 4;
            maxDoseDeviation = 4;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
            respiratoryRate = 0.1;
        };
        class BubbleWrap {
            painReduce = 0.05;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 300;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 0;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class Penthrox {
            painReduce = 0.6;
            hrIncreaseLow[] = {-0, -5};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 20;
            dose = 1;
            maxDose = 4;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
            maxRelief = 0.6;
        };
        class syringe_txa_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 120;
            timeTillMaxEffect = 5;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_txa_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -12};
            hrIncreaseNormal[] = {-4, -12};
            hrIncreaseHigh[] = {-4, -12};
            timeInSystem = 240;
            timeTillMaxEffect = 5;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_txa_10ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 120;
            timeTillMaxEffect = 20;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_txa_10ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -12};
            hrIncreaseNormal[] = {-4, -12};
            hrIncreaseHigh[] = {-4, -12};
            timeInSystem = 180;
            timeTillMaxEffect = 20;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_eaca_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 100;
            timeTillMaxEffect = 35;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_eaca_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -12};
            hrIncreaseNormal[] = {-4, -12};
            hrIncreaseHigh[] = {-4, -12};
            timeInSystem = 300;
            timeTillMaxEffect = 35;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_epinephrineIV_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {10, 20};
            hrIncreaseNormal[] = {10, 30};
            hrIncreaseHigh[] = {15, 30};
            timeInSystem = 120;
            timeTillMaxEffect = 10;
            dose = 1;
            alphaFactor = -0.2;
        };
        class syringe_epinephrineIV_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {10, 20};
            hrIncreaseNormal[] = {10, 35};
            hrIncreaseHigh[] = {15, 30};
            timeInSystem = 180;
            timeTillMaxEffect = 10;
            dose = 3;
            alphaFactor = -0.4;
        };
        class syringe_norepinephrine_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {-5, 5};
            hrIncreaseNormal[] = {-10, 5};
            hrIncreaseHigh[] = {-10, 5};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            viscosityChange = 15;
            dose = 1;
            alphaFactor = -0.2;
        };
        class syringe_norepinephrine_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-10, 0};
            hrIncreaseNormal[] = {-15, 5};
            hrIncreaseHigh[] = {-15, 5};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 3;
            viscosityChange = 25;
            alphaFactor = -0.4;
        };
        class syringe_phenylephrine_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {2, 10};
            hrIncreaseNormal[] = {2, 15};
            hrIncreaseHigh[] = {2, 10};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            viscosityChange = 35;
            dose = 1;
            alphaFactor = -0.4;
        };
        class syringe_phenylephrine_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {2, 15};
            hrIncreaseNormal[] = {2, 20};
            hrIncreaseHigh[] = {2, 15};
            timeInSystem = 300;
            timeTillMaxEffect = 15;
            viscosityChange = 50;
            dose = 3;
            alphaFactor = -0.7;
        };
        class syringe_nitroglycerin_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {10, 15};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            viscosityChange = -25;
            dose = 1;
            alphaFactor = 0.3;
        };
        class syringe_nitroglycerin_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 15};
            hrIncreaseNormal[] = {5, 20};
            hrIncreaseHigh[] = {5, 20};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 3;
            viscosityChange = -35;
            alphaFactor = 0.5;
        };
        class syringe_fentanyl_5ml_1 {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 900;
            timeTillMaxEffect = 20;
            dose = 1;
            viscosityChange = -10;
            opioidRelief = 1.2;
            opioidEffect = 0.17;
            opioidDepression = 0.17;
            respiratoryRate = -0.2;
        };
        class syringe_fentanyl_5ml_3 {
            painReduce = 1;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-10, -20};
            hrIncreaseHigh[] = {-10, -20};
            timeInSystem = 900;
            timeTillMaxEffect = 20;
            dose = 3;
            viscosityChange = -10;
            opioidRelief = 1.5;
            opioidEffect = 0.25;
            opioidDepression = 0.25;
            respiratoryRate = -0.3;
        };
        class syringe_ketamine_5ml_1 {
            painReduce = 0.5;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 25};
            timeInSystem = 600;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = 10;
            opioidEffect = 0.18;
            opioidDepression = 0.18;
            respiratoryRate = 0.2;
        };
        class syringe_ketamine_5ml_3 {
            painReduce = 0.8;
            hrIncreaseLow[] = {15, 30};
            hrIncreaseNormal[] = {15, 35};
            hrIncreaseHigh[] = {15, 35};
            timeInSystem = 900;
            timeTillMaxEffect = 15;
            dose = 3;
            viscosityChange = 10;
            onOverDose = "";
            opioidEffect = 0.21;
            opioidDepression = 0.21;
            respiratoryRate = 0.3;
        };
        class syringe_nalbuphine_5ml_1 {
            painReduce = 0.5;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = -5;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
        };
        class syringe_nalbuphine_5ml_3 {
            painReduce = 0.7;
            hrIncreaseLow[] = {0, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 900;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = -5;
            opioidRelief = 1.2;
            respiratoryRate = -0.1;
        };
        class syringe_atropineIV_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {5, 15};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_atropineIV_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {10, 30};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_amiodarone_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_amiodarone_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_lidocaine_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
        };
        class syringe_lidocaine_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 3;
        };
        class syringe_etomidate_5ml_1 {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, -5};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            opioidDepression = 0.12;
            viscosityChange = 0;
        };
        class syringe_etomidate_5ml_3 {
            painReduce = 0.4;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 30;
            timeTillMaxEffect = 5;
            dose = 3;
            opioidDepression = 0.15;
            viscosityChange = 0;
        };
        class syringe_flumazenil_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_flumazenil_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_lorazepam_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {5, 15};
            hrIncreaseHigh[] = {7, 15};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            opioidDepression = 0.11;
            viscosityChange = -10;
            respiratoryRate = -0.1;
        };
        class syringe_lorazepam_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 15};
            hrIncreaseNormal[] = {5, 20};
            hrIncreaseHigh[] = {5, 20};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 3;
            opioidDepression = 0.13;
            viscosityChange = -15;
            respiratoryRate = -0.1;
        };
        class syringe_morphineIV_5ml_1 {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -20};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = -15;
            opioidRelief = 1.2;
            respiratoryRate = -0.2;
        };
        class syringe_morphineIV_5ml_3 {
            painReduce = 0.8;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -25};
            hrIncreaseHigh[] = {-5, -25};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = -20;
            opioidRelief = 1.3;
            respiratoryRate = -0.3;
        };
        class syringe_adenosineIV_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {-3, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_adenosineIV_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-3, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            dose = 3;
            viscosityChange = 0;
        };
        class syringe_doxapram_5ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {3, 10};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            dose = 1; 
            respiratoryRate = 0.2;
        };
        class syringe_doxapram_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {5, 15};
            hrIncreaseNormal[] = {5, 20};
            hrIncreaseHigh[] = {5, 25};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 3;
            respiratoryRate = 0.2;
        };
        class syringe_alteplase_5ml_3 {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 180;
            timeTillMaxEffect = 30;
            dose = 3;
            maxDose = 3;
            maxDoseDeviation = 0;
            incompatibleMedication[] = {};
            viscosityChange = 0;
        };
        class syringe_fentanyl_10ml_1 {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 60;
            dose = 1;
            viscosityChange = -10;
            onOverDose = "";
            opioidRelief = 1.1;
            opioidEffect = 0.15;
            opioidDepression = 0.15;
            respiratoryRate = -0.2;
        };
        class syringe_fentanyl_10ml_3 {
            painReduce = 0.8;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-10, -20};
            hrIncreaseHigh[] = {-10, -20};
            timeInSystem = 600;
            timeTillMaxEffect = 60;
            dose = 3;
            viscosityChange = -10;
            opioidRelief = 1.3;
            opioidEffect = 0.17;
            opioidDepression = 0.17;
            respiratoryRate = -0.3;
        };
        class syringe_ketamine_10ml_1 {
            painReduce = 0.6;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 25};
            timeInSystem = 300;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 10;
            opioidEffect = 0.12;
            opioidDepression = 0.12;
            respiratoryRate = 0.3;
        };
        class syringe_ketamine_10ml_3 {
            painReduce = 0.8;
            hrIncreaseLow[] = {15, 30};
            hrIncreaseNormal[] = {15, 35};
            hrIncreaseHigh[] = {15, 35};
            timeInSystem = 450;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = 10;
            opioidEffect = 0.15;
            opioidDepression = 0.15;
            respiratoryRate = 0.4;
        };
        class syringe_nalbuphine_10ml_1 {
            painReduce = 0.5;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 300;
            timeTillMaxEffect = 45;
            dose = 1;
            viscosityChange = -5;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
        };
        class syringe_nalbuphine_10ml_3 {
            painReduce = 0.7;
            hrIncreaseLow[] = {0, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 45;
            dose = 3;
            viscosityChange = -5;
            opioidRelief = 1.2;
            respiratoryRate = -0.1;
        };
        class syringe_lidocaine_10ml_1 {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
        };
        class syringe_morphineIV_10ml_1 {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -20};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = -15;
            opioidRelief = 1.1;
            respiratoryRate = -0.2;
        };
        class syringe_morphineIV_10ml_3 {
            painReduce = 0.8;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -25};
            hrIncreaseHigh[] = {-5, -25};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 3;
            viscosityChange = -15;
            opioidRelief = 1.3;
            respiratoryRate = -0.3;
        };
        class syringe_txa {
            maxDose = 6;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_eaca {
            maxDose = 6;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_epinephrineIV {
            maxDose = 9;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = ""; 
        };
        class syringe_norepinephrine {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_phenylephrine {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_nitroglycerin {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_atropineIV {
            maxDose = 9;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_amiodarone {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_etomidate {
            maxDose = 9;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_flumazenil {
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_lorazepam {
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_lidocaine {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_fentanyl {
            maxDose = 3;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_ketamine {
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_nalbuphine {
            maxDose = 4;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_morphineIV {
            maxDose = 3;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_adenosineIV {
            maxDose = 6;
            maxDoseDeviation = 3;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_alteplase {
            maxDose = 3;
            maxDoseDeviation = 0;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
        class syringe_doxapram {
            maxDose = 3;
            maxDoseDeviation = 2;
            incompatibleMedication[] = {};
            onOverDose = "";
        };
    };
};
