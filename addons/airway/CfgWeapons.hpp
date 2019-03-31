class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_npa: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(npa_display);
        descriptionShort = CSTRING(npa_desc);
        descriptionUse = CSTRING(npa_desc);
        picture = QPATHTOF(ui\npa.paa);
        //model = QPATHTOF(models\larynx_tube\tube.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_opa: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(opa_display);
        descriptionShort = CSTRING(opa_desc);
        descriptionUse = CSTRING(opa_desc);
        picture = QPATHTOF(ui\opa.paa);
        model = QPATHTOF(models\opa\opa.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_end: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(end_display);
        descriptionShort = CSTRING(end_desc);
        descriptionUse = CSTRING(end_desc);
        picture = QPATHTOF(ui\end.paa);
        //model = QPATHTOF(models\end\end.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_suction: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(suction_display);
        //descriptionShort = CSTRING(Accuvac_Desc_Short);
        //descriptionUse = CSTRING(Accuvac_Desc_Use);
        picture = QPATHTOF(ui\suction.paa);
        //model = QPATHTOF(models\suction\suction.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_accuvac: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(accuvac_display);
        descriptionShort = CSTRING(accuvac_desc);
        descriptionUse = CSTRING(accuvac_desc);
        picture = QPATHTOF(ui\accuvac_normal.paa);
        model = QPATHTOF(models\accuvac\accuvac.p3d);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 7;
        };
    };
};
