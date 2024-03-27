class CfgMagazines {
    class CA_Magazine;

    class KAT_Eyewasher: CA_Magazine {
        author = "Katalam";
        scope = 2;

        displayName = CSTRING(eyewasher_display);
        descriptionShort = CSTRING(eyewasher_desc);
        picture = QPATHTOF(ui\icon_eyewasher.paa);

        ammo = "";
        count = 30;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
};
