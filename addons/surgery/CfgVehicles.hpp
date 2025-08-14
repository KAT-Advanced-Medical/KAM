#define QQPATHTOF(var1) QUOTE(QPATHTOF(var1))

class CfgVehicles {
    class ACE_medicalSupplyCrate;
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems {
            MACRO_ADDITEM(kat_scalpel,5);
            MACRO_ADDITEM(kat_retractor,5);
            MACRO_ADDITEM(kat_clamp,5);
            MACRO_ADDITEM(kat_plate,15);
            MACRO_ADDITEM(kat_vacuum,15);
            MACRO_ADDITEM(kat_ultrasound,5);
            MACRO_ADDITEM(kat_reboa,10);
        };
    };
    class kat_surgerySupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(surgeryToolbox);
        class TransportItems {
            MACRO_ADDITEM(kat_etomidate,15);
            MACRO_ADDITEM(kat_flumazenil,15);
            MACRO_ADDITEM(kat_lorazepam,15);
            MACRO_ADDITEM(kat_clamp,5);
            MACRO_ADDITEM(kat_plate,15);
            MACRO_ADDITEM(kat_retractor,5);
            MACRO_ADDITEM(kat_scalpel,5);
            MACRO_ADDITEM(kat_vacuum,15);
        };
    };
};
