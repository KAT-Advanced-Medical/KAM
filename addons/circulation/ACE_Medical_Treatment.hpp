class ACE_Medical_Treatment {
    class IV {
        volume = 1000;
        ratio[] = {};
        type = "Blood";
        painReduce = 0;
        hrIncreaseLow[] = {0, 0};
        hrIncreaseNormal[] = {0, 0};
        hrIncreaseHigh[] = {0, 0};
        timeInSystem = 120;
        timeTillMaxEffect = 30;
        onOverDose = "";
        viscosityChange = 0;
        alphaFactor = 0;
        maxRelief = 0;
        opioidRelief = 0;
        opioidEffect = 0;
        class BloodIV {
            volume = 1000;
            ratio[] = {"Plasma", 1};
            rateCoef = 0.9;
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
            rateCoef = 1.3;
        };
        class SalineIV_500: SalineIV {
            volume = 500;
        };
        class SalineIV_250: SalineIV {
            volume = 250;
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
        class RingersLactateIV: SalineIV {
            volume = 1000;
            rateCoef = 1.3;
            type = "Ringers Lactate";
        };
        class RingersLactateIV_500: RingersLactateIV {
            volume = 500;
            rateCoef = 1.3;
            type = "Ringers Lactate";
        };
        class RingersLactateIV_250: RingersLactateIV {
            volume = 250;
            rateCoef = 1.3;
            type = "Ringers Lactate";
        };
        class PackedRBCIV_500: BloodIV {
            volume = 500;
            rateCoef = 0.7;
            type = "PackedRBC";
        };
        class PackedRBCIV_250: PackedRBCIV_500 {
            volume = 250;
            rateCoef = 0.7;
            type = "PackedRBC";
        };
        class MorphineIVInfusion: SalineIV_250 {
            painReduce = 0.8;
            hrIncreaseLow[] = {-2, -7};
            hrIncreaseNormal[] = {-3, -10};
            hrIncreaseHigh[] = {-5, -16};
            timeInSystem = 15;
            timeTillMaxEffect = 3;
            dose = 0.3;
            viscosityChange = -5;
            opioidRelief = 1.1;
            volume = 250;
            rateCoef = 1.3;
            type = "MorphineIVInfusion";
        };
        class EpinephrineIVInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {3, 14};
            hrIncreaseNormal[] = {5, 20};
            hrIncreaseHigh[] = {7, 25};
            timeInSystem = 10;
            timeTillMaxEffect = 3;
            dose = 0.1;
            alphaFactor = -0.2;
            volume = 250;
            rateCoef = 1.3;
            type = "EpinephrineIVInfusion";
        };
        class EtomidateInfusion: SalineIV_250 {
            painReduce = 0.2;
            hrIncreaseLow[] = {-3, -7};
            hrIncreaseNormal[] = {-6, -13};
            hrIncreaseHigh[] = {-10, -20};
            timeInSystem = 7;
            timeTillMaxEffect = 1;
            dose = 0.1;
            viscosityChange = 0;
            volume = 250;
            rateCoef = 1.3;
            type = "EtomidateInfusion";
        };
        class DoxapramInfusion: SalineIV_250 {
            painReduce = 0;
            hrIncreaseLow[] = {3, 12};
            hrIncreaseNormal[] = {5, 18};
            hrIncreaseHigh[] = {5, 25};
            timeInSystem = 10;
            timeTillMaxEffect = 2;
            dose = 0.1;
            respiratoryRate = 0.2;
            respiratoryDepth = 0.2;
            volume = 250;
            rateCoef = 1.3;
            type = "DoxapramInfusion";
        };
    };
};
