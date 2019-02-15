#include "BIS_AddonInfo.hpp"
class CfgPatches {
    class kat_aceDisability {
        units[] = {
            "kat_aceDisability_ModuleBee",
            "kat_aceDisability_ModuleAllergical"
        };
        weapons[] = {};
        requiredVersion = 1.80;
        requiredAddons[] = {
            "ace_medical",
            "cba_settings",
            "A3_Modules_F",
            "A3_Modules_F_Curator"
        };
        version = "0.5";
        versionStr = "0.5";
        author = "Katalam";
        authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

class CfgFactionClasses {
    class kat_aceDisability_base {
        displayName = "KAT";
        priority = 2;
        side = 7;
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgFunctions {
    class kat_aceDisability {
        file = "kat_aceDisability\functions";
        class functions {
            class allergicalReaction{};
            class createBee{};
            class events{};
            class handleInit{};
            class init{};
            class moduleAllergical{};
            class moduleBee{};
            class registerSettings{};
            class treatmentAdvanced_clothes{};
            class treatmentAdvanced_clothesLocal{};
            class treatmentAdvanced_trachea{};
            class treatmentAdvanced_tracheaLocal{};
        };
    };
};

class Extended_PreInit_EventHandlers {
    class kat_aceDisability_preInit {
        init = "call kat_aceDisability_fnc_registerSettings";
    };
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceDisability_init {
            init = "_this call kat_aceDisability_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
    class kat_aceDisability_postInit {
        init = "call kat_aceDisability_fnc_events";
    };
};


class cfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Torso {
                class CutOfClothes {
                    displayName = "$STR_kat_aceDisability_Action_Display";
                    distance = 2.0;
                    condition = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_treatment";
                    exceptions[] = {""};
                    showDisabled = 0;
                    icon = "";
                };
                class fasttraumasearch {
                    displayName = "$STR_kat_aceDisability_Action_Display_fasttraumasearch";
                    distance = 2.0;
                    condition = "[_player, _target, 'body', 'fasttraumasearch'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'body', 'fasttraumasearch'] call ace_medical_fnc_treatment";
                    exceptions[] = {""};
                    showDisabled = 0;
                    icon = "";
                };
            };
            class ACE_Head {
                class tracheaCut {
                    displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
                    distance = 2.0;
                    condition = "[_player, _target, 'head', 'tracheaCut'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'head', 'tracheaCut'] call ace_medical_fnc_treatment";
                    exceptions[] = {""};
                    showDisabled = 0;
                    icon = "";
                };
            };
            class ACE_MainActions {
                class Medical {
                    class ACE_Torso {
                        class CutOfClothes {
                            displayName = "$STR_kat_aceDisability_Action_Display";
                            distance = 2.0;
                            condition = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_canTreatCached";
                            statement = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_treatment";
                            exceptions[] = {""};
                            showDisabled = 0;
                            icon = "";
                        };
                        class fasttraumasearch {
                            displayName = "$STR_kat_aceDisability_Action_Display_fasttraumasearch";
                            distance = 2.0;
                            condition = "[_player, _target, 'body', 'fasttraumasearch'] call ace_medical_fnc_canTreatCached";
                            statement = "[_player, _target, 'body', 'fasttraumasearch'] call ace_medical_fnc_treatment";
                            exceptions[] = {""};
                            showDisabled = 0;
                            icon = "";
                        };
                    };
                    class ACE_Head {
                        class tracheaCut {
                            displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
                            distance = 2.0;
                            condition = "[_player, _target, 'head', 'tracheaCut'] call ace_medical_fnc_canTreatCached";
                            statement = "[_player, _target, 'head', 'tracheaCut'] call ace_medical_fnc_treatment";
                            exceptions[] = {""};
                            showDisabled = 0;
                            icon = "";
                        };
                    };
                };
            };
        };
    };

    class Logic;

    class Module_F: Logic {
        class EventHandlers;
        class ModuleDescription;
        class AttributesBase {
            class Default;
            class Edit;
            class Combo;
            class Checkbox;
            class CheckboxNumber;
            class ModuleDescription;
            class Units;
        };
    };
    class kat_aceDisability_moduleBase: Module_F {
        author = "Katalam";
        displayName = "Test";
        category = kat_aceDisability_base;
        function = "";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
    };
    class kat_aceDisability_moduleBase3den: Module_F {
        author = "Katalam";
        displayName = "Base Module";
        category = kat_aceDisability_base;
        function = "";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        scope = 2;
        scopeCurator = 1;
    };

    class kat_aceDisability_moduleBee: kat_aceDisability_moduleBase {
        displayName = "Create Bees";
        function = "kat_aceDisability_fnc_moduleBee";
        curatorCanAttach = 1;
    };

    class kat_aceDisability_moduleAllergical: kat_aceDisability_moduleBase {
        displayName = "Spawn allergical reaction";
        function = "kat_aceDisability_fnc_moduleAllergical";
        curatorCanAttach = 1;
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(U_B_CombatUniform_mcam_tshirt,5);
        };
    };
}; // Close CfgVehicles

class ACE_Medical_Actions {
    class Advanced {
        class CutOfClothes {
            displayName = "$STR_kat_aceDisability_Action_Display";
            displayNameProgress = $STR_kat_aceDisability_Action_Display;
            category = "advanced";
            treatmentLocations[] = {"All"};
            allowedSelections[] = {"body"};
            allowSelfTreatment = 0;
            requiredMedic = 1;
            treatmentTime = 15;
            items[] = {};
            condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceDisability_enable',true]) && !(uniform _target isEqualTo '')";
            patientStateCondition = 0;
            callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
            callbackFailure = "";
            callbackProgress = "";
            itemConsumed = 0;
            animationPatient = "";
            animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
            animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
            animationCaller = "AinvPknlMstpSlayWrflDnon_medicOther";
            animationCallerProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
            animationCallerSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
            animationCallerSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
            litter[] = {};
        };
        class fasttraumasearch: CutOfClothes {
            displayName = "$STR_kat_aceDisability_Action_Display_fasttraumasearch";
            displayNameProgress = $STR_kat_aceDisability_Action_Progress_fasttraumasearch;
            condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceDisability_enable',true]) && (uniform _target isEqualTo '')";
            callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
        };
        class tracheaCut: CutOfClothes {
            displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
            displayNameProgress = $STR_kat_aceDisability_Action_tracheaCut_Action;
            treatmentTime = 60;
            allowedSelections[] = {"head"};
            requiredMedic = 2;
            items[] = {"ACE_surgicalKit"};
            condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceDisability_enable',true]) && _target getVariable ['kat_aceDisability_checked', false]";
            category = "airway";
            callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_trachea";
        };
    };
};
