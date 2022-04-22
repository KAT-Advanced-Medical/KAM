#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_X_AEDItem",
            "kat_bloodBankCrate"
        };
        weapons[] = {
            "kat_bloodIV_O_RhP",
            "kat_bloodIV_O_RhN",
            "kat_bloodIV_A_RhP",
            "kat_bloodIV_A_RhN",
            "kat_bloodIV_B_RhP",
            "kat_bloodIV_B_RhN",
            "kat_bloodIV_AB_RhP",
            "kat_bloodIV_AB_RhN",
            "kat_bloodIV_O_500_RhP",
            "kat_bloodIV_O_500_RhN",
            "kat_bloodIV_A_500_RhP",
            "kat_bloodIV_A_500_RhN",
            "kat_bloodIV_B_500_RhP",
            "kat_bloodIV_B_500_RhN",
            "kat_bloodIV_AB_500_RhP",
            "kat_bloodIV_AB_500_RhN",
            "kat_bloodIV_O_250_RhP",
            "kat_bloodIV_O_250_RhN",
            "kat_bloodIV_A_250_RhP",
            "kat_bloodIV_A_250_RhN",
            "kat_bloodIV_B_250_RhP",
            "kat_bloodIV_B_250_RhN",
            "kat_bloodIV_AB_250_RhP",
            "kat_bloodIV_AB_250_RhN",
            "kat_X_AED",
            "kat_crossPanel",
            "KAT_Empty_bloodIV_500",
            "KAT_Empty_bloodIV_250"
        };
        magazines[] = { };
        requiredAddons[] = {
            "ace_medical",
            "ace_medical_ai",
            "ace_medical_blood",
            "ace_medical_damage",
            "ace_medical_engine",
            "ace_medical_feedback",
            "ace_medical_gui",
            "ace_medical_statemachine",
            "ace_medical_status",
            "ace_medical_treatment",
            "ace_medical_vitals",
            "ace_dogtags",
            "cba_settings",
            "kat_main"
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
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Advanced.hpp"
#include "ui\CrossPanel_Dialog.hpp"
