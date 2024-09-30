#define KAT_bloodSample_ITEM(SAMPLEBASE,SAMPLEID) \
    class SAMPLEBASE##_##SAMPLEID: SAMPLEBASE { \
        scope = 1; \
        scopeArsenal = 0; \
        scopeCurator = 0; \
        nameID = SAMPLEID; \
    }

#define KAT_bloodResult_ITEM(RESULTBASE,RESULTID) \
    class RESULTBASE##_##RESULTID: RESULTBASE { \
        scope = 1; \
        scopeArsenal = 0; \
        scopeCurator = 0; \
        testID = RESULTID; \
    }

class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class ACE_bloodIV;

    class kat_bloodIV_O: ACE_bloodIV {
        displayName = CSTRING(BloodIV_O);
        ACE_isMedicalItem = 1;
    };
    class kat_bloodIV_O_N: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_O_N);
    };
    class kat_bloodIV_A: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_A);
    };
    class kat_bloodIV_A_N: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_A_N);
    };
    class kat_bloodIV_B: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_B);
    };
    class kat_bloodIV_B_N: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_B_N);
    };
    class kat_bloodIV_AB: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_AB);
    };
    class kat_bloodIV_AB_N: kat_bloodIV_O {
        displayName = CSTRING(BloodIV_AB_N);
    };
    class ACE_bloodIV_500;
    class kat_bloodIV_O_500: ACE_bloodIV_500 {
        displayName = CSTRING(BloodIV_O_500);
        ACE_isMedicalItem = 1;
    };
    class kat_bloodIV_O_N_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_O_500_N);
    };
    class kat_bloodIV_A_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_A_500);
    };
    class kat_bloodIV_A_N_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_A_500_N);
    };
    class kat_bloodIV_B_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_B_500);
    };
    class kat_bloodIV_B_N_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_B_500_N);
    };
    class kat_bloodIV_AB_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_AB_500);
    };
    class kat_bloodIV_AB_N_500: kat_bloodIV_O_500 {
        displayName = CSTRING(BloodIV_AB_500_N);
    };
    class ACE_bloodIV_250;
    class kat_bloodIV_O_250: ACE_bloodIV_250 {
        displayName = CSTRING(BloodIV_O_250);
        ACE_isMedicalItem = 1;
    };
    class kat_bloodIV_O_N_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_O_250_N);
    };
    class kat_bloodIV_A_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_A_250);
    };
    class kat_bloodIV_A_N_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_A_250_N);
    };
    class kat_bloodIV_B_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_B_250);
    };
    class kat_bloodIV_B_N_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_B_250_N);
    };
    class kat_bloodIV_AB_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_AB_250);
    };
    class kat_bloodIV_AB_N_250: kat_bloodIV_O_250 {
        displayName = CSTRING(BloodIV_AB_250_N);
    };
    class KAT_Empty_bloodIV_500: ACE_bloodIV
    {
        displayName = CSTRING(FieldBloodTK500_Display);
        descriptionShort = CSTRING(FieldBloodTK_Desc);
        picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
        author = "Battlekeeper";
        hiddenSelectionsTextures[] = {QPATHTOF(ui\IVBag_blood_500ml_empty_ca.paa)};
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2;
        };
    };
    class KAT_Empty_bloodIV_250: ACE_bloodIV
    {
        displayName = CSTRING(FieldBloodTK250_Display);
        descriptionShort = CSTRING(FieldBloodTK_Desc);
        picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
        author = "Battlekeeper";
        hiddenSelectionsTextures[] = {QPATHTOF(ui\IVBag_blood_500ml_empty_ca.paa)};
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_AED: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(AED_DISPLAYNAME);
        picture = QPATHTOF(ui\defib.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        descriptionShort = CSTRING(AED_DESCRIPTION);
        ACE_isMedicalItem = 1;
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
        ACE_isMedicalItem = 1;
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
    class KAT_bloodSample: ACE_ItemCore {
        author = "Mazinski";
        scope = 0;
        displayName = CSTRING(sampleItemName);
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0;
        };
    };
    class KAT_bloodResult: ACE_ItemCore {
        author = "Mazinski";
        scope = 0;
        displayName = CSTRING(resultItemName);
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        picture = QPATHTOF(ui\bloodIV_empty_ca.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0;
        };
    };
    KAT_bloodSample_ITEM(KAT_bloodSample,1);
    KAT_bloodSample_ITEM(KAT_bloodSample,2);
    KAT_bloodSample_ITEM(KAT_bloodSample,3);
    KAT_bloodSample_ITEM(KAT_bloodSample,4);
    KAT_bloodSample_ITEM(KAT_bloodSample,5);
    KAT_bloodSample_ITEM(KAT_bloodSample,6);
    KAT_bloodSample_ITEM(KAT_bloodSample,7);
    KAT_bloodSample_ITEM(KAT_bloodSample,8);
    KAT_bloodSample_ITEM(KAT_bloodSample,9);
    KAT_bloodSample_ITEM(KAT_bloodSample,10);
    KAT_bloodSample_ITEM(KAT_bloodSample,11);
    KAT_bloodSample_ITEM(KAT_bloodSample,12);
    KAT_bloodSample_ITEM(KAT_bloodSample,13);
    KAT_bloodSample_ITEM(KAT_bloodSample,14);
    KAT_bloodSample_ITEM(KAT_bloodSample,15);
    KAT_bloodSample_ITEM(KAT_bloodSample,16);
    KAT_bloodSample_ITEM(KAT_bloodSample,17);
    KAT_bloodSample_ITEM(KAT_bloodSample,18);
    KAT_bloodSample_ITEM(KAT_bloodSample,19);
    KAT_bloodSample_ITEM(KAT_bloodSample,20);
    KAT_bloodResult_ITEM(KAT_bloodResult,1);
    KAT_bloodResult_ITEM(KAT_bloodResult,2);
    KAT_bloodResult_ITEM(KAT_bloodResult,3);
    KAT_bloodResult_ITEM(KAT_bloodResult,4);
    KAT_bloodResult_ITEM(KAT_bloodResult,5);
    KAT_bloodResult_ITEM(KAT_bloodResult,6);
    KAT_bloodResult_ITEM(KAT_bloodResult,7);
    KAT_bloodResult_ITEM(KAT_bloodResult,8);
    KAT_bloodResult_ITEM(KAT_bloodResult,9);
    KAT_bloodResult_ITEM(KAT_bloodResult,10);
    KAT_bloodResult_ITEM(KAT_bloodResult,11);
    KAT_bloodResult_ITEM(KAT_bloodResult,12);
    KAT_bloodResult_ITEM(KAT_bloodResult,13);
    KAT_bloodResult_ITEM(KAT_bloodResult,14);
    KAT_bloodResult_ITEM(KAT_bloodResult,15);
    KAT_bloodResult_ITEM(KAT_bloodResult,16);
    KAT_bloodResult_ITEM(KAT_bloodResult,17);
    KAT_bloodResult_ITEM(KAT_bloodResult,18);
    KAT_bloodResult_ITEM(KAT_bloodResult,19);
    KAT_bloodResult_ITEM(KAT_bloodResult,20);
};
