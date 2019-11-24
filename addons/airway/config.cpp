#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            QUOTE(KAM_nasopharyngealItem),
            QUOTE(KAM_oropharyngealItem),
            QUOTE(KAM_endotrachealItem),
            QUOTE(KAM_suctionItem),
            QUOTE(KAM_accuvacItem),
            QUOTE(KAM_vomit)
        };
        weapons[] = {
            QUOTE(KAM_nasopharyngeal),
            QUOTE(KAM_oropharyngeal),
            QUOTE(KAM_endotracheal),
            QUOTE(KAM_suction),
            QUOTE(KAM_accuvac)
        };
        magazines[] = {};
        requiredAddons[] = {
            QUOTE(ace_medical),
            QUOTE(cba_settings),
            QUOTE(kam_main)
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
#include "ACE_Medical_Injuries.hpp"
