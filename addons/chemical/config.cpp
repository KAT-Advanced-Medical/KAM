#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_sealant_Item",
            "kat_module_gas",
            "kat_module_zeus_gas",
            "KAT_Gas_TripWireMine"
        };
        weapons[] = {
            "kat_sealant",
            "kat_gasmaskFilter",
            "KAT_M7A3",
            "KAT_CAS_M43_Bomb",
            "KAT_CAS_R_80mm_GAS_POD"
        };
        ammo[] = {
            "KAT_Gas_TripWireMine_Ammo",
            "KAT_GASTripEffect",
            "KAT_GASTrip_SmokeEffect",
            "KAT_CAS_M43_Ammo",
            "KAT_CAS_M43_Ammo_sub",
            "KAT_CAS_R_80mm_GAS_AMMO"
        };
        magazines[] = {
            "KAT_CAS_M43_Mag"
        };
        requiredAddons[] = {
            "kat_main",
            "cba_settings",
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
            "ace_mk6mortar",
            "ace_csw"
        };
        author = "DiGii";
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMagazineGroups.hpp"
#include "CfgAmmo.hpp"
#include "CfgCloudlets.hpp"
#include "CfgMagazines.hpp"
#include "CfgUIGrids.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "CfgSounds.hpp"
#include "ui\RscAttributes.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "CfgGlasses.hpp"
