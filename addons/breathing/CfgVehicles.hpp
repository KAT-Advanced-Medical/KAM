class CfgVehicles {
    class Item_Base_F;

    class kat_PulseoximeterItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Pulseoximeter_Desc_Short);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_Pulseoximeter,1);
        };
    };

    class kat_chestSealItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(chestseal_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_chestSeal,1);
        };
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_Pulseoximeter,3);
            MACRO_ADDITEM(kat_chestSeal,25);
            MACRO_ADDITEM(kat_aatKit,10);
            MACRO_ADDITEM(kat_stethoscope,5);
        };
    };
    class kat_basicSupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(basicSupplyCrate_display);
        class TransportItems: TransportItems {
            MACRO_ADDITEM(Attachable_Helistretcher,5);
            MACRO_ADDITEM(kat_stretcherBag,5);
            MACRO_ADDITEM(kat_accuvac,2);
            MACRO_ADDITEM(kat_guedel,15);
            MACRO_ADDITEM(kat_larynx,15);
            MACRO_ADDITEM(kat_aatKit,15);
            MACRO_ADDITEM(kat_chestSeal,15);
            MACRO_ADDITEM(kat_Pulseoximeter,2);
            MACRO_ADDITEM(kat_stethoscope,2);
            MACRO_ADDITEM(kat_IO_FAST,15);
            MACRO_ADDITEM(kat_IV_16,15);
            MACRO_ADDITEM(kat_crosspanel,2);
            MACRO_ADDITEM(KAT_Empty_bloodIV_250,7);
            MACRO_ADDITEM(KAT_Empty_bloodIV_500,7);
            MACRO_ADDITEM(kat_AED,2);
            MACRO_ADDITEM(kat_X_AED,2);
        };
        class TransportMagazines: TransportMagazines {
            MACRO_ADDMAGAZINE(kat_Carbonate,15);
            MACRO_ADDMAGAZINE(kat_Painkiller,15);
        };
    };
};
