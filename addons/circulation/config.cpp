#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_X_AEDItem",
            "kat_AEDItem"
        };
        weapons[] = {
            "kat_bloodIV_O",
            "kat_bloodIV_O_N",
            "kat_bloodIV_A",
            "kat_bloodIV_A_N",
            "kat_bloodIV_B",
            "kat_bloodIV_B_N",
            "kat_bloodIV_AB",
            "kat_bloodIV_AB_N",
            "kat_bloodIV_O_500",
            "kat_bloodIV_O_N_500",
            "kat_bloodIV_A_500",
            "kat_bloodIV_A_N_500",
            "kat_bloodIV_B_500",
            "kat_bloodIV_B_N_500",
            "kat_bloodIV_AB_500",
            "kat_bloodIV_AB_N_500",
            "kat_bloodIV_O_250",
            "kat_bloodIV_O_N_250",
            "kat_bloodIV_A_250",
            "kat_bloodIV_A_N_250",
            "kat_bloodIV_B_250",
            "kat_bloodIV_B_N_250",
            "kat_bloodIV_AB_250",
            "kat_bloodIV_AB_N_250",
            "kat_X_AED",
            "kat_AED",
            "kat_crossPanel",
            "KAT_Empty_bloodIV_500",
            "KAT_Empty_bloodIV_250",
            "kat_HextendIV",
            "kat_HextendIV_500",
            "kat_HextendIV_250",
            "kat_RingersLactateIV",
            "kat_RingersLactateIV_500",
            "kat_RingersLactateIV_250",
            "kat_PackedRBCIV_500",
            "kat_PackedRBCIV_250",
            "kat_salineIV100",
            "kat_BPCuff",
            "kat_HypertonicSalineIV_500",
            "kat_HypertonicSalineIV_250",
            "kat_HypertonicSalineIV_100"
        };
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
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
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "RscTitles.hpp"
#include "CfgFunctions.hpp"
#include "CfgMoves.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ui\CrossPanel_Dialog.hpp"
#include "ui\AEDX_Monitor_Dialog.hpp"
#include "CfgSounds.hpp"
