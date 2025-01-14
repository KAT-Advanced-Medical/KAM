#define QQPATHTOF(var1) QUOTE(QPATHTOF(var1))

class CfgVehicles {
    class Item_Base_F;
    class Items_base_F;
    class WeaponHolder_Single_limited_item_F;
    class ACE_medicalSupplyCrate;

    class kat_surgerySupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(surgeryToolbox);
        class TransportItems {
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
