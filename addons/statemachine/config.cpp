#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ace_medical_vitals",
            "ace_medical_statemachine"
        };
        author = "apo_tle";
        authors[] = {"Glowbal", "KoffeinFlummi","apo_tle"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "Statemachine.hpp"
#include "CfgEventHandlers.hpp"