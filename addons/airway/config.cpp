#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            kat_nasopharyngealItem,
            kat_oropharyngealItem,
            kat_endotrachealItem,
            kat_suctionItem,
            kat_accuvacItem,
            kat_vomit
        };
        weapons[] = {
            kat_nasopharyngeal,
            kat_oropharyngeal,
            kat_endotracheal,
            kat_suction,
            kat_accuvac
        };
        magazines[] = {};
        requiredAddons[] = {
            "ace_medical",
            "cba_settings",
            "kat_main"
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgSounds.hpp"
#include "CfgHints.hpp"
#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
