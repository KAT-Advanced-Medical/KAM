class CfgMagazines {
    class CA_Magazine;

    class kat_oxygenTank_300: CA_Magazine {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
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
        ACE_isMedicalItem = 1;
        ACE_asItem = 1;
    };
    class kat_oxygenTank_150: CA_Magazine {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
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
        ACE_isMedicalItem = 1;
        ACE_asItem = 1;
    };
    class kat_personal_oxygen: CA_Magazine {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Mazinski";
        displayName = CSTRING(PersonalOxygen_Display);
        descriptionShort = CSTRING(PersonalOxygen_Desc_Short);
        picture = QPATHTOF(ui\oxygenTank.paa);
        
        ammo = "";
        count = 30;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 5;
        ACE_isMedicalItem = 1;
        ACE_asItem = 1;
    };
};
