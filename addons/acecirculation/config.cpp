#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            kat_PainkillerItem,
            kat_X_AEDItem,
            kat_bloodBankCrate
        };
        weapons[] = {
            kat_Painkiller,
            kat_bloodIV_O,
            kat_bloodIV_A,
            kat_bloodIV_B,
            kat_bloodIV_AB,
            kat_bloodIV_O_500,
            kat_bloodIV_A_500,
            kat_bloodIV_B_500,
            kat_bloodIV_AB_500,
            kat_bloodIV_O_250,
            kat_bloodIV_A_250,
            kat_bloodIV_B_250,
            kat_bloodIV_AB_250,
            kat_PainkillerItem,
            kat_X_AED,
            kat_crossPanel
        };
        magazines[] = { };
        requiredAddons[] = {
            "ace_medical",
            "ace_dogtags",
            "cba_settings",
            "kat_main",
            "adv_aceCPR"
        };
        author = "Katalam";
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
#include "ACE_Medical_Actions.hpp"
#include "ACE_Medical_Advanced.hpp"
#include "ui\CrossPanel_Dialog.hpp"
