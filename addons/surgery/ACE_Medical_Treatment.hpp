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
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 1;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0;
            };

            class Avulsion: Abrasion {};
            class AvulsionMinor: AbrasionMinor {};
            class AvulsionMedium: Avulsion {};
            class AvulsionLarge: Avulsion {};

            class Contusion: Abrasion {};
            class ContusionMinor: AbrasionMinor {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {};
            class CrushMinor: AbrasionMinor {};
            class CrushMedium: Crush {};
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: AbrasionMinor {};
            class CutMedium: Cut {};
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: AbrasionMinor {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: Laceration {};

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: AbrasionMinor {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: AbrasionMinor {};
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
            class AbrasionMinor: Abrasion {
                effectiveness = 0;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0;
            };

            class Avulsion: Abrasion {};
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: AbrasionMedium {
                reopeningChance = 0.4;
            };
            class AvulsionLarge: Avulsion {};

            class Contusion: Abrasion {};
            class ContusionMinor: Contusion {};
            class ContusionMedium: AbrasionMedium {
                reopeningChance = 2;
            };
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: AbrasionMedium {
                reopeningChance = 0.5;
            };
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: AbrasionMedium {
                reopeningChance = 0.5;
            };
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: AbrasionMedium {
                reopeningChance = 0.5;
            };
            class LacerationLarge: Laceration {};

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: AbrasionMedium {
                reopeningChance = 0.5;
            };
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: AbrasionMedium {
                reopeningChance = 0.5;
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
                reopeningChance = 1;
            };

            class Contusion: Abrasion {};
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: AbrasionLarge {};

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: Crush {};
            class CrushLarge: AbrasionLarge {};

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: Cut {};
            class CutLarge: AbrasionLarge {
                reopeningChance = 0.7;
            };

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: AbrasionLarge {
                reopeningChance = 0.7;
            };

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: AbrasionLarge {
                reopeningChance = 0.7;
            };

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: AbrasionLarge {};
        };

        class BloodClotMinorTXA: BloodClotMinor {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 1;
            };
            class AvulsionMinor: AbrasionMinor {};
            class ContusionMinor: AbrasionMinor {};
            class CrushMinor: AbrasionMinor {};
            class CutMinor: AbrasionMinor {};
            class LacerationMinor: AbrasionMinor {};
            class VelocityWoundMinor: AbrasionMinor {};
            class PunctureWoundMinor: AbrasionMinor {};
        };

        class BloodClotMediumTXA: BloodClotMedium {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
            };
            class AvulsionMedium: AbrasionMedium {};
            class ContusionMedium: AbrasionMedium {};
            class CrushMedium: AbrasionMedium {};
            class CutMedium: AbrasionMedium {};
            class LacerationMedium: AbrasionMedium {};
            class VelocityWoundMedium: AbrasionMedium {};
            class PunctureWoundMedium: AbrasionMedium {};
        };

        class BloodClotLargeTXA: BloodClotLarge {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 1;
            };
            class AvulsionLarge: AbrasionLarge {};
            class ContusionLarge: AbrasionLarge {};
            class CrushLarge: AbrasionLarge {};
            class CutLarge: AbrasionLarge {};
            class LacerationLarge: AbrasionLarge {};
            class VelocityWoundLarge: AbrasionLarge {};
            class PunctureWoundLarge: AbrasionLarge {};
        };

        class BloodClotMinorEACA: BloodClotMinor {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
            };
            class AvulsionMinor: AbrasionMinor {};
            class ContusionMinor: AbrasionMinor {};
            class CrushMinor: AbrasionMinor {};
            class CutMinor: AbrasionMinor {};
            class LacerationMinor: AbrasionMinor {};
            class VelocityWoundMinor: AbrasionMinor {};
            class PunctureWoundMinor: AbrasionMinor {};
        };

        class BloodClotMediumEACA: BloodClotMedium {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2;
            };
            class AvulsionMedium: AbrasionMedium {};
            class ContusionMedium: AbrasionMedium {};
            class CrushMedium: AbrasionMedium {};
            class CutMedium: AbrasionMedium {};
            class LacerationMedium: AbrasionMedium {};
            class VelocityWoundMedium: AbrasionMedium {};
            class PunctureWoundMedium: AbrasionMedium {};
        };

        class BloodClotLargeEACA: BloodClotLarge {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 600;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
            };
            class AvulsionLarge: AbrasionLarge {};
            class ContusionLarge: AbrasionLarge {};
            class CrushLarge: AbrasionLarge {};
            class CutLarge: AbrasionLarge {};
            class LacerationLarge: AbrasionLarge {};
            class VelocityWoundLarge: AbrasionLarge {};
            class PunctureWoundLarge: AbrasionLarge {};
        };
    };
};
