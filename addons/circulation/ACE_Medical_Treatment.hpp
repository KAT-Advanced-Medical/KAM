class ACE_Medical_Treatment {
    class IV {
        volume = 1000;
        ratio[] = {};
        type = "Blood";
        viscosity = 0.9;
        class BloodIV {
            volume = 1000;
            ratio[] = {"Plasma", 1};
            viscosity = 0.9;
        };
        class BloodIV_500: BloodIV {
            volume = 500;
            viscosity = 0.9;
        };
        class BloodIV_250: BloodIV {
            volume = 250;
            viscosity = 0.9;
        };
        class PlasmaIV: BloodIV {
            volume = 1000;
            ratio[] = {"Blood", 1};
            type = "Plasma";
            viscosity = 1;
        };
        class PlasmaIV_500: PlasmaIV {
            volume = 500;
            viscosity = 1;
        };
        class PlasmaIV_250: PlasmaIV {
            volume = 250;
            viscosity = 1;
        };
        class SalineIV: BloodIV {
            volume = 1000;
            type = "Saline";
            ratio[] = {};
            viscosity = 1.3;
        };
        class SalineIV_500: SalineIV {
            volume = 500;
            viscosity = 1.3;
        };
        class SalineIV_250: SalineIV {
            volume = 250;
            viscosity = 1.3;
        };

        class BloodIV_O: BloodIV {
            volume = 1000;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_O_N: BloodIV {
            volume = 1000;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_A: BloodIV {
            volume = 1000;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_A_N: BloodIV {
            volume = 1000;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_B: BloodIV {
            volume = 1000;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_B_N: BloodIV {
            volume = 1000;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_AB: BloodIV {
            volume = 1000;
            bloodType = "AB";
            compatibility[] = {"AB"};
            viscosity = 0.9;
        };
        class BloodIV_AB_N: BloodIV {
            volume = 1000;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
            viscosity = 0.9;
        };

        class BloodIV_O_500: BloodIV_500 {
            volume = 500;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_O_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_A_500: BloodIV_500 {
            volume = 500;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
            viscosity = 0.9;
        };
            class BloodIV_A_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_B_500: BloodIV_500 {
            volume = 500;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_B_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_AB_500: BloodIV_500 {
            volume = 500;
            bloodType = "AB";
            compatibility[] = {"AB"};
            viscosity = 0.9;
        };
        class BloodIV_AB_N_500: BloodIV_500 {
            volume = 500;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
            viscosity = 0.9;
        };

        class BloodIV_O_250: BloodIV_250 {
            volume = 250;
            bloodType = "O";
            compatibility[] = {"O", "A", "B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_O_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "O_N";
            compatibility[] = {"O", "O_N", "A", "A_N", "B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_A_250: BloodIV_250 {
            volume = 250;
            bloodType = "A";
            compatibility[] = {"A", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_A_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "A_N";
            compatibility[] = {"A", "A_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_B_250: BloodIV_250 {
            volume = 250;
            bloodType = "B";
            compatibility[] = {"B", "AB"};
            viscosity = 0.9;
        };
        class BloodIV_B_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "B_N";
            compatibility[] = {"B","B_N", "AB", "AB_N"};
            viscosity = 0.9;
        };
        class BloodIV_AB_250: BloodIV_250 {
            volume = 250;
            bloodType = "AB";
            compatibility[] = {"AB"};
            viscosity = 0.9;
        };
        class BloodIV_AB_N_250: BloodIV_250 {
            volume = 250;
            bloodType = "AB_N";
            compatibility[] = {"AB","AB_N"};
            viscosity = 0.9;
        };
        class RingersLactateIV: SalineIV {
            volume = 1000;
            viscosity = 1.3;
            type = "Ringers Lactate";
        };
        class RingersLactateIV_500: SalineIV_500 {
            volume = 500;
            viscosity = 1.3;
            type = "Ringers Lactate";
        };
        class RingersLactateIV_250: SalineIV_250 {
            volume = 250;
            viscosity = 1.3;
            type = "Ringers Lactate";
        };
        class PackedRBC_500: BloodIV_500 {
            volume = 500;
            viscosity = 0.7;
            type = "PackedRBC";
        };
        class PackedRBC_250: BloodIV_250 {
            volume = 250;
            viscosity = 0.7;
            type = "PackedRBC";
        };
    };
};
