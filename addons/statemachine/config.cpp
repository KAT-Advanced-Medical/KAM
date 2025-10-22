#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "ace_medical",
            "ace_medical_statemachine"
        };
        author = "Mazinski";
        authors[] = {"Mazinski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "Statemachine.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
