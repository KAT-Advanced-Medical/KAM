#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
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
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Injuries.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "CfgFunctions.hpp"
#include "CfgWeapons.hpp"

