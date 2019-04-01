class CfgVehicles {
    class Item_Base_F;

    class kat_nasopharyngealItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(npa_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_nasopharyngeal,1);
        };
    };
    class kat_oropharyngealItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(opa_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_oropharyngeal,1);
        };
    };
    class kat_endotrachealItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(end_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_endotracheal,1);
        };
    };
    class kat_suctionItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(suction_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_suction,1);
        };
    };
    class kat_accuvacItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(accuvac_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };
    class BloodSplatter_01_Small_Old_F;
    class kat_vomit: BloodSplatter_01_Small_Old_F {
        displayName = CSTRING(Vomit_Display);
        hiddenSelectionsTextures[] = {QPATHTOF(ui\vomit.paa)};
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_nasopharyngeal,15);
            MACRO_ADDITEM(kat_oropharyngeal,15);
            MACRO_ADDITEM(kat_endotracheal,15);
            MACRO_ADDITEM(kat_suction,5);
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };
};
