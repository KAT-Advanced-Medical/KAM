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
            "kat_Burn_Dressing"
        };
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "ace_medical",
            "ace_medical_gui",
            "ace_medical_treatment",
            "kat_gui",
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "ACE_Medical_Injuries.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "CfgFunctions.hpp"
#include "CfgWeapons.hpp"

