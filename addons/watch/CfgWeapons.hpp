class CfgWeapons {
    class ItemWatch;
    class KAT_Garmin: ItemWatch {
        ACE_hideItemType = "Watch";
        author = "Mazinski";        
        descriptionShort = CSTRING(GarminDescription);
        displayName = CSTRING(GarminDisplayName);
        picture = QPATHTOF(UI\watch_garmin.paa);
    };
};
