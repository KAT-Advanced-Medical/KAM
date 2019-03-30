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
};
