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

    //Replacement for FAK if only specific slot is used
    // 1 Slot used

    class kat_IFAK_S1_used: kat_Bubble_Wrap {
        scope = 2;
        scopeArsenal = 0;
        displayName = CSTRING(IFAK_Display);
        descriptionShort = CSTRING(IFAK_DESC);
        picture = QPATHTOF(ui\IFAK.paa);
        
        count = 100;
        mass = 15; //Normal weight 20 but due to 1/4 Slot used -1/4 weight
    };

    class kat_IFAK_S2_used: kat_IFAK_S1_used { };
    class kat_IFAK_S3_used: kat_IFAK_S1_used { };
    class kat_IFAK_S4_used: kat_IFAK_S1_used { };

    // 2 Slots used    
    class kat_IFAK_S1_S2_used: kat_IFAK_1_used { 
        mass = 10;
    };

    class kat_IFAK_S1_S3_used: kat_IFAK_S1_S2_used { };
    class kat_IFAK_S1_S4_used: kat_IFAK_S1_S2_used { };
    class kat_IFAK_S2_S3_used: kat_IFAK_S1_S2_used { };
    class kat_IFAK_S2_S4_used: kat_IFAK_S1_S2_used { };
    class kat_IFAK_S3_S4_used: kat_IFAK_S1_S2_used { };

    // 3 Slots used
    class kat_IFAK_S1_S2_S3_used: kat_IFAK_S1_S2_used { 
        mass = 5;
    };
    class kat_IFAK_S2_S3_S4_used: kat_IFAK_S1_S2_S3_used { };
    class kat_IFAK_S1_S3_S4_used: kat_IFAK_S1_S2_S3_used { };
    class kat_IFAK_S1_S2_S4_used: kat_IFAK_S1_S2_S3_used { };
};
