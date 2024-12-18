#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"kat_main", "rhsusf_main_loadorder"};
        skipWhenMissingDependencies = 1;
        author = "Katalam";
        authors[] = {"MiszczuZPolski", "Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"

