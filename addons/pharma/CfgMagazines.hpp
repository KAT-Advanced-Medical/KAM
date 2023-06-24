class CfgMagazines {
    class CA_Magazine;

    class kat_Painkiller: CA_Magazine {
        author = "Katalam";
        scope = 2;

        displayName = CSTRING(Painkillers_Box_Display);
        descriptionShort = CSTRING(Painkillers_DescShort);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        picture = QPATHTOF(ui\icon_painkillers.paa);

        ammo = "";
        count = 10;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
    class kat_Carbonate: CA_Magazine {
        author = "Katalam";
        scope = 2;

        displayName = CSTRING(Carbonate_Box_Display);
        descriptionShort = CSTRING(Carbonate_DescShort);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        picture = QPATHTOF(ui\icon_Carbonate.paa);

        ammo = "";
        count = 10;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
    class kat_Pervitin: CA_Magazine {
        author = "Miss Heda";
        
        scope = 2;
        displayName = CSTRING(Pervitin_Capsule_Display);
        descriptionShort = CSTRING(Pervitin_Capsule_DescShort);
        model = QPATHTOF(models\pervitin\pervitin.p3d);
        picture = QPATHTOF(ui\icon_Pervitin.paa);

        ammo = "";
        count = 8;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
    class kat_Caffeine: CA_Magazine {
        author = "Miss Heda";
        
        scope = 2;
        displayName = CSTRING(Caffeine_Bottle_Display);
        descriptionShort = CSTRING(Caffeine_Bottle_DescShort);
        model = QPATHTOF(models\caffeine\caffeine.p3d);
        picture = QPATHTOF(ui\icon_Caffeine.paa);

        ammo = "";
        count = 15;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
};
