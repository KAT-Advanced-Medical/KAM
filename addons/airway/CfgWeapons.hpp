class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_larynx: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Larynxtubus_Display);
        descriptionShort = CSTRING(Larynx_Desc_Short);
        picture = QPATHTOF(ui\larynx_normal.paa);
        model = QPATHTOF(models\larynx_tube\tube.p3d);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_guedel: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Guedeltubus_Display);
        descriptionShort =  CSTRING(Guedel_Desc_Short);
        picture = QPATHTOF(ui\guedel_normal.paa);
        model = QPATHTOF(models\guedel\guedel.p3d);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_NPA: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(NPA_Display);
        descriptionShort =  CSTRING(NPA_Desc_Short);
        picture = QPATHTOF(ui\npa.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_IGEL: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(IGEL_Display);
        descriptionShort =  CSTRING(IGEL_Desc_Short);
        picture = QPATHTOF(ui\igel.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_laryngoscope: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(laryngoscope_Display);
        descriptionShort =  CSTRING(laryngoscope_Desc_Short);
        picture = QPATHTOF(ui\Laryngoscope.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
    class kat_ETT: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(ETT_Display);
        descriptionShort =  CSTRING(ETT_Desc_Short);
        picture = QPATHTOF(ui\ETT.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2.5;
        };
    };
    class kat_accuvac: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(Accuvac_Display);
        descriptionShort = CSTRING(Accuvac_Desc_Short);
        picture = QPATHTOF(ui\accuvac_normal.paa);
        model = QPATHTOF(models\accuvac\accuvac.p3d);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 7;
        };
    };
    class kat_suction: ACE_ItemCore {
        scope = 2;
        author = "Apricot_ale";
        displayName= CSTRING(Suction_Display);
        descriptionShort = CSTRING(Suction_Desc_Short);
        picture = QPATHTOF(ui\suction_normal.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_crikeKit: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= CSTRING(CrikeKit_Display);
        descriptionShort =  CSTRING(CrikeKit_Desc_Short);
        picture = QPATHTOF(ui\CrikeKit.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2.5;
        };
    };
    class kat_surgAirway: ACE_ItemCore {
        scope = 1;
        author = "Katalam";
        displayName= CSTRING(SurgAirway_Display);
        descriptionShort =  CSTRING(SurgAirway_Desc_Short);
        picture = QPATHTOF(ui\SurgAirway.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_airwayStrap: ACE_ItemCore {
        scope = 1;
        author = "Katalam";
        displayName= CSTRING(AirwayStrap_Display);
        descriptionShort =  CSTRING(AirwayStrap_Desc_Short);
        picture = QPATHTOF(ui\AirwayStrap.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
};
