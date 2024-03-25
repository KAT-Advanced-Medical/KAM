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
        // Function to execute upon overdose. Arguments passed to call back are 0: unit <OBJECT>, 1: medicationClassName <STRING>
        onOverDose = "";
        // The viscosity of a fluid is a measure of its resistance to gradual deformation by shear stress or tensile stress. For liquids, it corresponds to the informal concept of "thickness". This value will increase/decrease the viscoty of the blood with the percentage given. Where 100 = max. Using the minus will decrease viscosity
        viscosityChange = 0;
        // How much does the medication constrict/dilate the patient's blood vessels?
        alphaFactor = 0;
        // Max amount of pain the medication can remove
        maxRelief = 0;
        // Reduction of damage from wounds
        opioidRelief = 1;

        class Epinephrine {
            painReduce = 0;
            hrIncreaseLow[] = {10, 20};
            hrIncreaseNormal[] = {10, 50};
            hrIncreaseHigh[] = {10, 40};
            timeInSystem = 120;
            timeTillMaxEffect = 10;
            maxDose = 10;
            incompatibleMedication[] = {};
            alphaFactor = 0.15;
            onOverDose = "";
        };
        class Morphine {
            painReduce = 0.8;
            hrIncreaseLow[] = {-10, -20};
            hrIncreaseNormal[] = {-10, -30};
            hrIncreaseHigh[] = {-10, -35};
            timeInSystem = 900;
            timeTillMaxEffect = 30;
            maxDose = 4;
            incompatibleMedication[] = {};
            viscosityChange = -10;
            opioidRelief = 1.2;
        };
        class Carbonate {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {15, 20};
            timeInSystem = 30;
            timeTillMaxEffect = 2;
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
            timeInSystem = 120;
            timeTillMaxEffect = 5;
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
            timeTillMaxEffect = 30;
            maxDose = 12;
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
            maxDose = 6;
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
            maxDose = 12;
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
            maxDose = 2;
            incompatibleMedication[] = {};
            viscosityChange = -10;
            onOverDose = "";
            opioidRelief = 1.5;
        };
        class Ketamine {
            painReduce = 0.8;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {10, 15};
            hrIncreaseHigh[] = {10, 15};
            timeInSystem = 900;
            timeTillMaxEffect = 15;
            maxDose = 4;
            incompatibleMedication[] = {};
            viscosityChange = 10;
            onOverDose = "";
        };
        class Nalbuphine {
            painReduce = 0.6;
            hrIncreaseLow[] = {-5, 0};
            hrIncreaseNormal[] = {-10, -5};
            hrIncreaseHigh[] = {-15, -5};
            timeInSystem = 900;
            timeTillMaxEffect = 30;
            maxDose = 4;
            incompatibleMedication[] = {};
            viscosityChange = -5;
            onOverDose = "";
            opioidRelief = 1.2;
        };
        class Painkillers {
            painReduce = 0.2;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 360;
            timeTillMaxEffect = 60;
            maxDose = 10;
            incompatibleMedication[] = {};
            viscosityChange = -5;
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
            maxDose = 4;
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
            timeTillMaxEffect = 15;
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
            timeInSystem = 45;
            timeTillMaxEffect = 5;
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
            maxDose = 2;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
        };
        class Caffeine {
            painReduce = 0;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 1800;
            timeTillMaxEffect = 5;
            maxDose = 6;
            incompatibleMedication[] = {};
            viscosityChange = 0;
            onOverDose = "";
        };
        class BubbleWrap {
            painReduce = 0.05;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 300;
            timeTillMaxEffect = 5;
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
            maxDose = 4;
            incompatibleMedication[] = {};
            viscosityChange = 5;
            onOverDose = "";
            maxRelief = 0.6;
        };
    };
};
