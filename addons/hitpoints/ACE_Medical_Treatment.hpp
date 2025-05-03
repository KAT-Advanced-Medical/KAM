class ADDON {
    class Bandaging {
        class Hemostat {
            effectiveness = 1;
            reopeningChance = 0.1;
            reopeningMinDelay = 120;
            reopeningMaxDelay = 200;

            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0;
                reopeningMinDelay = 1;
                reopeningMaxDelay = 2;
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

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: PunctureWound {};
        };
        class fourByfour_Gauze {
            effectiveness = 1;
            reopeningChance = 0.7;
            reopeningMinDelay = 60;
            reopeningMaxDelay = 120;

            class Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };

            class Avulsion: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.5;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.25;
            };

            class Contusion: Abrasion {
                effectiveness = 0;
            };
            class ContusionMinor: Contusion {
            };
            class ContusionMedium: Contusion {
            };
            class ContusionLarge: Contusion {
            };

            class Crush: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class CrushMinor: Crush {
                effectiveness = 2;
            };
            class CrushMedium: Crush {
                effectiveness = 1;
            };
            class CrushLarge: Crush {
                effectiveness = 1;
            };

            class Cut: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class CutMinor: Cut {
                effectiveness = 2;
            };
            class CutMedium: Cut {
                effectiveness = 1;
            };
            class CutLarge: Cut {
                effectiveness = 0.5;
            };

            class Laceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class LacerationMinor: Laceration {
                effectiveness = 2;
            };
            class LacerationMedium: Laceration {
                effectiveness = 1;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.25;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0.5;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.25;
            };
        };
        class fourByfour_Gauze_wrapped {
            effectiveness = 1;
            reopeningChance = 0.1;
            reopeningMinDelay = 1200;
            reopeningMaxDelay = 1800;

            class Abrasion {
                effectiveness = 1;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.5;
            };

            class Avulsion: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.5;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.25;
            };

            class Contusion: Abrasion {
                effectiveness = 0;
            };
            class ContusionMinor: Contusion {
            };
            class ContusionMedium: Contusion {
            };
            class ContusionLarge: Contusion {
            };

            class Crush: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class CrushMinor: Crush {
                effectiveness = 2;
            };
            class CrushMedium: Crush {
                effectiveness = 1;
            };
            class CrushLarge: Crush {
                effectiveness = 1;
            };

            class Cut: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class CutMinor: Cut {
                effectiveness = 2;
            };
            class CutMedium: Cut {
                effectiveness = 1;
            };
            class CutLarge: Cut {
                effectiveness = 0.5;
            };

            class Laceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class LacerationMinor: Laceration {
                effectiveness = 2;
            };
            class LacerationMedium: Laceration {
                effectiveness = 1;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.25;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0.5;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.25;
            };
        };
        class Compressed_Gauze {
            effectiveness = 1;
            reopeningChance = 0.7;
            reopeningMinDelay = 60;
            reopeningMaxDelay = 120;

            class Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0.25;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.25;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };

            class Avulsion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 1;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.5;
            };

            class Contusion: Abrasion {
                effectiveness = 0;
            };
            class ContusionMinor: Contusion {
            };
            class ContusionMedium: Contusion {
            };
            class ContusionLarge: Contusion {
            };

            class Crush: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class CrushMinor: Crush {
                effectiveness = 0.5;
            };
            class CrushMedium: Crush {
                effectiveness = 0.5;
            };
            class CrushLarge: Crush {
                effectiveness = 0.25;
            };

            class Cut: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class CutMinor: Cut {
                effectiveness = 0.5;
            };
            class CutMedium: Cut {
                effectiveness = 0.5;
            };
            class CutLarge: Cut {
                effectiveness = 0.25;
            };

            class Laceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class LacerationMinor: Laceration {
                effectiveness = 1;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.5;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.5;
            };
        };
        class Compressed_Gauze_wrapped {
            effectiveness = 1;
            reopeningChance = 0.2;
            reopeningMinDelay = 1200;
            reopeningMaxDelay = 1800;

            class Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.2;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 0.5;

            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0.25;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.25;
            };

            class Avulsion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 1;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.5;
            };

            class Contusion: Abrasion {
                effectiveness = 0;
            };
            class ContusionMinor: Contusion {
            };
            class ContusionMedium: Contusion {
            };
            class ContusionLarge: Contusion {
            };

            class Crush: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class CrushMinor: Crush {
                effectiveness = 0.5;
            };
            class CrushMedium: Crush {
                effectiveness = 0.5;
            };
            class CrushLarge: Crush {
                effectiveness = 0.25;
            };

            class Cut: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class CutMinor: Cut {
                effectiveness = 0.5;
            };
            class CutMedium: Cut {
                effectiveness = 0.5;
            };
            class CutLarge: Cut {
                effectiveness = 0.25;
            };

            class Laceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class LacerationMinor: Laceration {
                effectiveness = 1;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.5;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.5;
            };
        };
        class ETD {
            effectiveness = 1;
            reopeningChance = 0.2;
            reopeningMinDelay = 1200;
            reopeningMaxDelay = 1800;
            
            class Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 3;

            };
            class AbrasionMedium: Abrasion {
                effectiveness = 3;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
            };

            class Avulsion: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 4;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 3;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 2;
            };

            class Contusion: Abrasion {
                effectiveness = 0;
            };
            class ContusionMinor: Contusion {
            };
            class ContusionMedium: Contusion {
            };
            class ContusionLarge: Contusion {
            };

            class Crush: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class CrushMinor: Crush {
                effectiveness = 3;
            };
            class CrushMedium: Crush {
                effectiveness = 3;
            };
            class CrushLarge: Crush {
                effectiveness = 2;
            };

            class Cut: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class CutMinor: Cut {
                effectiveness = 3;
            };
            class CutMedium: Cut {
                effectiveness = 3;
            };
            class CutLarge: Cut {
                effectiveness = 2;
            };

            class Laceration: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class LacerationMinor: Laceration {
                effectiveness = 3;
            };
            class LacerationMedium: Laceration {
                effectiveness = 3;
            };
            class LacerationLarge: Laceration {
                effectiveness = 2;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 3;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 3;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 2;
            };

            class PunctureWound: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 3;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 3;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 2;
            };
        };
    };
};