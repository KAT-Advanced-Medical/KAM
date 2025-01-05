class CfgWeapons
{
    class NVGoggles;
    class kat_eyecovers_right: NVGoggles
    {
        author = "MrAdrianPL";
        displayName = CSTRING(EyeCover_Right);
        scope = 2;
        ace_nightvision_border = "";
        modelOptics = "\A3\weapons_f\reticle\optics_empty";

        picture = QPATHTOF(ui\maskSOLR.paa);
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
        hiddenSelections[] = {"eye_l","eye_r"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\eyecovers\camo1_ca.paa),""};
    };
    class kat_eyecovers_both: kat_eyecovers_right
    {
        displayName = CSTRING(EyeCover_Both);
        hiddenSelections[] = {"eye_l","eye_r"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\eyecovers\camo1_ca.paa),QPATHTOF(models\eyecovers\camo1_ca.paa)};
    };
};
