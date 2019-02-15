#include "BIS_AddonInfo.hpp"
class CfgPatches {
    class kat_aceAirway {
        units[] = {
            "KAT_guedelItem",
            "KAT_larynxItem",
            "KAT_accuvacItem",
            "KAT_Vomit"
        };
        weapons[] = {
            "KAT_guedel",
            "KAT_larynx",
            "KAT_accuvac"
        };
        requiredVersion = 1.80;
        requiredAddons[] = {
            "ace_medical",
            "cba_settings"
        };
        version = "0.9.4";
        versionStr = "0.9.4";
        author = "Katalam";
        authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgMods {
    class kat_aceAirway {
        dir = "@kat_aceAdvMedical";
        name = "KAT - ACE Airway Extension";
        picture = "kat_aceAdvMedical\addons\kat_aceAirway\images\larynx.paa";
        hidePicture = "false";
        hideName = "false";
        actionName = "Github";
        action = "$STR_KAT_URL";
    };
};

class CfgSounds {
  sounds[] = {};
  class KAT_Puke_1 {
      name = "KAT_Puke_1";
      sound[] = {"kat_aceAirway\sounds\Puking_1.wav", db + 2, 1, 15};
      titles[]	= {};
  };
  class KAT_Puke_2 {
      name = "KAT_Puke_2";
      sound[] = {"kat_aceAirway\sounds\Puking_2.wav", db + 2, 1, 15};
      titles[] = {};
  };
  class KAT_Puke_3 {
      name = "KAT_Puke_3";
      sound[] = {"kat_aceAirway\sounds\Puking_3.wav", db + 2, 1, 15};
      titles[] = {};
  };
  class KAT_Suction {
      name = "KAT_Suction";
      sound[] = {"kat_aceAirway\sounds\Suction.wav", db + 2, 1, 15};
      titles[]	= {};
  };
};

class CfgHints	{
    class KAT_Hint	{
        displayName = "KAT Medical";
        class KAT_Airway	{
            displayName = $STR_kat_aceAirway_hint_name;
            description = $STR_kat_aceAirway_hint_desc;
            tip = "";
            arguments[] = {};
            image = "kat_aceAirway\images\larynx.paa";
        };
    };
};

class CfgFunctions {
    class kat_aceAirway {
        file = "kat_aceAirway\functions";
        class functions {
            class accuvacSound{};
            class checkAirway{};
            class events{};
            class handleAirway{};
            class handleDie{};
            class handleInit{};
            class handlePuking{};
            class handleTimer{};
            class init{};
            class registerSettings{};
            class treatmentAdvanced_accuvac{};
            class treatmentAdvanced_accuvacLocal{};
            class treatmentAdvanced_airway{};
            class treatmentAdvanced_airwayLocal{};
            class treatmentAdvanced_overstretchHead{};
            class treatmentAdvanced_turnaroundHead{};
        };
    };
    class kat_aceMedical_Menu {
        tag = "ace_medical_menu";
        class ace_medical_menu {
            class updateUIInfo {
                file = "kat_aceAirway\functions\fn_updateUIInfo.sqf";
            };
        };
    };
    class kat_aceMedical {
        tag = "ace_medical";
        class ace_medical {
            class displayPatientInformation {
                file = "kat_aceAirway\functions\fn_displayPatientInformation.sqf";
            };
        };
    };
};

class Extended_PreInit_EventHandlers {
    class kat_aceAirway_preInit {
        init = "call kat_aceAirway_fnc_registerSettings";
    };
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceAirway_init {
            init = "_this call kat_aceAirway_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
    class kat_aceAirway_postInit {
        init = "call kat_aceAirway_fnc_events";
    };
};


class cfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class KAT_larynx: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= "$STR_kat_aceAirway_Larynx_Display";
        descriptionShort = "$STR_kat_aceAirway_Larynx_Desc_Short";
        descriptionUse = "$STR_kat_aceAirway_Larynx_Desc_Use";
        picture = "\kat_aceAirway\images\larynx_normal.paa";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class KAT_guedel: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= "$STR_kat_aceAirway_Guedel_Display";
        descriptionShort =  "$STR_kat_aceAirway_Guedel_Desc_Short";
        descriptionUse = "$STR_kat_aceAirway_Guedel_Desc_Use";
        picture = "\kat_aceAirway\images\guedel_normal.paa";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class KAT_accuvac: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName= "Accuvac";
        descriptionShort = "$STR_kat_aceAirway_Accuvac_Desc_Short";
        descriptionUse = "$STR_kat_aceAirway_Accuvac_Desc_Use";
        picture = "\kat_aceAirway\images\accuvac_normal.paa";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 7;
        };
    };
};

class cfgVehicles {
    class Item_Base_F;

    class KAT_larynxItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= "$STR_kat_aceAirway_Larynx_Display";
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(KAT_larynx,1);
        };
    };
    class KAT_guedelItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= "$STR_kat_aceAirway_Guedel_Display";
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(KAT_guedel,1);
        };
    };
    class KAT_accuvacItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= "Accuvac";
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(KAT_accuvac,1);
        };
    };
    class BloodSplatter_01_Small_Old_F;
    class KAT_Vomit: BloodSplatter_01_Small_Old_F {
        displayName = $STR_kat_aceAirway_Vomit_Display;
        hiddenSelectionsTextures[] = {"kat_aceAirway\images\vomit.paa"};
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(KAT_larynx,15);
            MACRO_ADDITEM(KAT_guedel,15);
            MACRO_ADDITEM(KAT_accuvac,1);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Head {
                class intubating {
                    displayName = "$STR_kat_aceAirway_intubating";
                    icon = "";
                    class Larynxtubus {
                        displayName = "$STR_kat_aceAirway_Larynx_Display";
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = "\kat_aceAirway\images\larynx.paa";
                    };
                    class Guedeltubus: Larynxtubus {
                        displayName = "$STR_kat_aceAirway_Guedel_Display";
                        condition = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = "\kat_aceAirway\images\guedel.paa";
                    };
                    class Overstretch: Larynxtubus {
                        displayName = "$STR_kat_aceAirway_overstretch";
                        condition = "[_player, _target, 'head', 'Overstretch'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Overstretch'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                };
                class vacuum {
                    displayName = "$STR_kat_aceAirway_vacuum";
                    icon = "";
                    class Accuvac {
                        displayName = "Accuvac";
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'Accuvac'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Accuvac'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = "\kat_aceAirway\images\accuvac.paa";
                    };
                    class TurnAround: Accuvac {
                        displayName = "$STR_kat_aceAirway_turnaround";
                        condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                };
                class CheckPulse;
                class CheckAirway: CheckPulse {
                    displayName = "$STR_kat_aceAirway_checkAirway";
                    condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_treatment";
                    exceptions[] = {""};
                    icon = "";
                };
            };
            class ACE_MainActions {
                class Medical {
                    class ACE_Head {
                        class intubating {
                            displayName = "$STR_kat_aceAirway_intubating";
                            icon = "";
                            class Larynxtubus {
                                displayName = "$STR_kat_aceAirway_Larynx_Display";
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = "\kat_aceAirway\images\larynx.paa";
                            };
                            class Guedeltubus: Larynxtubus {
                                displayName = "$STR_kat_aceAirway_Guedel_Display";
                                condition = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = "\kat_aceAirway\images\guedel.paa";
                            };
                            class Overstretch: Larynxtubus {
                                displayName = "$STR_kat_aceAirway_overstretch";
                                condition = "[_player, _target, 'head', 'Overstretch'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Overstretch'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                        };
                        class vacuum {
                            displayName = "$STR_kat_aceAirway_vacuum";
                            icon = "";
                            class Accuvac {
                                displayName = "Accuvac";
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'Accuvac'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Accuvac'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = "\kat_aceAirway\images\accuvac.paa";
                            };
                            class TurnAround: Accuvac {
                                displayName = "$STR_kat_aceAirway_turnaround";
                                condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                        };
                        class CheckPulse;
                        class CheckAirway: CheckPulse {
                            displayName = "$STR_kat_aceAirway_checkAirway";
                            condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_canTreatCached";
                            statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_treatment";
                            exceptions[] = {""};
                            icon = "";
                        };
                    };
                };
            };
        };
    };
};

class ACE_Medical_Actions {
    class Advanced {
        class Larynxtubus {
            displayName = "$STR_kat_aceAirway_Larynx_Display";
            displayNameProgress = $STR_kat_aceAirway_action_placing;
            category = "airway";
            treatmentLocations[] = {"All"};
            allowedSelections[] = {"head"};
            allowSelfTreatment = 0;
            requiredMedic = 1;
            treatmentTime = 5;
            items[] = {"KAT_larynx"};
            condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
            patientStateCondition = 0;
            callbackSuccess = "[_player, _target, 'Larynxtubus'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
            callbackFailure = "";
            callbackProgress = "";
            itemConsumed = 1;
            animationPatient = "";
            animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
            animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
            animationCaller = "AinvPknlMstpSlayWrflDnon_medicOther";
            animationCallerProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
            animationCallerSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
            animationCallerSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
            litter[] = {};
        };
        class Guedeltubus: larynxtubus {
            displayName = $STR_kat_aceAirway_Guedel_Display;
            requiredMedic = 0;
            items[] = {"KAT_guedel"};
            callbackSuccess = "[_player, _target, 'Guedeltubus'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
        };
        class Accuvac: larynxtubus {
            displayName = "Accuvac";
            treatmentTime = 8;
            items[] = {"KAT_accuvac"};
            itemConsumed = 0;
            callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_accuvac";
            callbackProgress = "_this call kat_aceAirway_fnc_accuvacSound";
        };
        class Overstretch: larynxtubus {
            displayName = "$STR_kat_aceAirway_overstretch";
            displayNameProgress = $STR_kat_aceAirway_overstretching;
            treatmentTime = 2;
            requiredMedic = 0;
            items[] = {};
            condition = "!([_target] call ace_common_fnc_isAwake) && !(_target getVariable ['kat_aceAirway_overstretch', false]) && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
            callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_overstretchHead";
        };
        class TurnAround: larynxtubus {
            displayName = "$STR_kat_aceAirway_turnaround";
            displayNameProgress = $STR_kat_aceAirway_turnaround_action;
            treatmentTime = 5;
            requiredMedic = 0;
            items[] = {};
            callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_turnaroundHead";
        };
        class CheckPulse;
        class CheckAirway: checkPulse {
            displayName = "$STR_kat_aceAirway_checkAirway";
            displayNameProgress = $STR_kat_aceAirway_action_checking;
            treatmentTime = 5;
            allowedSelections[] = {"head"};
            allowSelfTreatment = 0;
            callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_checkAirway";
            condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
        };
    };
};
