#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = { };
        weapons[] = { };
        magazines[] = {};
        requiredAddons[] = {
            "KAM_acemisc",
            "rhs_usaf"
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
