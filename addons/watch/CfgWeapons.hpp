class CfgWeapons {
    class ItemWatch;
    class KAT_Katmin: ItemWatch {
        ACE_hideItemType = "Watch";
        author = "Mazinski";        
        descriptionShort = CSTRING(KatminDescription);
        displayName = CSTRING(KatminDisplayName);
        picture = QPATHTOF(UI\watch_katmin.paa);
    };
    class KAT_Cavmin: ItemWatch {
        ACE_hideItemType = "Watch";
        author = "Mazinski";        
        descriptionShort = CSTRING(CavminDescription);
        displayName = CSTRING(CavminDisplayName);
        picture = QPATHTOF(UI\watch_cavmin.paa);
    };
};
