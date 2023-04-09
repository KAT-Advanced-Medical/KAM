class CfgMagazines {
    class CA_Magazine;
    
    class kat_oxygenTank_300: CA_Magazine {
        scope = 2;
        author = "Blue";
        displayName = "Portable Oxygen Tank (300L)";
        descriptionShort = "Portable Oxygen Tank, containing 300L of oxygen\n Connect to BVM to further assist with breathing of critical patients"; //CSTRING(PocketBVM_Desc_Short);
        //model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        picture = QPATHTOF(ui\oxygenTank.paa);
        
        ammo = "";
        count = 400;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 20;
    };
    class kat_oxygenTank_150: CA_Magazine {
        scope = 2;
        author = "Blue";
        displayName = "Portable Oxygen Tank (150L)";
        descriptionShort = "Portable Oxygen Tank, containing 150L of oxygen\n Connect to BVM to further assist with breathing of critical patients"; //CSTRING(PocketBVM_Desc_Short);
        //model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        picture = QPATHTOF(ui\oxygenTank.paa);
        
        ammo = "";
        count = 200;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 10;
    };
};
