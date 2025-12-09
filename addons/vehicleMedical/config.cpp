#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {"ace_interact_menu", "ace_medical", "ace_medical_treatment", "cba_settings", "kat_main"};
        author = "M3ales Cplhardcore";
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};
#include "CfgEventHandlers.hpp"
