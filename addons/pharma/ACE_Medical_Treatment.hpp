class ADDON {
	class Medication {
        class Epinephrine {
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
            hrIncreaseLow[] = {0, 0};
            hrIncreaseNormal[] = {0, 0};
            hrIncreaseHigh[] = {0, 0};
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
            hrIncreaseLow[] = {-25, -20};
            hrIncreaseNormal[] = {-30, -25};
            hrIncreaseHigh[] = {-35, -25};
            timeInSystem = 1800;
            timeTillMaxEffect = 60;
            maxDose = 2;
            incompatibleMedication[] = {};
            viscosityChange = -35;
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
            hrIncreaseLow[] = {0, 0, 0};
            hrIncreaseNormal[] = {0, 0, 0};
            hrIncreaseHigh[] = {0, 0, 0};
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
            viscosityChange = 0;
        };
    };
    class Bandaging {
        class UnstableClot {
            effectiveness = 1;
            reopeningChance = 0.4;
            reopeningMinDelay = 60;
            reopeningMaxDelay = 240;

            class Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 360;
                reopeningMaxDelay = 1000;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 1;
            };
            class AbrasionMedium: Abrasion {};
            class AbrasionLarge: Abrasion {};

            class Avulsion: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.5;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 300;
            };
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: Avulsion {
                effectiveness = 0.3;
                reopeningChance = 0.5;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 300;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.1;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 200;
            };

            class Contusion: Abrasion {
                effectiveness = 2;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.2;
                reopeningMinDelay = 200;
                reopeningMaxDelay = 1000;
            };
            class CrushMinor: Crush {};
            class CrushMedium: Crush {};
            class CrushLarge: Crush {};

            class Cut: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.1;
                reopeningMinDelay = 360;
                reopeningMaxDelay = 1000;
            };
            class CutMinor: Cut {};
            class CutMedium: Cut {};
            class CutLarge: Cut {};

            class Laceration: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 800;
            };
            class LacerationMinor: Laceration {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: Laceration {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 800;
            };

            class VelocityWound: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.5;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 500;
            };
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.2;
                reopeningChance = 0.7;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 500;
            };

            class PunctureWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.5;
                reopeningMinDelay = 200;
                reopeningMaxDelay = 850;
            };
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: PunctureWound {};
        };
    };
};
