#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {
            "kat_Hemostatic_Injector",
            "kat_Elastic_Wrap",
            "kat_4X4_Gauze",
            "kat_Compressed_Gauze",
            "kat_Roller_Gauze",
            "kat_Abdominal_Pad",
            "kat_ETD",
            "kat_Hemostatic_Gauze",
            "kat_Adhesive_Bandage",
            "kat_Burn_Dressing",
            "kat_Israeli_Bandage",
            "kat_Ice_Pack",
            "kat_Pelvic_Binder"

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
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};
#include "CfgVehicles.hpp"
#include "ACE_Medical_Injuries.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "CfgFunctions.hpp"
#include "CfgWeapons.hpp"
#include "CfgEventHandlers.hpp"

