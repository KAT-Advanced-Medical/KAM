class CfgMagazines {
    class CA_Magazine;

    class KAM_painkiller: CA_Magazine {
        author = CSTRING(AUTHOR);
        scope = 2;

        displayName = CSTRING(painkillers_display);
        descriptionShort = CSTRING(painkillers_desc);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        picture = QPATHTOF(ui\icon_painkillers.paa);

        ammo = "";
        count = 10;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;
    };
};
