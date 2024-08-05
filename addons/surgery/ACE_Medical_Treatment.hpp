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

        class BloodClotMinor: FieldDressing {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.6;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 1;
            };
            class AbrasionMedium: Abrasion {
            };
            class AbrasionLarge: Abrasion {
            };

            class Avulsion: Abrasion {};
            class AvulsionMinor: AbrasionMinor {
                effectiveness = 0.5;
            };
            class AvulsionMedium: Avulsion {};
            class AvulsionLarge: Avulsion {};

            class Contusion: Abrasion {};
            class ContusionMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {};
            class CrushMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class CrushMedium: Crush {};
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: AbrasionMinor {
                effectiveness = 0.5;
            };
            class CutMedium: Cut {};
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: AbrasionMinor {
                effectiveness = 0.5;
            };
            class LacerationMedium: Laceration {};
            class LacerationLarge: Laceration {};

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: AbrasionMinor {
                effectiveness = 0.5;
            };
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: AbrasionMinor {
                effectiveness = 0.5;
            };
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: PunctureWound {};
        };

        class BloodClotMedium: FieldDressing {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMinor: Abrasion {};
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
            };
            class AbrasionLarge: Abrasion {};

            class Avulsion: Abrasion {};
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class AvulsionLarge: Avulsion {};

            class Contusion: Abrasion {};
            class ContusionMinor: Contusion {};
            class ContusionMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class LacerationLarge: Laceration {};

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class PunctureWoundLarge: PunctureWound {};
        };

        class BloodClotLarge: FieldDressing {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.8;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 600;
            };
            class AbrasionMinor: Abrasion {};
            class AbrasionMedium: Abrasion{};
            class AbrasionLarge: Abrasion {
                effectiveness = 1;
            };

            class Avulsion: Abrasion {};
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: Avulsion {};
            class AvulsionLarge: AbrasionLarge {
                effectiveness = 0.5;
            };

            class Contusion: Abrasion {};
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: AbrasionLarge {
                effectiveness = 1;
            };

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: Crush {};
            class CrushLarge: AbrasionLarge {
                effectiveness = 1;
            };

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: Cut {};
            class CutLarge: AbrasionLarge {
                effectiveness = 0.5;
            };

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: AbrasionLarge {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: AbrasionLarge {
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: AbrasionLarge {
                effectiveness = 1;
            };
        };

        class BloodClotMinorTXA: BloodClotMinor {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
            };
            class AvulsionMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class ContusionMinor: AbrasionMinor {
                effectiveness = 2;
            };
            class CrushMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class CutMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class LacerationMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class VelocityWoundMinor: AbrasionMinor {
                effectiveness = 1;
            };
            class PunctureWoundMinor: AbrasionMinor {
                effectiveness = 1;
            };
        };

        class BloodClotMediumTXA: BloodClotMedium {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2;
            };
            class AvulsionMedium: AbrasionMedium {
                effectiveness = 0.5;
            };
            class ContusionMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class CrushMedium: AbrasionMedium {
                effectiveness = 1;
            };
            class CutMedium: AbrasionMedium {
                effectiveness = 0.5;
            };
            class LacerationMedium: AbrasionMedium {
                effectiveness = 0.5;
            };
            class VelocityWoundMedium: AbrasionMedium {
                effectiveness = 0.5;
            };
            class PunctureWoundMedium: AbrasionMedium {
                effectiveness = 0.5;
            };
        };

        class BloodClotLargeTXA: BloodClotLarge {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
            };
            class AvulsionLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
            class ContusionLarge: AbrasionLarge {
                effectiveness = 1;
            };
            class CrushLarge: AbrasionLarge {
                effectiveness = 1;
            };
            class CutLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
            class LacerationLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
            class VelocityWoundLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
            class PunctureWoundLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
        };

        class BloodClotMinorEACA: BloodClotMinor {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
                reopeningChance = 0;
            };
            class AvulsionMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class ContusionMinor: AbrasionMinor {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CrushMinor: AbrasionMinor {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CutMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class LacerationMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class VelocityWoundMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class PunctureWoundMinor: AbrasionMinor {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
        };

        class BloodClotMediumEACA: BloodClotMedium {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2;
                reopeningChance = 0;
            };
            class AvulsionMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class ContusionMedium: AbrasionMedium {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CrushMedium: AbrasionMedium {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CutMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class LacerationMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class VelocityWoundMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class PunctureWoundMedium: AbrasionMedium {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
        };

        class BloodClotLargeEACA: BloodClotLarge {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
                reopeningChance = 0;
            };
            class AvulsionLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class ContusionLarge: AbrasionLarge {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CrushLarge: AbrasionLarge {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
            class CutLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class LacerationLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class VelocityWoundLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class PunctureWoundLarge: AbrasionLarge {
                effectiveness = 2;
                reopeningChance = 0.1;
            };
        };
    };
};
