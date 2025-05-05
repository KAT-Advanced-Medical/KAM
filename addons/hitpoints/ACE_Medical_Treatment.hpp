class ACE_Medical_Treatment {
    class Bandaging {
        class FieldDressing {};
        class Hemostat: FieldDressing {
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
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 1;
            };
        };
        class fourByfour_Gauze: FieldDressing {
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
        class fourByfour_Gauze_wrapped: FieldDressing {
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
        class Compressed_Gauze: FieldDressing {
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
        class Compressed_Gauze_wrapped: FieldDressing {
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
        class Hemostatic_Gauze: FieldDressing {
            effectiveness = 1;
            reopeningChance = 0.7;
            reopeningMinDelay = 60;
            reopeningMaxDelay = 120;

            class Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
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
                reopeningChance = 0.4;
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
                reopeningChance = 0.5;
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
                reopeningChance = 0.5;
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
                reopeningChance = 0.5;
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
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
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
        class Hemostatic_Gauze_wrapped: FieldDressing {
            effectiveness = 1;
            reopeningChance = 0.1;
            reopeningMinDelay = 1200;
            reopeningMaxDelay = 1800;

            class Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.5;
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
                reopeningChance = 0.4;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.5;
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
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
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
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
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
                reopeningChance = 0.5;
                reopeningMinDelay = 1200;
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
                reopeningChance = 0.5;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 1200;
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
        class ETD: FieldDressing {
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
        class Adhesive_Bandage: FieldDressing {
            effectiveness = 1;
            reopeningChance = 0.2;
            reopeningMinDelay = 600;
            reopeningMaxDelay = 1200;

            class Abrasion {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 1;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0.5;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.5;
            };

            class Avulsion: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 0;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0;
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
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CrushMinor: Crush {
                effectiveness = 0;
            };
            class CrushMedium: Crush {
                effectiveness = 0;
            };
            class CrushLarge: Crush {
                effectiveness = 0;
            };

            class Cut: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CutMinor: Cut {
                effectiveness = 1;
            };
            class CutMedium: Cut {
                effectiveness = 1;
            };
            class CutLarge: Cut {
                effectiveness = 0;
            };

            class Laceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class LacerationMinor: Laceration {
                effectiveness = 1;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0;
            };

            class VelocityWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0;
            };

            class PunctureWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0;
            };
        };
        class Burn_Dressing: FieldDressing {
            effectiveness = 0;
            reopeningChance = 0.2;
            reopeningMinDelay = 600;
            reopeningMaxDelay = 1200;

            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 0;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0;
            };

            class Avulsion: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 0;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0;
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
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CrushMinor: Crush {
                effectiveness = 0;
            };
            class CrushMedium: Crush {
                effectiveness = 0;
            };
            class CrushLarge: Crush {
                effectiveness = 0;
            };

            class Cut: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CutMinor: Cut {
                effectiveness = 0;
            };
            class CutMedium: Cut {
                effectiveness = 0;
            };
            class CutLarge: Cut {
                effectiveness = 0;
            };

            class Laceration: Abrasion {
                effectiveness = 0;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0;
            };

            class VelocityWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0;
            };

            class PunctureWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0;
            };

            class ThermalBurn: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.4;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 240;
            };
            class ThermalBurnMinor: PunctureWound {
                effectiveness = 1;
            };
            class ThermalBurnMedium: PunctureWound {
                effectiveness = 1;
            };
            class ThermalBurnLarge: PunctureWound {
                effectiveness = 0.5;
            };
        };
        class Burn_Dressing_wrapped: FieldDressing {
            effectiveness = 0;
            reopeningChance = 0.2;
            reopeningMinDelay = 600;
            reopeningMaxDelay = 1200;

            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 0;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 0;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0;
            };

            class Avulsion: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 0;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0;
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
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CrushMinor: Crush {
                effectiveness = 0;
            };
            class CrushMedium: Crush {
                effectiveness = 0;
            };
            class CrushLarge: Crush {
                effectiveness = 0;
            };

            class Cut: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class CutMinor: Cut {
                effectiveness = 0;
            };
            class CutMedium: Cut {
                effectiveness = 0;
            };
            class CutLarge: Cut {
                effectiveness = 0;
            };

            class Laceration: Abrasion {
                effectiveness = 0;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0;
            };

            class VelocityWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0;
            };

            class PunctureWound: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 120;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0;
            };

            class ThermalBurn: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.1;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: PunctureWound {
                effectiveness = 1;
            };
            class ThermalBurnMedium: PunctureWound {
                effectiveness = 1;
            };
            class ThermalBurnLarge: PunctureWound {
                effectiveness = 0.5;
            };
        };
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
                reopeningChance = 0.4;
                reopeningMinDelay = 150;
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
                reopeningMinDelay = 120;
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
                reopeningChance = 0.7;
                reopeningMinDelay = 90;
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