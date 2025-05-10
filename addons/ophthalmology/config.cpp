#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {
            "KAT_Eyewasher"
        };
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "kat_feedback",
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam", "MiszczuZPolski", "Mazinski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "RscTitles.hpp"
