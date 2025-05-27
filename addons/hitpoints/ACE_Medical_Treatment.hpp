class ACE_Medical_Treatment {
    class Bandaging {
        class FieldDressing {
            // How effect is the bandage for treating one wounds type injury
            effectiveness = 1;
            // What is the chance and delays (in seconds) of the treated default injury reopening
            reopeningChance = 0.1;
            reopeningMinDelay = 120;
            reopeningMaxDelay = 200;

            class Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 200;
                reopeningMaxDelay = 1000;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 3;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2.5;
                reopeningChance = 0.7;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.9;
            };

            class Avulsion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 200;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.9;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.75;
            };

            class Contusion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 200;
                reopeningMaxDelay = 1000;
            };
            class CrushMinor: Crush {
                effectiveness = 1;
                reopeningChance = 0.2;
            };
            class CrushMedium: Crush {
                effectiveness = 0.7;
                reopeningChance = 0.3;
            };
            class CrushLarge: Crush {
                effectiveness = 0.6;
                reopeningChance = 0.4;
            };

            class Cut: Abrasion {
                effectiveness = 4;
                reopeningChance = 0.1;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 1000;
            };
            class CutMinor: Cut {
                effectiveness = 4;
                reopeningChance = 0.1;
            };
            class CutMedium: Cut {
                effectiveness = 3;
                reopeningChance = 0.3;
            };
            class CutLarge: Cut {
                effectiveness = 1;
                reopeningChance = 0.5;
            };

            class Laceration: Abrasion {
                effectiveness = 0.95;
                reopeningChance = 0.3;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 800;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0.95;
                reopeningChance = 0.3;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.7;
                reopeningChance = 0.5;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
                reopeningChance = 0.6;
            };

            class VelocityWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.7;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 500;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 2;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1;
            };

            class PunctureWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.5;
                reopeningMinDelay = 200;
                reopeningMaxDelay = 850;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 2;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1.3;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.9;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
            };
        };

        class PackingBandage: FieldDressing {
            class Abrasion {
                effectiveness = 3;
                reopeningChance = 0.6;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 1500;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 3;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2.5;
                reopeningChance = 0.9;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
            };

            class Avulsion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.9;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.75;
            };

            class Contusion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1000;
            };
            class CrushMinor: Crush {
                effectiveness = 1;
                reopeningChance = 0.6;
            };
            class CrushMedium: Crush {
                effectiveness = 0.7;
                reopeningChance = 0.7;
            };
            class CrushLarge: Crush {
                effectiveness = 0.6;
                reopeningChance = 0.8;
            };

            class Cut: Abrasion {
                effectiveness = 4;
                reopeningChance = 0.4;
                reopeningMinDelay = 700;
                reopeningMaxDelay = 1000;
            };
            class CutMinor: Cut {
                effectiveness = 4;
                reopeningChance = 0.6;
            };
            class CutMedium: Cut {
                effectiveness = 3;
                reopeningChance = 0.7;
            };
            class CutLarge: Cut {
                effectiveness = 1;
                reopeningChance = 0.8;
            };

            class Laceration: Abrasion {
                effectiveness = 0.95;
                reopeningChance = 0.65;
                reopeningMinDelay = 500;
                reopeningMaxDelay = 2000;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0.95;
                reopeningChance = 0.65;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.7;
                reopeningChance = 0.8;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
                reopeningChance = 0.9;
            };

            class VelocityWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 2000;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 2;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1;
            };

            class PunctureWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 3000;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 2;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1.3;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.9;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
            };
        };

        class ElasticBandage: FieldDressing {
            class Abrasion {
                effectiveness = 4;
                reopeningChance = 0.6;
                reopeningMinDelay = 80;
                reopeningMaxDelay = 150;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 4;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.9;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2.5;
                reopeningChance = 1;
            };

            class Avulsion: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.7;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 160;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 2;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 1.4;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 1;
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
                reopeningChance = 0.5;
                reopeningMinDelay = 60;
                reopeningMaxDelay = 100;
            };
            class CrushMinor: Crush {
                effectiveness = 2;
                reopeningChance = 0.6;
            };
            class CrushMedium: Crush {
                effectiveness = 1.7;
                reopeningChance = 0.7;
            };
            class CrushLarge: Crush {
                effectiveness = 1.6;
                reopeningChance = 0.8;
            };

            class Cut: Abrasion {
                effectiveness = 5;
                reopeningChance = 0.4;
                reopeningMinDelay = 70;
                reopeningMaxDelay = 100;
            };
            class CutMinor: Cut {
                effectiveness = 5;
                reopeningChance = 0.6;
            };
            class CutMedium: Cut {
                effectiveness = 3.5;
                reopeningChance = 0.7;
            };
            class CutLarge: Cut {
                effectiveness = 2;
                reopeningChance = 0.8;
            };

            class Laceration: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.65;
                reopeningMinDelay = 50;
                reopeningMaxDelay = 200;
            };
            class LacerationMinor: Laceration {
                effectiveness = 2;
                reopeningChance = 0.65;
            };
            class LacerationMedium: Laceration {
                effectiveness = 1.5;
                reopeningChance = 0.8;
            };
            class LacerationLarge: Laceration {
                effectiveness = 1;
                reopeningChance = 0.9;
            };

            class VelocityWound: Abrasion {
                effectiveness = 2.2;
                reopeningChance = 1;
                reopeningMinDelay = 80;
                reopeningMaxDelay = 200;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 2.2;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1.75;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 2.5;
                reopeningChance = 1;
                reopeningMinDelay = 100;
                reopeningMaxDelay = 300;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 2.5;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 2;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 1.5;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
            };
        };

        class QuikClot: FieldDressing {
            class Abrasion {
                effectiveness = 2;
                reopeningChance = 0.3;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 1500;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.4;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 0.7;
                reopeningChance = 0.5;
            };

            class Avulsion: Abrasion {
                effectiveness = 0.7;
                reopeningChance = 0.2;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 0.7;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.65;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.5;
            };

            class Contusion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {
                effectiveness = 0.6;
                reopeningChance = 0.5;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1000;
            };
            class CrushMinor: Crush {
                effectiveness = 0.6;
                reopeningChance = 0.3;
            };
            class CrushMedium: Crush {
                effectiveness = 0.5;
            };
            class CrushLarge: Crush {
                effectiveness = 0.4;
            };

            class Cut: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.2;
                reopeningMinDelay = 700;
                reopeningMaxDelay = 1000;
            };
            class CutMinor: Cut {
                effectiveness = 2;
            };
            class CutMedium: Cut {
                effectiveness = 1;
            };
            class CutLarge: Cut {
                effectiveness = 0.6;
            };

            class Laceration: Abrasion {
                effectiveness = 0.7;
                reopeningChance = 0.4;
                reopeningMinDelay = 500;
                reopeningMaxDelay = 2000;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0.7;
                reopeningChance = 0.4;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.7;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 2000;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 1;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 0.75;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 0.5;
            };

            class PunctureWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 3000;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 1;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 0.7;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.4;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
            };
        };
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0.25;
                reopeningChance = 0.8;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 180;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0.25;
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
                reopeningChance = 0.2;
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
                reopeningChance = 0.2;
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
                reopeningChance = 0.2;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0.25;
                reopeningChance = 0.2;
                reopeningMinDelay = 180;
                reopeningMaxDelay = 360;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0.25;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0.0;
                reopeningChance = 0.8;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 180;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
            };
            class EviscerationMinor: Evisceration {
            };
            class EviscerationMedium: Evisceration {
            };
            class EviscerationLarge: Evisceration {
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
                effectiveness = 7;

            };
            class AbrasionMedium: Abrasion {
                effectiveness = 6;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 6;
            };

            class Avulsion: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 5;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 4;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 5;
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
                effectiveness = 6;
            };
            class CrushMedium: Crush {
                effectiveness = 5;
            };
            class CrushLarge: Crush {
                effectiveness = 5;
            };

            class Cut: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class CutMinor: Cut {
                effectiveness = 5;
            };
            class CutMedium: Cut {
                effectiveness = 4;
            };
            class CutLarge: Cut {
                effectiveness = 4;
            };

            class Laceration: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class LacerationMinor: Laceration {
                effectiveness = 5;
            };
            class LacerationMedium: Laceration {
                effectiveness = 4;
            };
            class LacerationLarge: Laceration {
                effectiveness = 4;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 6;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 4;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 4;
            };

            class PunctureWound: Abrasion {
                effectiveness = 6;
                reopeningChance = 0.3;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1800;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 8;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 6;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 4;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
            };
            class EviscerationMedium: Evisceration {
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 2;
            };
        };
        class Israeli_Bandage: FieldDressing {
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
                effectiveness = 4;

            };
            class AbrasionMedium: Abrasion {
                effectiveness = 3;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 3;
            };

            class Avulsion: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.2;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 3;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 2;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 1;
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
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class CrushMinor: Crush {
                effectiveness = 3;
            };
            class CrushMedium: Crush {
                effectiveness = 2;
            };
            class CrushLarge: Crush {
                effectiveness = 2;
            };

            class Cut: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class CutMinor: Cut {
                effectiveness = 3;
            };
            class CutMedium: Cut {
                effectiveness = 2;
            };
            class CutLarge: Cut {
                effectiveness = 2;
            };

            class Laceration: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class LacerationMinor: Laceration {
                effectiveness = 3;
            };
            class LacerationMedium: Laceration {
                effectiveness = 2;
            };
            class LacerationLarge: Laceration {
                effectiveness = 2;
            };

            class VelocityWound: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 3;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 2;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 2;
            };

            class PunctureWound: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
            };
            class EviscerationMedium: Evisceration {
            };
            class EviscerationLarge: Evisceration {
            };
        };
        class Abdominal_Pad: FieldDressing {
            effectiveness = 1;
            reopeningChance = 0.2;
            reopeningMinDelay = 300;
            reopeningMaxDelay = 900;
            
            class Abrasion {
                effectiveness = 3;
                reopeningChance = 0.2;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
                effectiveness = 2;
                reopeningChance = 0.2;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 3;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 2;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 1;
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
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 3;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 2;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1;
            };

            class PunctureWound: Abrasion {
                effectiveness = 3;
                reopeningChance = 0.3;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
            };
            class EviscerationMedium: Evisceration {
            };
            class EviscerationLarge: Evisceration {
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
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class ThermalBurn: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.1;
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 0;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
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
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 1;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 1;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0.5;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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
                reopeningMinDelay = 1200;
                reopeningMaxDelay = 1800;
            };
            class ThermalBurnMinor: ThermalBurn {
                effectiveness = 1;
            };
            class ThermalBurnMedium: ThermalBurn {
                effectiveness = 1;
            };
            class ThermalBurnLarge: ThermalBurn {
                effectiveness = 0.5;
            };
            class InternalBleeding: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 900;
                reopeningMaxDelay = 1800;
            };
            class InternalBleedingMinor: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingMedium: InternalBleeding {
                effectiveness = 0;
            };
            class InternalBleedingLarge: InternalBleeding {
                effectiveness = 0;
            };
            class Evisceration: Abrasion {
                effectiveness = 0;
                reopeningChance = 0.8;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Evisceration {
                effectiveness = 0;
            };
            class EviscerationMedium: Evisceration {
                effectiveness = 0;
            };
            class EviscerationLarge: Evisceration {
                effectiveness = 0;
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

            class ThermalBurn: Abrasion {};
            class ThermalBurnMinor: ThermalBurn {};
            class ThermalBurnMedium: ThermalBurn {};
            class ThermalBurnLarge: ThermalBurn {};

            class InternalBleeding: Abrasion {};
            class InternalBleedingMinor: InternalBleeding {};
            class InternalBleedingMedium: InternalBleeding {};
            class InternalBleedingLarge: InternalBleeding {};
            
            class Evisceration: Abrasion {};
            class EviscerationMinor: Evisceration {};
            class EviscerationMedium: Evisceration {};
            class EviscerationLarge: Evisceration {};
        };

        class BloodClotMinor: FieldDressing {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.4;
                reopeningMinDelay = 300;
                reopeningMaxDelay = 900;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 2;
                reopeningChance = 0.4;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class AvulsionMinor: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class ContusionMinor: Abrasion {
                effectiveness = 0;
            };
            class CrushMinor: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class CutMinor: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class LacerationMinor: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class VelocityWoundMinor: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.6;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class PunctureWoundMinor: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.6;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class ThermalBurnMinor: Abrasion {
                effectiveness = 0;
            };
            class InternalBleedingMinor: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class EviscerationMinor: Abrasion {
                effectiveness = 0;
            };
        };

        class BloodClotMedium: FieldDressing {
             class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.5;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 1.5;
                reopeningChance = 0.5;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class AvulsionMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.8;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 900;
            };
            class ContusionMedium: Abrasion {
                effectiveness = 0;
            };
            class CrushMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 150;
                reopeningMaxDelay = 900;
            };
            class CutMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class LacerationMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class VelocityWoundMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class PunctureWoundMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class ThermalBurnMedium: Abrasion {
                effectiveness = 0;
            };
            class InternalBleedingMedium: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class EviscerationMedium: Abrasion {
            };
        };

        class BloodClotLarge: FieldDressing {
            class Abrasion {
                effectiveness = 0;
                reopeningChance = 0.7;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 600;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.6;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class AvulsionLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0.9;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class ContusionLarge: Abrasion {
                effectiveness = 1;
            };
            class CrushLarge: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.7;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class CutLarge: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.8;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class LacerationLarge: Abrasion {
                effectiveness = 0.5;
                reopeningChance = 0.8;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class VelocityWoundLarge: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.8;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class PunctureWoundLarge: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.8;
                reopeningMinDelay = 90;
                reopeningMaxDelay = 300;
            };
            class ThermalBurnLarge: Abrasion {
                effectiveness = 0;
            };
            class InternalBleedingLarge: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.8;
                reopeningMinDelay = 120;
                reopeningMaxDelay = 600;
            };
            class EviscerationLarge: Abrasion {
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
                reopeningChance = 0.2;
            };
            class AvulsionMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.5;
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
                reopeningChance = 0.4;
            };
            class PunctureWoundMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.4;
            };
            class ThermalBurnMinor: AbrasionMinor {
                effectiveness = 0;      
            };
            class InternalBleedingMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0.2;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1200;
            };
            class EviscerationMinor: AbrasionMinor {
                effectiveness = 0;
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
                reopeningChance = 0.2;
            };
            class AvulsionMedium: AbrasionMedium {
                effectiveness = 0.5;
                reopeningChance = 0.4;
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
                reopeningChance = 0.4;
            };
            class PunctureWoundMedium: AbrasionMedium {
                effectiveness = 0.5;
                reopeningChance = 0.4;
            };
            class ThermalBurnMedium: AbrasionMedium {
                effectiveness = 0;
            };
            class InternalBleedingMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0.2;
            };
            class EviscerationMedium: AbrasionMedium {
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
                reopeningChance = 0.5;
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
                reopeningChance = 0.5;
            };
            class VelocityWoundLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0.5;
            };
            class PunctureWoundLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0.4;
            };
            class ThermalBurnLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0;
            };
            class InternalBleedingLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0.3;

            };
            class EviscerationLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0.2;
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
                reopeningChance = 0.2;
            };
            class ContusionMinor: AbrasionMinor {
                effectiveness = 0;
                reopeningChance = 0.1;
            };
            class CrushMinor: AbrasionMinor {
                effectiveness = 1;
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
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class ThermalBurnMinor: AbrasionMinor {
                effectiveness = 0;      
            };
            class InternalBleedingMinor: AbrasionMinor {
                effectiveness = 1;
                reopeningChance = 0;
            };
            class EviscerationMinor: AbrasionMinor {
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
                reopeningChance = 0.2;
            };
            class ContusionMedium: AbrasionMedium {
                effectiveness = 0;
                reopeningChance = 0.1;
            };
            class CrushMedium: AbrasionMedium {
                effectiveness = 1;
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
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class ThermalBurnMedium: AbrasionMedium {
            };
            class InternalBleedingMedium: AbrasionMedium {
                effectiveness = 1;
                reopeningChance = 0;
            };
            class EviscerationMedium: AbrasionMedium {
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
                reopeningChance = 0.2;
            };
            class ContusionLarge: AbrasionLarge {
                effectiveness = 0;
            };
            class CrushLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class CutLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.1;
            };
            class LacerationLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.2;
            };
            class VelocityWoundLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.2;
            };
            class PunctureWoundLarge: AbrasionLarge {
                effectiveness = 1;
                reopeningChance = 0.2;
            };
            class ThermalBurnLarge: AbrasionLarge {
                effectiveness = 0;
            };
            class InternalBleedingLarge: AbrasionLarge {
                effectiveness = 0.5;
                reopeningChance = 0;
            };
            class EviscerationLarge: AbrasionLarge {
                effectiveness = 0.5;
            };
        };
    };
};