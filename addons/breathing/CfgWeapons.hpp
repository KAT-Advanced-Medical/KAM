class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_pulseoximeter: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(pulseoximeter_display);
        descriptionShort = CSTRING(pulseoximeter_desc);
        descriptionUse = CSTRING(pulseoximeter_desc);
        picture = QPATHTOF(ui\Pulseoximeter_normal.paa);
        model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
