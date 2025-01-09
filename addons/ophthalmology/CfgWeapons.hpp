class CfgWeapons
{
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_eyecovers: ACE_ItemCore {
        scope = 2;
        author = "MrAdrianPL";
        displayName = CSTRING(EyeCover_Item);
        picture = QPATHTOF(ui\icon_eyeshield.paa);
        model = QPATHTOF(models\eyecovers\kat_eyecovers.p3d);
        descriptionShort = CSTRING(EyeCover_Desc);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };

    class NVGoggles;
    class kat_eyecovers_right: NVGoggles
    {
        author = "MrAdrianPL";
        displayName = CSTRING(EyeCover_Right);
        scope = 2;
        scopeArsenal = 0;
        ace_nightvision_border = QPATHTOF(ui\RightEyeNVG.paa);
        modelOptics = "\A3\Weapons_F\empty.p3d";

        picture = QPATHTOF(ui\icon_eyeshield.paa);
        hiddenSelections[] = {"eye_l","eye_r"};
        hiddenSelectionsTextures[] = {"",QPATHTOF(models\eyecovers\camo1_ca.paa)};
        visionMode[] = {};
        class ItemInfo: ItemInfo
        {
            type = 616;
            hiddenSelections[] = {"eye_l","eye_r"};
            uniformModel = QPATHTOF(models\eyecovers\kat_eyecovers.p3d);
            modelOff = QPATHTOF(models\eyecovers\kat_eyecovers.p3d);
            mass = 0.1;
        };
    };
    class kat_eyecovers_left: kat_eyecovers_right
    {
        displayName = CSTRING(EyeCover_Left);
        ace_nightvision_border = QPATHTOF(ui\LeftEyeNVG.paa);
        modelOptics = "\A3\Weapons_F\empty.p3d";
        hiddenSelections[] = {"eye_l","eye_r"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\eyecovers\camo1_ca.paa),""};
    };
};
