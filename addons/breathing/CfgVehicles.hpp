class CfgVehicles {
    class Item_Base_F;

    class kat_pulseoximeterItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(pulseoximeter_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_pulseoximeter,1);
        };
    };
    class NATO_Box_Base;
        class ACE_medicalSupplyCrate: NATO_Box_Base {
            class TransportItems;
        };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_pulseoximeter,3);
        };
    };
};
