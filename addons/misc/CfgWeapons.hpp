class CfgWeapons
{
    class ACE_ItemCore;
    class ACE_NVGoggles_WP;
    class CBA_MiscItem_ItemInfo;

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

    class kat_Armband_Red_Cross_NVG: ACE_NVGoggles_WP {
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        displayName = CSTRING(Armband_Red_Cross_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCross.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelections[] = {"Armband"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWC.paa)};
        class ItemInfo {
            type = 616;
            hmdType = 0;
            hiddenSelections[] = {"Armband"};
            uniformModel = QPATHTOF(models\armband\Armband.p3d);
            modelOff = QPATHTOF(models\armband\Armband.p3d);
            mass = 3;
        };
    };

    class kat_Armband_Medic_NVG: kat_Armband_Red_Cross_NVG {
        displayName = CSTRING(Armband_Medic_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCM.paa)};
    };

    class kat_Armband_Doctor_NVG: kat_Armband_Red_Cross_NVG {
        displayName = CSTRING(Armband_Doctor_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        picture = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCD.paa)};
    };

    class kat_Armband_Kat_NVG: kat_Armband_Red_Cross_NVG {
        displayName = CSTRING(Armband_Kat_ItemName);
        editorPreview = QPATHTOF(ui\ArmbandKat.paa);
        picture = QPATHTOF(ui\ArmbandKat.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandKAT.paa)};
    };

    class kat_IFAK: ACE_ItemCore {
        author = "Miss Heda";
        displayName = CSTRING(IFAK_Display);
        descriptionShort = CSTRING(IFAK_DESC);
        scope = 2;
        editorPreview = QPATHTOF(ui\IFAK.paa);
        picture = QPATHTOF(ui\IFAK.paa);
        ACE_isMedicalItem = 1;
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