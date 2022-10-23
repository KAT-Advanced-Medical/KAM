class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_scalpel: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Scalpel_displayName);
        picture = QPATHTOF(ui\scalpel.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Scalpel_DescShort);
        descriptionUse = CSTRING(Scalpel_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_retractor: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Retractor_displayName);
        picture = QPATHTOF(ui\retractor.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Retractor_DescShort);
        descriptionUse = CSTRING(Retractor_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_clamp: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Clamp_displayName);
        picture = QPATHTOF(ui\clamp.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Clamp_DescShort);
        descriptionUse = CSTRING(Clamp_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_plate: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Plate_DescShort); //Not an error - it has the same description as display name
        picture = QPATHTOF(ui\plate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Plate_DescShort);
        descriptionUse = CSTRING(Plate_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.3;
        }; 
    };
    class kat_vacuum: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Vacuum_DescShort); //Not an error - it has the same description as display name
        picture = QPATHTOF(ui\vacuum.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Vacuum_DescShort);
        descriptionUse = CSTRING(Vacuum_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
};
