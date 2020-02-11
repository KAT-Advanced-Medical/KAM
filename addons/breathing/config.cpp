#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            kat_PulseoximeterItem,
            kat_chestSealItem
        };
        weapons[] = {
            kat_Pulseoximeter,
            kat_chestSeal
        };
        magazines[] = {};
        requiredAddons[] = {
            "ace_medical",
            "kat_main",
            "kat_airway",
            "kat_circulation",
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgHints.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
