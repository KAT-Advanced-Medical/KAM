class CfgMagazines {
    class CA_Magazine;
    
    class kat_Bubble_Wrap: CA_Magazine {
        scope = 2;
        author = "Miss Heda";
        displayName = CSTRING(Bubble_Wrap_Display);
        descriptionShort = CSTRING(Bubble_Wrap_Desc);
        picture = QPATHTOF(ui\Bubble_Wrap_Item.paa);
        
        ammo = "";
        count = 50;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 0.1;
    };

    // ------------------------ IFAK ------------------------
    //Replacement for FAK if only specific slot is used

    // 1 Slot used
    class kat_IFAK_S1_used: CA_Magazine {
        scope = 2;
        scopeArsenal = 0;
        author = "Miss Heda";
        displayName = CSTRING(IFAK_Display);
        descriptionShort = CSTRING(IFAK_DESC);
        picture = QPATHTOF(ui\IFAK.paa);
        
        ammo = "";
        count = 100;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 7.5; //Normal weight 10 but due to 1/4 Slot used -1/4 weight
    };
    class kat_IFAK_S2_used: kat_IFAK_S1_used { };
    class kat_IFAK_S3_used: kat_IFAK_S1_used { }; 
    class kat_IFAK_S4_used: kat_IFAK_S1_used { }; 

    // 2 Slots used    
    class kat_IFAK_S1_S2_used: kat_IFAK_S1_used { 
        mass = 5;
    };
    class kat_IFAK_S1_S3_used: kat_IFAK_S1_S2_used { }; 
    class kat_IFAK_S1_S4_used: kat_IFAK_S1_S2_used { }; 
    class kat_IFAK_S2_S3_used: kat_IFAK_S1_S2_used { }; 
    class kat_IFAK_S2_S4_used: kat_IFAK_S1_S2_used { }; 
    class kat_IFAK_S3_S4_used: kat_IFAK_S1_S2_used { }; 

    // 3 Slots used
    class kat_IFAK_S1_S2_S3_used: kat_IFAK_S1_used { 
        mass = 2.5;
    };
    class kat_IFAK_S2_S3_S4_used: kat_IFAK_S1_S2_S3_used { };
    class kat_IFAK_S1_S3_S4_used: kat_IFAK_S1_S2_S3_used { };
    class kat_IFAK_S1_S2_S4_used: kat_IFAK_S1_S2_S3_used { };

    //------------------------ AFAK ------------------------

    // 1 Slot used
    class kat_AFAK_S1_used: CA_Magazine {
        scope = 2;
        scopeArsenal = 0;
        author = "Miss Heda";
        displayName = CSTRING(AFAK_Display);
        descriptionShort = CSTRING(AFAK_DESC);
        picture = QPATHTOF(ui\AFAK.paa);

        ammo = "";
        count = 100;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 16.7; //default weight 20 
    };

    class kat_AFAK_S2_used: kat_AFAK_S1_used { };
    class kat_AFAK_S3_used: kat_AFAK_S1_used { };
    class kat_AFAK_S4_used: kat_AFAK_S1_used { };
    class kat_AFAK_S5_used: kat_AFAK_S1_used { }; 
    class kat_AFAK_S6_used: kat_AFAK_S1_used { }; 

    // 2 Slots used    
    class kat_AFAK_S1_S2_used: kat_AFAK_S1_used { 
        mass = 13.4;
    };
    class kat_AFAK_S1_S3_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S1_S4_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S1_S5_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S1_S6_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S2_S3_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S2_S4_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S2_S5_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S2_S6_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S3_S4_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S3_S5_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S3_S6_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S4_S5_used: kat_AFAK_S1_S2_used { };
    class kat_AFAK_S4_S6_used: kat_AFAK_S1_S2_used { }; 
    class kat_AFAK_S5_S6_used: kat_AFAK_S1_S2_used { }; 

    // 3 Slots used
    class kat_AFAK_S1_S2_S3_used: kat_AFAK_S1_used { 
        mass = 10.1;
    };
    class kat_AFAK_S1_S3_S4_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S1_S4_S5_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S1_S5_S6_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S2_S3_S4_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S2_S3_S5_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S2_S3_S6_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S3_S4_S5_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S3_S5_S6_used: kat_AFAK_S1_S2_S3_used { };
    class kat_AFAK_S4_S5_S6_used: kat_AFAK_S1_S2_S3_used { };

    // 4 Slots used
    class kat_AFAK_S1_S2_S3_S4_used: kat_AFAK_S1_used { 
        mass = 6.8;
    };
    class kat_AFAK_S1_S2_S3_S5_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S2_S3_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S2_S4_S5_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S2_S4_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S2_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S3_S4_S5_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S3_S4_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S3_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S1_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S2_S3_S4_S5_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S2_S3_S4_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S2_S3_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S2_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };
    class kat_AFAK_S3_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_used { };

    // 5 Slots used
    class kat_AFAK_S1_S2_S3_S4_S5_used: kat_AFAK_S1_used { 
        mass = 3.5;
    };
    class kat_AFAK_S1_S2_S3_S4_S6_used: kat_AFAK_S1_S2_S3_S4_S5_used { };
    class kat_AFAK_S1_S2_S3_S5_S6_used: kat_AFAK_S1_S2_S3_S4_S5_used { };
    class kat_AFAK_S1_S2_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_S5_used { };
    class kat_AFAK_S1_S3_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_S5_used { };
    class kat_AFAK_S2_S3_S4_S5_S6_used: kat_AFAK_S1_S2_S3_S4_S5_used { };

    // ------------------------ MFAK ------------------------

    // 1 Slot used
class kat_MFAK_S1_used: CA_Magazine {
    scope = 2;
    scopeArsenal = 0;
    author = "Miss Heda";
    displayName = CSTRING(MFAK_Display);
    descriptionShort = CSTRING(MFAK_DESC);
    picture = QPATHTOF(ui\MFAK.paa);

    ammo = "";
    count = 100;
    initSpeed = 0;
    tracersEvery = 0;
    lastRoundsTracer = 0;
    mass = ; // Leave this blank for 1 slot
};

class kat_MFAK_S2_used: kat_MFAK_S1_used { };
class kat_MFAK_S3_used: kat_MFAK_S1_used { };
class kat_MFAK_S4_used: kat_MFAK_S1_used { };
class kat_MFAK_S5_used: kat_MFAK_S1_used { }; 
class kat_MFAK_S6_used: kat_MFAK_S1_used { };
class kat_MFAK_S7_used: kat_MFAK_S1_used { };
class kat_MFAK_S8_used: kat_MFAK_S1_used { };

// 2 Slots used    
class kat_MFAK_S1_S2_used: kat_MFAK_S1_used { 
    mass = 13.4;
};
class kat_MFAK_S1_S3_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S1_S4_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S1_S5_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S1_S6_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S1_S7_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S1_S8_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S2_S3_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S2_S4_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S2_S5_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S2_S6_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S2_S7_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S2_S8_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S3_S4_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S3_S5_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S3_S6_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S3_S7_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S3_S8_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S4_S5_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S4_S6_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S4_S7_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S4_S8_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S5_S6_used: kat_MFAK_S1_S2_used { };
class kat_MFAK_S5_S7_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S5_S8_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S6_S7_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S6_S8_used: kat_MFAK_S1_S2_used { }; 
class kat_MFAK_S7_S8_used: kat_MFAK_S1_S2_used { };

// 3 Slots used
class kat_MFAK_S1_S2_S3_used: kat_MFAK_S1_used { 
    mass = 10.1;
};
// Continue adding all the possible combinations for 3 slots used

// 4 Slots used
class kat_MFAK_S1_S2_S3_S4_used: kat_MFAK_S1_used { 
    mass = ; // Fill in the weight for 4 slots used
};
// Continue adding all the possible combinations for 4 slots used

// 5 Slots used
class kat_MFAK_S1_S2_S3_S4_S5_used: kat_MFAK_S1_used { 
    mass = ; // Fill in the weight for 5 slots used
};
// Continue adding all the possible combinations for 5 slots used

// 6 Slots used
class kat_MFAK_S1_S2_S3_S4_S5_S6_used: kat_MFAK_S1_used { 
    mass = ; // Fill in the weight for 6 slots used
};
// Continue adding all the possible combinations for 6 slots used

// 7 Slots used
class kat_MFAK_S1_S2_S3_S4_S5_S6_S7_used: kat_MFAK_S1_used { 
    mass = ; // Fill in the weight for 7 slots used
};
// Continue adding all the possible combinations for 7 slots used


};

