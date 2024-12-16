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
    class KAT_STS: ItemWatch {
        ACE_hideItemType = "Watch";
        author = "Mazinski";        
        descriptionShort = CSTRING(STSDescription);
        displayName = CSTRING(STSDisplayName);
        picture = QPATHTOF(UI\watch_sts.paa);
    };
    class KAT_Ranger: ItemWatch {
        ACE_hideItemType = "Watch";
        author = "Mazinski";        
        descriptionShort = CSTRING(RangerDescription);
        displayName = CSTRING(RangerDisplayName);
        picture = QPATHTOF(UI\RangerWatchFace.paa);
    };
};
