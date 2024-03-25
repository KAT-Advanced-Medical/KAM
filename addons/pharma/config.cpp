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
            "kat_IO_FAST",
            "kat_Carbonate",
            "kat_CarbonateItem",
            "kat_naloxone",
            "kat_EACA",
            "kat_TXA",
            "kat_X_AED",
            "kat_norepinephrine",
            "kat_phenylephrine",
            "kat_phenylephrineAuto",
            "kat_nitroglycerin",
            "kat_amiodarone",
            "kat_lidocane",
            "kat_atropine",
            "kat_ketamine",
            "kat_fentanyl",
            "kat_nalbuphine",
            "kat_flumazenil",
            "kat_lorazepam",
            "kat_etomidate"
        };
        magazines[] = { };
        requiredAddons[] = {
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