class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_Pulseoximeter: ACE_ItemCore {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Katalam";
        displayName= CSTRING(Pulseoximeter_Desc_Short);
        descriptionShort = CSTRING(Pulseoximeter_Desc_Short);
        picture = QPATHTOF(ui\Pulseoximeter_normal.paa);
        model = QPATHTOF(models\pulseox\pulseox.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_chestSeal: ACE_ItemCore {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Katalam";
        displayName= CSTRING(chestseal_display);
        descriptionShort = CSTRING(chestseal_desc);
        picture = QPATHTOF(ui\chest-seal.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_aatKit: ACE_ItemCore {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Kygan";
        displayName= CSTRING(aatKit_display);
        descriptionShort = CSTRING(aatKit_desc);
        picture = QPATHTOF(ui\surgical_airway_kit.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class kat_ncdKit: ACE_ItemCore {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Miss Heda";
        displayName= CSTRING(ncdKit_display);
        descriptionShort = CSTRING(ncdKit_desc);
        picture = QPATHTOF(ui\ndcKit.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2;
        };
    };
    class kat_stethoscope: ACE_ItemCore    {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Battlekeeper";
        displayName= CSTRING(Stethoscope_display);
        descriptionShort= CSTRING(Stethoscope_desc);
        picture = QPATHTOF(ui\steth.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
};
