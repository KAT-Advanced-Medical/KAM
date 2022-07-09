class CfgWeapons
{
    class ToolKit;
    class Attachable_Helistretcher: ToolKit
    {
        author = "Battlekeeper";
        picture = QPATHTOF(img\stretcher.paa);
        displayName = CSTRING(Helistretcher_Display);
        descriptionShort = CSTRING(Helistretcher_Desc);
        class ItemInfo
        {
            mass = 20;
            uniformModel = "\A3\Weapons_F\Items\Toolkit";
            type = 620;
            allowedSlots[] = {801,701,901};
            scope = 0;
        };
    };
};