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

    class kat_IFAK_Magazine: CA_Magazine {
        scope = 2;
        scopeArsenal = 0;
        author = "Miss Heda";
        displayName = CSTRING(IFAK_Display);
        descriptionShort = CSTRING(IFAK_DESC);
        picture = QPATHTOF(ui\IFAK.paa);
        
        ammo = "";
        count = 15;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 15;
    };

    class kat_AFAK_Magazine: CA_Magazine {
        scope = 2;
        scopeArsenal = 0;
        author = "Miss Heda";
        displayName = CSTRING(AFAK_Display);
        descriptionShort = CSTRING(AFAK_DESC);
        picture = QPATHTOF(ui\AFAK.paa);

        ammo = "";
        count = 63;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 25;
    };

    class kat_MFAK_Magazine: CA_Magazine {
        scope = 2;
        scopeArsenal = 0;
        author = "Miss Heda";
        displayName = CSTRING(MFAK_Display);
        descriptionShort = CSTRING(MFAK_DESC);
        picture = QPATHTOF(ui\MFAK.paa);

        ammo = "";
        count = 255;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 50;
    };
};

