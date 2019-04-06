class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class ACE_bloodIV;
    //class adv_aceCPR_AED;

    class kat_bloodIV_O: ACE_bloodIV {
        displayName = CSTRING(bloodiv_o);
    };
    class kat_bloodIV_A: ACE_bloodIV {
        displayName = CSTRING(bloodiv_a);
    };
    class kat_bloodIV_B: ACE_bloodIV {
        displayName = CSTRING(bloodiv_b);
    };
    class kat_bloodIV_AB: ACE_bloodIV {
        displayName = CSTRING(bloodiv_ab);
    };
    class ACE_bloodIV_500;
    class kat_bloodIV_O_500: ACE_bloodIV_500 {
        displayName = CSTRING(bloodiv_500_o);
    };
    class kat_bloodIV_A_500: ACE_bloodIV_500 {
        displayName = CSTRING(bloodiv_500_a);
    };
    class kat_bloodIV_B_500: ACE_bloodIV_500 {
        displayName = CSTRING(bloodiv_500_b);
    };
    class kat_bloodIV_AB_500: ACE_bloodIV_500 {
        displayName = CSTRING(bloodiv_500_ab);
    };
    class ACE_bloodIV_250;
    class kat_bloodIV_O_250: ACE_bloodIV_250 {
        displayName = CSTRING(bloodiv_250_o);
    };
    class kat_bloodIV_A_250: ACE_bloodIV_250 {
        displayName = CSTRING(bloodiv_250_a);
    };
    class kat_bloodIV_B_250: ACE_bloodIV_250 {
        displayName = CSTRING(bloodiv_250_b);
    };
    class kat_bloodIV_AB_250: ACE_bloodIV_250 {
        displayName = CSTRING(bloodiv_250_ab);
    };
    class kat_PainkillerItem: ACE_ItemCore {
        scope = 1; // no mistake, just a placeholder, cause ACE can't handle magazines. DO NOT USE!
        author = "Katalam";
        displayName = CSTRING(painkillers_display);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0;
        };
    };
    /*
    class kat_X_AED: adv_aceCPR_AED {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(X_Display);
        picture = QPATHTOF(ui\x-series.paa);
        model = QPATHTOF(models\aedx\aedx.p3d);
        descriptionShort = CSTRING(X_Desc);
        descriptionUse = CSTRING(X_Desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 40;
        };
    };
    */
    class kat_crossPanel: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(crosspanel);
        descriptionShort = CSTRING(crosspanel_desc);
        picture = QPATHTOF(ui\crosspanel.paa);
        icon = "";
        mapSize = 0.034;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };
};
