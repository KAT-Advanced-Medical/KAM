class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_Pulseoximeter: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Pulseoximeter_Desc_Short);
        descriptionShort = CSTRING(Pulseoximeter_Desc_Short);
        descriptionUse = CSTRING(Pulseoximeter_Desc_Use);
        picture = QPATHTOF(ui\Pulseoximeter_normal.paa);
        model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_chestSeal: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(chestseal_display);
        descriptionShort = CSTRING(chestseal_desc);
        descriptionUse = CSTRING(chestseal_desc);
        picture = QPATHTOF(ui\chest-seal.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_arsKit: ACE_ItemCore {
        scope = 2;
        author = "Kygan";
        displayName= CSTRING(arsKit_display);
        descriptionShort = CSTRING(arsKit_desc);
        descriptionUse = CSTRING(arsKit_desc);
        picture = QPATHTOF(ui\auto_injector.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
