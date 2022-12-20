class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_larynx: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Larynxtubus_Display);
        descriptionShort = CSTRING(Larynx_Desc_Short);
        picture = QPATHTOF(ui\larynx_normal.paa);
        model = QPATHTOF(models\larynx_tube\tube.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_guedel: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Guedeltubus_Display);
        descriptionShort =  CSTRING(Guedel_Desc_Short);
        picture = QPATHTOF(ui\guedel_normal.paa);
        model = QPATHTOF(models\guedel\guedel.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_accuvac: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= "Accuvac";
        descriptionShort = CSTRING(Accuvac_Desc_Short);
        picture = QPATHTOF(ui\accuvac_normal.paa);
        model = QPATHTOF(models\accuvac\accuvac.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 7;
        };
    };
};
