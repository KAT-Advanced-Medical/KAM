#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_PainkillerItem",
        };
        weapons[] = {
            "kat_IV_16",
            "kat_IV_14",
            "kat_IV_20",
            "kat_10ml_syringe",
            "kat_5ml_syringe",
            "kat_IO_FAST",
            "kat_naloxone",
            "kat_phenylephrineAuto",
            "kat_EACA",
            "kat_TXA",
            "kat_norepinephrine",
            "kat_phenylephrine",
            "kat_nitroglycerin",
            "kat_amiodarone",
            "kat_lidocaine",
            "kat_atropine",
            "kat_ketamine",
            "kat_fentanyl",
            "kat_nalbuphine",
            "kat_flumazenil",
            "kat_lorazepam",
            "kat_etomidate",
            "kat_epinephrineIV",
            "kat_succinylcholine",
            "kat_rocuronium",
            "kat_sugammadex",
            "kat_morphineIV",
            "kat_ondansetron",
            "kat_adenosineIV",
            "kat_alteplase",
            "kat_doxapram",
            "kat_coag_sense",
            "kat_fentPatch",
            "kat_diazepam",
            "kat_metoprolol",
            "kat_calciumGluconate",
            "kat_calciumChloride",
            "kat_atropineIV",
            "kat_TXAAuto",
            "kat_EZ_IO",
            "kat_EJV",
            "kat_pressureBag",
            "kat_calciumChloride",
            "kat_bicarbonate"
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
