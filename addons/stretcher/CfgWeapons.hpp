class CfgWeapons
{
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class kat_HeliStretcher: ACE_ItemCore {
        scope = 2;
        author = "Battlekeeper";
        picture = QPATHTOF(ui\stretcher.paa);
        displayName = CSTRING(Helistretcher_Display);
        descriptionShort = CSTRING(Helistretcher_Desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 20;
        };
    };
};