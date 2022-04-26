#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            QGVAR(manageAirway_module),
            QGVAR(bloodType_module),
            QGVAR(asystole_module),
            QGVAR(checkmedical_module)
        };
        weapons[] = {};
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "ace_zeus",
            "cba_settings"
        };
        author = "DiGi";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class overwrite_menuPFH {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class menuPFH {
                file = QPATHTOF(functions\fnc_menuPFH.sqf);
            };
        };
    };
};

#include "CfgVehicles.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgEventHandlers.hpp"
#include "ui\RscAttributes.hpp"