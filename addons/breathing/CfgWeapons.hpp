class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class KAM_pulseoximeter: ACE_ItemCore {
        scope = 2;
        author = CSTRING(AUTHOR);
        displayName = CSTRING(pulseoximeter_display);
        descriptionShort = CSTRING(pulseoximeter_desc);
        descriptionUse = CSTRING(pulseoximeter_desc);
        picture = QPATHTOF(ui\Pulseoximeter_normal.paa);
        model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class KAM_bvm: ACE_ItemCore {
        scope = 2;
        author = CSTRING(AUTHOR);
        displayName = CSTRING(bvm_display);
        descriptionShort = CSTRING(bvm_desc);
        descriptionUse = CSTRING(bvm_desc);
        //picture = QPATHTOF(ui\bvm_normal.paa);
        //model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class KAM_oxygen: ACE_ItemCore {
        scope = 2;
        author = CSTRING(AUTHOR);
        displayName = CSTRING(oxygen_display);
        descriptionShort = CSTRING(oxygen_desc);
        descriptionUse = CSTRING(oxygen_desc);
        //picture = QPATHTOF(ui\oxygen_normal.paa);
        //model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class KAM_needle: ACE_ItemCore {
        scope = 2;
        author = CSTRING(AUTHOR);
        displayName = CSTRING(needle_display);
        descriptionShort = CSTRING(needle_desc);
        descriptionUse = CSTRING(needle_desc);
        //picture = QPATHTOF(ui\needle_normal.paa);
        //model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
};
