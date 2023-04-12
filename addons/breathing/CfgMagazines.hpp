class CfgMagazines {
    class CA_Magazine;
    
    class kat_oxygenTank_300: CA_Magazine {
        scope = 2;
        author = "Blue";
        displayName = CSTRING(PortableOxygenTank_300_Display);
        descriptionShort = CSTRING(PortableOxygenTank_300_Desc_Short);
        picture = QPATHTOF(ui\oxygenTank.paa);
        
        ammo = "";
        count = 200;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 20;
    };
    class kat_oxygenTank_150: CA_Magazine {
        scope = 2;
        author = "Blue";
        displayName = CSTRING(PortableOxygenTank_150_Display);
        descriptionShort = CSTRING(PortableOxygenTank_150_Desc_Short);
        picture = QPATHTOF(ui\oxygenTank.paa);
        
        ammo = "";
        count = 100;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 10;
    };
};
