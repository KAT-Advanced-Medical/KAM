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
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_Medical_Injuries.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"