class ACE_Medical_Treatment {
    class IV {
        class BloodIV;
        class BloodIV_500;
        class BloodIV_250;

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
    };
};
