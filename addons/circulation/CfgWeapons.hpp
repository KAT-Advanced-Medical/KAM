class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class ACE_bloodIV;

    class kat_bloodIV_O_RhP: ACE_bloodIV {
        displayName = CSTRING(BloodIV_O_RhP);
    };
    class kat_bloodIV_O_RhN: ACE_bloodIV {
        displayName = CSTRING(BloodIV_O_RhN);
    };
    class kat_bloodIV_A_RhP: ACE_bloodIV {
        displayName = CSTRING(BloodIV_A_RhP);
    };
    class kat_bloodIV_A_RhN: ACE_bloodIV {
        displayName = CSTRING(BloodIV_A_RhN);
    };
    class kat_bloodIV_B_RhP: ACE_bloodIV {
        displayName = CSTRING(BloodIV_B_RhP);
    };
    class kat_bloodIV_B_RhN: ACE_bloodIV {
        displayName = CSTRING(BloodIV_B_RhN);
    };
    class kat_bloodIV_AB_RhP: ACE_bloodIV {
        displayName = CSTRING(BloodIV_AB_RhP);
    };
    class kat_bloodIV_AB_RhN: ACE_bloodIV {
        displayName = CSTRING(BloodIV_AB_RhN);
    };
    class ACE_bloodIV_500;
    class kat_bloodIV_O_500_RhP: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_O_500_RhP);
    };
    class kat_bloodIV_O_500_RhN: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_O_500_RhN);
    };
    class kat_bloodIV_A_500_RhP: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_A_500_RhP);
    };
    class kat_bloodIV_A_500_RhN: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_A_500_RhN);
    };
    class kat_bloodIV_B_500_RhP: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_B_500_RhP);
    };
    class kat_bloodIV_B_500_RhN: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_B_500_RhN);
    };
    class kat_bloodIV_AB_500_RhP: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_AB_500_RhP);
    };
    class kat_bloodIV_AB_500_RhN: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_AB_500_RhN);
    };
    class ACE_bloodIV_250;
    class kat_bloodIV_O_250_RhP: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_O_250_RhP);
    };
    class kat_bloodIV_O_250_RhN: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_O_250_RhN);
    };
    class kat_bloodIV_A_250_RhP: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_A_250_RhP);
    };
    class kat_bloodIV_A_250_RhN: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_A_250_RhN);
    };
    class kat_bloodIV_B_250_RhP: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_B_250_RhP);
    };
    class kat_bloodIV_B_250_RhN: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_B_250_RhN);
    };
    class kat_bloodIV_AB_250_RhP: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_AB_250_RhP);
    };
    class kat_bloodIV_AB_250_RhN: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_AB_250_RhN);
    };
    class KAT_Empty_bloodIV_500: ACE_bloodIV
	{
        displayName = CSTRING(FieldBloodTK500_Display);
        descriptionShort = CSTRING(FieldBloodTK_Desc);
        descriptionUse = CSTRING(FieldBloodTK_Desc);
		picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
		author = "Battlekeeper";
        hiddenSelectionsTextures[] = {QPATHTOF(ui\IVBag_blood_500ml_empty_ca.paa)};
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2;
        };
    };
	class KAT_Empty_bloodIV_250: ACE_bloodIV
	{
        displayName = CSTRING(FieldBloodTK250_Display);
        descriptionShort = CSTRING(FieldBloodTK_Desc);
        descriptionUse = CSTRING(FieldBloodTK_Desc);
		picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
		author = "Battlekeeper";
        hiddenSelectionsTextures[] = {QPATHTOF(ui\IVBag_blood_500ml_empty_ca.paa)};
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
	class kat_AED: ACE_ItemCore {
        scope = 2;
		author = "Katalam";
        displayName = "$STR_KAT_circulation_AED_DISPLAYNAME";
        picture = QPATHTOF(ui\defib.paa);
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        descriptionShort = "$STR_KAT_circulation_AED_DESCRIPTION";
        descriptionUse = "$STR_KAT_circulation_AED_DESCRIPTION";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 30;
        };
	};
    class kat_X_AED: kat_AED {
        scope = 2;
        displayName = CSTRING(X_Display);
        picture = QPATHTOF(ui\x-series.paa);
        model = QPATHTOF(models\aedx\aedx.p3d);
        descriptionShort = CSTRING(X_Desc);
        descriptionUse = CSTRING(X_Desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 40;
        };
    };
    class kat_crossPanel: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(crosspanel);
        descriptionShort = CSTRING(desc_crosspanel);
        picture = QPATHTOF(ui\crosspanel.paa);
        icon = "";
        mapSize = 0.034;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };
};
