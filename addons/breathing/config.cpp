#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            kat_PulseoximeterItem,
            kat_chestSealItem
        };
        weapons[] = {
            kat_Pulseoximeter,
            kat_chestSeal
        };
        magazines[] = {};
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
            "kat_main",
            "kat_airway",
            "kat_circulation",
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgHints.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
