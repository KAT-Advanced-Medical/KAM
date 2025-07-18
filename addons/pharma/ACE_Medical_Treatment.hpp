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
        //multiplier to contractility
        contractility = 0;
        //Is the medication dosaging based off of weight
        weightBased = "false";
        //what dose corresponds to a weight of 80kg
        weightDose = 20;
        //if weightDose isnt 20 (default), what is the upper and lower range of doses
        weightDoseMin = 10; //60kg
        weightDoseMax = 30; //100kg
        //maximum dose before medication effects are reduced
        maximumEffectiveDose = 40;
        //multiplier to nausea
        nauseaMult = 0;
        //is this drug a sedation drug
        sedation = "false";
        paralysis = "false";


        class Epinephrine {
            painReduce = 0;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {5, 25};
            hrIncreaseHigh[] = {5, 20};
            timeInSystem = 120;
            timeTillMaxEffect = 10;
            dose = 1;
            maxDose = 60;
            maxDoseDeviation = 40;
            incompatibleMedication[] = {};
            alphaFactor = -0.1;
            onOverDose = "";
            maximumEffectiveDose = 40;
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
            alphaFactor = -0.2;
            onOverDose = "";
            contractility = 1;
        };
        class Morphine {
            painReduce = 0.6;
            hrIncreaseLow[] = {-2, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 60;
            dose = 1;
            maxDose = 20;
            maxDoseDeviation = 1;
            incompatibleMedication[] = {};
            viscosityChange = -0;
            maximumEffectiveDose = 20;
            nauseaMult = 0.2;
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
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            maximumEffectiveDose = 20;
        };
        class AdenosineIV {
            painReduce = 0;
            hrIncreaseLow[] = {-7, -10};
            hrIncreaseNormal[] = {-15, -20};
            hrIncreaseHigh[] = {-15, -25};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            dose = 1;
            maxDose = 20;
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
            hrIncreaseLow[] = {-2, -7};
            hrIncreaseNormal[] = {-2, -7};
            hrIncreaseHigh[] = {-2, -7};
            timeInSystem = 90;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 40;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
            maximumEffectiveDose = 20;
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
            alphaFactor = -0.2;
            onOverDose = "";
            contractility = 0.7;
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
            alphaFactor = -0.4;
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
            maxDose = 40;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            viscosityChange = 25;
            alphaFactor = -0.15;
            maximumEffectiveDose = 20;
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
            alphaFactor = 0.2;
            onOverDose = "";
            contractility = -0.3;
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
            contractility = -0.2;
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
            contractility = 0.3;
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
            contractility = -0.2;
        };
        class CWMP {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 360;
            timeTillMaxEffect = 45;
            dose = 1;
            maxDose = 60;
            maxDoseDeviation = 40;
            incompatibleMedication[] = {};
            viscosityChange = -5;
            onOverDose = "";
            maxRelief = 0.4;
            maximumEffectiveDose = 60;
        };
        class PainKillers {
            painReduce = 0.35;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -17};
            timeInSystem = 420;
            timeTillMaxEffect = 60;
            dose = 1;
            maxDose = 60;
            incompatibleMedication[] = {};
            onOverDose = "";
            maxRelief = 0.5;
            maximumEffectiveDose = 60;
        };
        class Atropine {
            painReduce = 0;
            hrIncreaseLow[] = {20, 40};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 40;
            incompatibleMedication[]= {};
            viscosityChange = 0;
            onOverDose = "";
            contractility = 0.2;
            maximumEffectiveDose = 40;
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
            contractility = -0.5;
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
            contractility = -0.4;
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
            contractility = -0.1;
        };
        class Pervitin {
            painReduce = 0.5;
            hrIncreaseLow[] = {15, 25};
            hrIncreaseNormal[] = {15, 30};
            hrIncreaseHigh[] = {15, 25};
            timeInSystem = 600;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 20;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
            opioidEffect = 0.2;
            maximumEffectiveDose = 20;
            nauseaMult = 0.2;
        };
        class Caffeine {
            painReduce = 0;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 1800;
            timeTillMaxEffect = 5;
            dose = 1;
            maxDose = 60;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
            respiratoryRate = 0.1;
            maximumEffectiveDose = 60;
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
            maxDose = 90;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
            maxRelief = 0.6;
            maximumEffectiveDose = 60;
        };
        class Ondansetron {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 300;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = -0;
            maximumEffectiveDose = 2;
            nauseaMult = -0.4;
        };
        class Succinylcholine {
            painReduce = 0.0;
            hrIncreaseLow[] = {15, 20};
            hrIncreaseNormal[] = {10, 20};
            hrIncreaseHigh[] = {10, 20};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            viscosityChange = -0;
            maximumEffectiveDose = 2;
        };
        class Rocuronium {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 240;
            timeTillMaxEffect = 20;
            dose = 1;
            viscosityChange = -0;
            maximumEffectiveDose = 2;
        };
        class Sugammadex  {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = -0;
            maximumEffectiveDose = 20;
        };
        class syringe_TXA_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 120;
            timeTillMaxEffect = 5;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_TXA_10ml {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 120;
            timeTillMaxEffect = 20;
            dose = 1;
            viscosityChange = 0;
        };
        class syringe_EACA_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {-2, -5};
            hrIncreaseNormal[] = {-2, -5};
            hrIncreaseHigh[] = {-2, -5};
            timeInSystem = 100;
            timeTillMaxEffect = 35;
            dose = 1;
            viscosityChange = 0;
            maximumEffectiveDose = 20;
        };
        class syringe_EpinephrineIV_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {10, 15};
            hrIncreaseNormal[] = {10, 20};
            hrIncreaseHigh[] = {10, 20};
            timeInSystem = 180;
            timeTillMaxEffect = 20;
            dose = 1;
            alphaFactor = -0.1;
            contractility = 0.9;
            maximumEffectiveDose = 30;
            respiratoryRate = 0.2;
        };
        class syringe_Phenylephrine_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {2, 10};
            hrIncreaseNormal[] = {2, 15};
            hrIncreaseHigh[] = {2, 10};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            viscosityChange = 10;
            dose = 1;
            alphaFactor = -0.2;
            maximumEffectiveDose = 30;
        };
        class syringe_Fentanyl_5ml {
            painReduce = 1;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 900;
            timeTillMaxEffect = 20;
            dose = 1;
            viscosityChange = -10;
            opioidRelief = 1.2;
            opioidEffect = 0.11;
            opioidDepression = 0.2;
            respiratoryRate = -0.2;
            contractility = -0.2;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.4;
        };
        class syringe_Ketamine_5ml {
            painReduce = 0.8;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {10, 20};
            hrIncreaseHigh[] = {5, 20};
            timeInSystem = 600;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = 10;
            opioidEffect = 0.09;
            opioidDepression = 0.09;
            respiratoryRate = 0.2;
            contractility = 0.1;
            weightBased = "true";
            weightDose = 15;
            weightDoseMin = 10;
            weightDoseMax = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_Nalbuphine_5ml {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 600;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = -5;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
            contractility = -0.1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_AtropineIV_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {5, 15};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 0;
            contractility = 0.1;
            maximumEffectiveDose = 30;
        };
        class syringe_Amiodarone_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 0;
            contractility = -0.2;
            maximumEffectiveDose = 30;
        };
        class syringe_Lidocaine_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            contractility = -0.1;
            maximumEffectiveDose = 30;
        };
        class syringe_Etomidate_5ml {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, -5};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            opioidDepression = 0.06;
            viscosityChange = 0;
            contractility = -0.05;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
        };
        class syringe_Flumazenil_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 5;
            dose = 1;
            viscosityChange = 0;
            maximumEffectiveDose = 30;
        };
        class syringe_Lorazepam_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {5, 15};
            hrIncreaseHigh[] = {7, 15};
            timeInSystem = 30;
            timeTillMaxEffect = 5;
            dose = 1;
            opioidDepression = 0.11;
            viscosityChange = -5;
            respiratoryRate = -0.1;
            contractility = -0.1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
        };
        class syringe_MorphineIV_5ml {
            painReduce = 0.7;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -20};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 600;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = -7;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_AdenosineIV_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {-3, -10};
            hrIncreaseNormal[] = {-5, -10};
            hrIncreaseHigh[] = {-5, -15};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = 0;
            maximumEffectiveDose = 30;
        };
        class syringe_Doxapram_5ml {
            painReduce = 0;
            hrIncreaseLow[] = {3, 10};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 180;
            timeTillMaxEffect = 15;
            dose = 1; 
            respiratoryRate = 0.40;
            maximumEffectiveDose = 30;
        };
        class syringe_Ondansetron_5ml {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 300;
            timeTillMaxEffect = 15;
            dose = 1;
            viscosityChange = -0;
            nauseaMult = -0.7;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
        };
        class syringe_Succinylcholine_5ml {
            painReduce = 0.0;
            hrIncreaseLow[] = {15, 20};
            hrIncreaseNormal[] = {10, 20};
            hrIncreaseHigh[] = {10, 20};
            timeInSystem = 120;
            timeTillMaxEffect = 5;
            dose = 1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
        };
        class syringe_Rocuronium_5ml {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 300;
            timeTillMaxEffect = 20;
            dose = 1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
        };
        class syringe_Sugammadex_5ml_20  {
            painReduce = 0.0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 60;
            timeTillMaxEffect = 15;
            dose = 1;
            maximumEffectiveDose = 30;
        };
        class syringe_Alteplase_5ml_20 {
            painReduce = 0;
            hrIncreaseLow[] = {-4, -10};
            hrIncreaseNormal[] = {-5, -15};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 180;
            timeTillMaxEffect = 30;
            dose = 1;
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            maximumEffectiveDose = 30;
        };
        class syringe_Fentanyl_10ml {
            painReduce = 1;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 300;
            timeTillMaxEffect = 60;
            dose = 1;
            viscosityChange = -6;
            onOverDose = "";
            opioidRelief = 1.1;
            opioidEffect = 0.15;
            opioidDepression = 0.15;
            respiratoryRate = -0.2;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_Ketamine_10ml {
            painReduce = 0.8;
            hrIncreaseLow[] = {5, 20};
            hrIncreaseNormal[] = {10, 25};
            hrIncreaseHigh[] = {5, 25};
            timeInSystem = 300;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = 10;
            opioidEffect = 0.06;
            opioidDepression = 0.06;
            respiratoryRate = 0.15;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_Nalbuphine_10ml {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 300;
            timeTillMaxEffect = 60;
            dose = 1;
            viscosityChange = -5;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_Lidocaine_10ml {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 120;
            timeTillMaxEffect = 30;
            dose = 1;
            maximumEffectiveDose = 30;
        };
        class syringe_MorphineIV_10ml {
            painReduce = 0.7;
            hrIncreaseLow[] = {-5, -15};
            hrIncreaseNormal[] = {-5, -20};
            hrIncreaseHigh[] = {-5, -20};
            timeInSystem = 300;
            timeTillMaxEffect = 30;
            dose = 1;
            viscosityChange = -10;
            opioidRelief = 1.1;
            respiratoryRate = -0.1;
            weightBased = "true";
            weightDose = 20;
            maximumEffectiveDose = 30;
            nauseaMult = 0.3;
        };
        class syringe_TXA {
            maxDose = 40;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 20;
        };
        class syringe_EACA {
            maxDose = 40;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 20;
        };
        class syringe_Epinephrine {
            maxDose = 40;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Norepinephrine {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Phenylephrine {
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Nitroglycerin {
            maxDose = 60;
            maxDoseDeviation = 30;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Atropine {
            maxDose = 90;
            maxDoseDeviation = 30;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Amiodarone {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Etomidate {
            maxDose = 60;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Flumazenil {
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Lorazepam {
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Lidocaine {
            maxDose = 60;
            maxDoseDeviation = 30;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Fentanyl {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Ketamine {
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Nalbuphine {
            maxDose = 40;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Morphine {
            maxDose = 30;
            maxDoseDeviation = 30;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Adenosine {
            maxDose = 60;
            maxDoseDeviation = 30;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Alteplase {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Doxapram {
            maxDose = 30;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Ondansetron {
            maxDose = 30;
            maxDoseDeviation = 20;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Succinylcholine {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Rocuronium {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
        class syringe_Sugammadex  {
            maxDose = 30;
            maxDoseDeviation = 10;
            incompatibleMedication[] = {};
            onOverDose = "";
            maximumEffectiveDose = 30;
        };
    };
};