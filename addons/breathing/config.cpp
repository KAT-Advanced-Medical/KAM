#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_PulseoximeterItem",
            "kat_chestSealItem",
            "kat_nasalItem"
        };
        weapons[] = {
            "kat_Pulseoximeter",
            "kat_chestSeal",
            "kat_stethoscope",
            "kat_nasal"
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
        authors[] = {"Katalam", "Kygan"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "CfgMoves.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "CfgSounds.hpp"
