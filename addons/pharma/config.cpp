#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_PainkillerItem",
            "kat_X_AEDItem"
        };
        weapons[] = {
            "kat_Painkiller",
            "kat_PainkillerItem",
            "kat_IV_16",
            "kat_IV_14",
            "kat_IV_20",
            "kat_10ml_syringe",
            "kat_5ml_syringe",
            "kat_IO_FAST",
            "kat_Carbonate",
            "kat_CarbonateItem",
            "kat_naloxone",
            "kat_phenylephrineAuto",
            "kat_X_AED",
            "kat_EACA",
            "kat_TXA",
            "kat_norepinephrine",
            "kat_phenylephrine",
            "kat_nitroglycerin",
            "kat_amiodarone",
            "kat_lidocane",
            "kat_atropine",
            "kat_ketamine",
            "kat_fentanyl",
            "kat_nalbuphine",
            "kat_flumazenil",
            "kat_lorazepam",
            "kat_etomidate",
            "kat_epinephrineIV",
            "kat_syringe_txa_10ml_1",
            "kat_syringe_txa_5ml_1",
            "kat_syringe_txa_10ml_2",
            "kat_syringe_txa_5ml_2",
            "kat_syringe_eaca_5ml_1",
            "kat_syringe_eaca_5ml_2",
            "kat_syringe_lidocaine_10ml_1",
            "kat_syringe_ketamine_10ml_1",
            "kat_syringe_ketamine_10ml_2",
            "kat_syringe_fentanyl_10ml_1",
            "kat_syringe_fentanyl_10ml_2",
            "kat_syringe_nalbuphine_10ml_1",
            "kat_syringe_nalbuphine_10ml_2",
            "kat_syringe_norepinephrine_5ml_1",
            "kat_syringe_norepinephrine_5ml_2",
            "kat_syringe_phenylephrine_5ml_1",
            "kat_syringe_phenylephrine_5ml_2",
            "kat_syringe_nitroglycerin_5ml_1",
            "kat_syringe_nitroglycerin_5ml_2",
            "kat_syringe_amiodarone_5ml_1",
            "kat_syringe_amiodarone_5ml_2",
            "kat_syringe_epinephrineIV_5ml_1",
            "kat_syringe_epinephrineIV_5ml_2",
            "kat_syringe_lidocaine_5ml_1",
            "kat_syringe_lidocaine_5ml_2",
            "kat_syringe_ketamine_5ml_1",
            "kat_syringe_ketamine_5ml_2",
            "kat_syringe_fentanyl_5ml_1",
            "kat_syringe_fentanyl_5ml_2",
            "kat_syringe_nalbuphine_5ml_1",
            "kat_syringe_nalbuphine_5ml_2",
            "kat_syringe_lorazepam_5ml_1",
            "kat_syringe_lorazepam_5ml_2",
            "kat_syringe_flumazenil_5ml_1",
            "kat_syringe_flumazenil_5ml_2",
            "kat_syringe_etomidate_5ml_1",
            "kat_syringe_etomidate_5ml_2",
            "kat_syringe_epinephrineIV_5ml_1",
            "kat_syringe_epinephrineIV_5ml_2",
        };
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "ace_medical",
            "ace_medical_ai",
            "ace_medical_blood",
            "ace_medical_damage",
            "ace_medical_engine",
            "ace_medical_feedback",
            "ace_medical_gui",
            "ace_medical_statemachine",
            "ace_medical_status",
            "ace_medical_treatment",
            "ace_medical_vitals",
            "ace_dogtags",
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam", "Mazinski", "MiszczuZPolski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
