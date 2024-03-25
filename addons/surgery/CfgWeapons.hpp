class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_scalpel: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Scalpel_displayName);
        picture = QPATHTOF(ui\scalpel.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Scalpel_DescShort);
        ACE_isMedicalItem = 1;
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
        ACE_isMedicalItem = 1;
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
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_plate: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Plate_Display);
        picture = QPATHTOF(ui\plate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Plate_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.3;
        }; 
    };
    class kat_vacuum: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Vacuum_displayName);
        picture = QPATHTOF(ui\vacuum.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Vacuum_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class kat_ultrasound: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Ultra_DescShort); //Not an error - it has the same description as display name
        picture = QPATHTOF(ui\ultra.paa);
        model = "\A3\Props_F_Exp_A\Military\Equipment\Tablet_02_F.p3d";
        descriptionShort = CSTRING(Ultra_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class kat_reboa: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Reboa_DescShort); //Not an error - it has the same description as display name
        picture = QPATHTOF(ui\reboa.paa);
        model = "\A3\Structures_F_Heli\Items\Electronics\HDMICable_01_F.p3d";
        descriptionShort = CSTRING(Reboa_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};