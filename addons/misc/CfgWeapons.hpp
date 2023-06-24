class CfgWeapons
{
    class ToolKit;
    class Attachable_Helistretcher: ToolKit
    {
        author = "Battlekeeper";
        picture = QPATHTOF(ui\stretcher.paa);
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

    class ItemCore;
    class kat_Armband_Red_Cross_Item: ACE_ItemCore {

        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        displayName = CSTRING(Armband_Red_Cross_ItemName);
        scope = 2;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCross.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 3;
        };
    };

    class kat_Armband_Medic_Item: kat_Armband_Red_Cross_Item {

        displayName = CSTRING(Armband_Medic_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
    };

    class kat_Armband_Doctor_Item: kat_Armband_Red_Cross_Item {

        displayName = CSTRING(Armband_Doctor_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
    };

    class kat_Armband_Kat_Item: kat_Armband_Red_Cross_Item {

        displayName = CSTRING(Armband_Kat_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandKat.paa);
        picture = QPATHTOF(ui\ArmbandKat.paa);
    };

    class kat_Bubble_Wrap_Item: ACE_ItemCore {

        author = "Miss Heda";
        displayName = CSTRING(Bubble_Wrap_Display);
        descriptionShort = CSTRING(Bubble_Wrap_Desc);
        scope = 2;
        editorPreview = QPATHTOF(ui\Bubble_Wrap_Item.paa);
        picture = QPATHTOF(ui\Bubble_Wrap_Item.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 0.1;
        };
    };
};