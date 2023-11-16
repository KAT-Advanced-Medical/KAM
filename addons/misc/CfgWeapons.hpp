class CfgWeapons
{
    class ToolKit;
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class Attachable_Helistretcher: ToolKit {
        author = "Battlekeeper";
        picture = QPATHTOF(ui\stretcher.paa);
        displayName = CSTRING(Helistretcher_Display);
        descriptionShort = CSTRING(Helistretcher_Desc);
        class ItemInfo {
            mass = 20;
            uniformModel = "\A3\Weapons_F\Items\Toolkit";
            type = 620;
            allowedSlots[] = {801,701,901};
            scope = 0;
        };
    };

    class kat_Armband_Red_Cross_Item: ACE_ItemCore {
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        displayName = CSTRING(Armband_Red_Cross_ItemName);
        scope = 2;
        model = QPATHTOF(models\armband\armband.p3d);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCross.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
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
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };

    class kat_IFAK: ACE_ItemCore {
        author = "Miss Heda";
        displayName = CSTRING(IFAK_Display);
        descriptionShort = CSTRING(IFAK_DESC);
        scope = 2;
        editorPreview = QPATHTOF(ui\IFAK.paa);
        picture = QPATHTOF(ui\IFAK.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 15;
        };
    };

    class kat_AFAK: kat_IFAK {
        displayName = CSTRING(AFAK_Display);
        descriptionShort = CSTRING(AFAK_DESC);
        editorPreview = QPATHTOF(ui\AFAK.paa);
        picture = QPATHTOF(ui\AFAK.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 25;
        };
    };

    class kat_MFAK: kat_IFAK {
        displayName = CSTRING(MFAK_Display);
        descriptionShort = CSTRING(MFAK_DESC);
        editorPreview = QPATHTOF(ui\MFAK.paa);
        picture = QPATHTOF(ui\MFAK.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 50;
        };
    };
};