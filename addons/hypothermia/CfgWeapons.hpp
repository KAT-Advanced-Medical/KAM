class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_handWarmer: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(HandWarmer_displayName);
        picture = QPATHTOF(ui\warmers.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\HeatPack_F.p3d";
        descriptionShort = CSTRING(HandWarmer_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_fluidWarmer: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(FluidWarmer_displayName);
        picture = QPATHTOF(ui\fluidWarmer.paa);
        model = "\A3\Structures_F_EPA\Items\Tools\ButaneTorch_F.p3d";
        descriptionShort = CSTRING(FluidWarmer_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        }; 
    };
    class kat_spaceBlanket: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(spaceBlanket_displayName);
        picture = QPATHTOF(ui\spaceBlanket.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\HeatPack_F.p3d";
        descriptionShort = CSTRING(spaceBlanket_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        }; 
    };
};
