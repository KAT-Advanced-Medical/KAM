class ACE_Medical_Treatment {
    class Medication {
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
            timeInSystem = 600;
            timeTillMaxEffect = 15;
            maxDose = 3;
            incompatibleMedication[] = {};
            viscosityChange = 0;
        };
        class Norepinephrine {
            painReduce = 0;
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
            timeInSystem = 360;
            timeTillMaxEffect = 15;
            maxDose = 12;
            incompatibleMedication[] = {};
            viscosityChange = 25;
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
        };
    };
};
