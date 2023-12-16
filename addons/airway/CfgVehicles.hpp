class CfgVehicles {
    class Item_Base_F;

    class kat_larynxItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Larynxtubus_Display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_larynx,1);
        };
    };
    class kat_guedelItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Guedeltubus_Display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_guedel,1);
        };
    };
    class kat_accuvacItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Accuvac_Display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };
    class kat_suctionItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Suction_Display);
        author = "Apricot_ale";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_suction,1);
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
            MACRO_ADDITEM(kat_larynx,15);
            MACRO_ADDITEM(kat_guedel,15);
            MACRO_ADDITEM(kat_suction,15);
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };
};
