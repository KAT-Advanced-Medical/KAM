class ace_medical_treatment {
    class Medication {
        class Antidot {
            painReduce = 0;
            hrIncreaseLow[] = {5, 10};
            hrIncreaseNormal[] = {5, 10};
            hrIncreaseHigh[] = {5, 10};
            timeInSystem = 1800;
            timeTillMaxEffect = 30;
            maxDose = 3;
            incompatibleMedication[] = {"Morphine"};
            viscosityChange = -10;
        };

        class PoisenBP {
            painReduce = 0;
            hrIncreaseLow[] = {-10, -13};
            hrIncreaseNormal[] = {-10, -23};
            hrIncreaseHigh[] = {-10, -28};
            timeInSystem = 300;
            timeTillMaxEffect = 30;
            maxDose = 6;
            incompatibleMedication[] = {};
            viscosityChange = -10;
        };

    };
};