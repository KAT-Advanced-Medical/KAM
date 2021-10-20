class ACE_Medical_Treatment {
    class IV {
        class BloodIV_O {
            volume = 1000;
            ratio[] = {"Plasma", 1};
        };
        class BloodIV_A: BloodIV_O {};
        class BloodIV_B: BloodIV_O {};
        class BloodIV_AB: BloodIV_O {};
        
        class BloodIV_O_500 {
            volume = 500;
            ratio[] = {"Plasma", 1};
        };
        class BloodIV_A_500: BloodIV_O_500 {};
        class BloodIV_B_500: BloodIV_O_500 {};
        class BloodIV_AB_500: BloodIV_O_500 {};
        
        class BloodIV_O_250 {
            volume = 250;
            ratio[] = {"Plasma", 1};
        };
        class BloodIV_A_250: BloodIV_O_250 {};
        class BloodIV_B_250: BloodIV_O_250 {};
        class BloodIV_AB_250: BloodIV_O_250 {};
    };
};
