#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "KAM_nasopharyngealItem",
            "KAM_oropharyngealItem",
            "KAM_endotrachealItem",
            "KAM_suctionItem",
            "KAM_accuvacItem",
            "KAM_vomit"
        };
        weapons[] = {
            "KAM_nasopharyngeal",
            "KAM_oropharyngeal",
            "KAM_endotracheal",
            "KAM_suction",
            "KAM_accuvac"
        };
        magazines[] = {};
        requiredAddons[] = {
            "ace_medical",
            "cba_settings",
            "KAM_main"
        };
        author = CSTRING(AUTHOR);
        authors[] = {CSTRING(AUTHOR)};
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
