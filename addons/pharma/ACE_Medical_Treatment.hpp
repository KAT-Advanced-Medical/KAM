class ADDON {
    class Medication {
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
        };
        class Phenylephrine {
            painReduce = 0;
            hrIncreaseLow[] = {-5, -10};
            hrIncreaseNormal[] = {-10, -15};
            hrIncreaseHigh[] = {-10, -15};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            maxDose = 12;
            incompatibleMedication[] = {};
            viscosityChange = 50;
            alphaFactor = -0.5;
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
        };
        class Painkillers {
            painReduce = 0.3;
            hrIncreaseLow[] = {0, 5};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 15};
            timeInSystem = 600;
            timeTillMaxEffect = 90;
            maxDose = 10;
            incompatibleMedication[] = {};
            viscosityChange = -5;
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
        };
    };
};
