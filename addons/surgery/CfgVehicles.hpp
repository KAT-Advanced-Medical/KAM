#define QQPATHTOF(var1) QUOTE(QPATHTOF(var1))

class CfgVehicles {
    class Item_Base_F;
    class Items_base_F;
    class WeaponHolder_Single_limited_item_F;
    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
        class TransportMagazines;
    };

    class kat_surgerySupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(surgeryToolbox);
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_etomidate,15);
            MACRO_ADDITEM(kat_flumazenil,15);
            MACRO_ADDITEM(kat_lorazepam,15);
            MACRO_ADDITEM(kat_clamp,3);
            MACRO_ADDITEM(kat_plate,15);
            MACRO_ADDITEM(kat_retractor,3);
            MACRO_ADDITEM(kat_scalpel,3);
            MACRO_ADDITEM(kat_vacuum,3);
        };
    };
};
