class CfgWeapons
{
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class GVAR(Helistretcher): ACE_ItemCore {
        scope = 2;
        author = "Battlekeeper";
        picture = QPATHTOF(ui\stretcher.paa);
        displayName = CSTRING(Helistretcher_Display);
        descriptionShort = CSTRING(Helistretcher_Desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 20;
        };
    };

    class Launcher;
    class Launcher_Base_F: Launcher {
        class WeaponSlotsInfo;
    };

    class GVAR(CarryStretcherBag): Launcher_Base_F {
        class ADDON {
            type = "placeable";
            deployTime = 4;
            deploy = QGVAR(stretcherVehicle);
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 40;
        };
        displayName = CSTRING(Stretcher_Display);
        author = "MiszczuZPolski";
        scope = 2;
        model = QACEPATHTOF(apl,ACE_CSW_Bag.p3d);
        modes[] = {};
        picture = QPATHTOF(ui\stretcher.paa);
    };
};