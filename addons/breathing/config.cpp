#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            QUOTE(KAM_pulseoximeterItem)
        };
        weapons[] = {
            QUOTE(KAM_pulseoximeter)
        };
        magazines[] = {};
        requiredAddons[] = {
            QUOTE(ace_medical),
            QUOTE(kam_main),
            QUOTE(kam_airway),
            QUOTE(cba_settings)
        };
        author = CSTRING(AUTHOR);
        authors[] = {CSTRING(AUTHOR)};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgHints.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
