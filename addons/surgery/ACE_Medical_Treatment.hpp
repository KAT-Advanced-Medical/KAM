class ACE_Medical_Treatment {
    class Bandaging {
        class FieldDressing {};
        class Dressing: FieldDressing {
            class Abrasion {
                effectiveness = 50;
                reopeningChance = 0;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 200;
            };
            class AbrasionMinor: Abrasion {};
            class AbrasionMedium: Abrasion {};
            class AbrasionLarge: Abrasion {};

            class Avulsion: Abrasion {};
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: Avulsion {};
            class AvulsionLarge: Avulsion {};

            class Contusion: Abrasion {};
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: Crush {};
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: Cut {};
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: Laceration {};

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: PunctureWound {};
        };
        class UnstableClot: FieldDressing {
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
