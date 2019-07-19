#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "KAM_painkillerItem",
            //"KAM_X_AEDItem",
            "KAM_bloodBankCrate"
        };
        weapons[] = {
            "KAM_painkiller",
            "KAM_bloodIV_O",
            "KAM_bloodIV_A",
            "KAM_bloodIV_B",
            "KAM_bloodIV_AB",
            "KAM_bloodIV_O_500",
            "KAM_bloodIV_A_500",
            "KAM_bloodIV_B_500",
            "KAM_bloodIV_AB_500",
            "KAM_bloodIV_O_250",
            "KAM_bloodIV_A_250",
            "KAM_bloodIV_B_250",
            "KAM_bloodIV_AB_250",
            "KAM_PainkillerItem",
            //"KAM_X_AED",
            "KAM_crossPanel"
        };
        magazines[] = {
            "KAM_painkiller"
        };
        requiredAddons[] = {
            "ace_medical",
            "ace_dogtags",
            "cba_settings",
            "kam_main"
            //"adv_aceCPR"
        };
        author = CSTRING(AUTHOR);
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ui\CrossPanel_Dialog.hpp"
