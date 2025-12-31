#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "ace_advanced_fatigue",
            "ace_dogtags",
            "cba_settings",
            "cba_main",
			"cba_xeh"
        };
        author = "Cplhardcore";
        authors[] = {"Cplhardcore"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};
#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"

