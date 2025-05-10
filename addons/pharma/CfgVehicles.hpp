#define QQPATHTOF(var1) QUOTE(QPATHTOF(var1))

class CfgVehicles {
    class Item_Base_F;
    class Items_base_F;
    class WeaponHolder_Single_limited_item_F;
    class Land_Defibrillator_F: Items_base_F {
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0,1,1};
        ace_dragging_carryDirection = 270;
        ace_cargo_size = 1;
        ace_cargo_canLoad = 1;
    };

    class kat_PainkillerItem: WeaponHolder_Single_limited_item_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Painkillers_Box_Display);
        author = "Katalam";
        vehicleClass = "Magazines";
        class TransportItems {
            MACRO_ADDITEM(kat_Painkiller,1);
        };
    };

    class ACE_medicalSupplyCrate;
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems {
            MACRO_ADDITEM(kat_IV_16,20);
            MACRO_ADDITEM(kat_IO_FAST,20);
            MACRO_ADDITEM(kat_naloxone,20);
            MACRO_ADDITEM(kat_EACA,20);
            MACRO_ADDITEM(kat_TXA,20);
            MACRO_ADDITEM(kat_norepinephrine,20);
            MACRO_ADDITEM(kat_phenylephrine,20);
            MACRO_ADDITEM(kat_phenylephrineAuto,20);
            MACRO_ADDITEM(kat_nitroglycerin,20);
            MACRO_ADDITEM(kat_amiodarone,20);
            MACRO_ADDITEM(kat_lidocaine,20);
            MACRO_ADDITEM(kat_atropine,20);
            MACRO_ADDITEM(kat_ketamine,20);
            MACRO_ADDITEM(kat_fentanyl,20);
            MACRO_ADDITEM(kat_nalbuphine,20);
            MACRO_ADDITEM(kat_lorazepam,20);
            MACRO_ADDITEM(kat_flumazenil,20);
            MACRO_ADDITEM(kat_etomidate,20);
            MACRO_ADDITEM(kat_epinephrineIV,20);
            MACRO_ADDITEM(kat_coag_sense,2);
        };
        class TransportMagazines {
            MACRO_ADDMAGAZINE(kat_Painkiller,20);
            MACRO_ADDMAGAZINE(kat_Carbonate,15);
            MACRO_ADDMAGAZINE(kat_Pervitin,10);
            MACRO_ADDMAGAZINE(kat_Caffeine,15);
            MACRO_ADDMAGAZINE(kat_Penthrox,15);
        };
    };
    class kat_pharmaMedicalCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(pharmaSupplyCrate_displayName);
        class TransportItems {
            MACRO_ADDITEM(kat_naloxone,20);
            MACRO_ADDITEM(kat_EACA,20);
            MACRO_ADDITEM(kat_TXA,20);
            MACRO_ADDITEM(kat_norepinephrine,20);
            MACRO_ADDITEM(kat_phenylephrine,20);
            MACRO_ADDITEM(kat_phenylephrineAuto,20);
            MACRO_ADDITEM(kat_nitroglycerin,20);
            MACRO_ADDITEM(kat_amiodarone,20);
            MACRO_ADDITEM(kat_lidocaine,20);
            MACRO_ADDITEM(kat_atropine,20);
            MACRO_ADDITEM(kat_ketamine,20);
            MACRO_ADDITEM(kat_fentanyl,20);
            MACRO_ADDITEM(kat_nalbuphine,20);
            MACRO_ADDITEM(kat_epinephrineIV,20);
        };
        class TransportMagazines {
            MACRO_ADDMAGAZINE(kat_Pervitin,15);
            MACRO_ADDMAGAZINE(kat_Penthrox,15);
        };
    };
};