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
    class kat_Armband_Red_Cross_Item: ItemCore {

        detectRange = -1;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        simulation = "ItemMineDetector";
        displayName = CSTRING(Armband_Red_Cross_ItemName);
        scope = 2;
        cost = 2;
        side = 3;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCross.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 3;
        };
    };

    class kat_Armband_Medic_Item: ItemCore {

        detectRange = -1;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        simulation = "ItemMineDetector";
        displayName = CSTRING(Armband_Medic_ItemName);
        scope = 2;
        cost = 2;
        side = 3;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 3;
        };
    };

    class kat_Armband_Doctor_Item: ItemCore {

        detectRange = -1;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        simulation = "ItemMineDetector";
        displayName = CSTRING(Armband_Doctor_ItemName);
        scope = 2;
        cost = 2;
        side = 3;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 3;
        };
    };

    class kat_Armband_Kat_Item: ItemCore {

        detectRange = -1;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        simulation = "ItemMineDetector";
        displayName = CSTRING(Armband_Kat_ItemName);
        scope = 2;
        cost = 2;
        side = 3;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandKat.paa);
        picture = QPATHTOF(ui\ArmbandKat.paa);
        class ItemInfo: InventoryItem_Base_F {
            mass = 3;
        };
    };
};