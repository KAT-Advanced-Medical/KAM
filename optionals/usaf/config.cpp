#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = { };
        weapons[] = { };
        magazines[] = {};
        requiredAddons[] = {
            "kam_misc",
            "rhs_usaf"
        };
        author = CSTRING(AUTHOR);
        authors[] = {CSTRING(AUTHOR)};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
