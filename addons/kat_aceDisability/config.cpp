#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceDisability
    {
        units[] = {"kat_aceDisability_ModuleBee"};
        weapons[] = {};
        requiredVersion = 1.80;
        requiredAddons[] = {
        "ace_medical",
        "cba_settings",
		};
		version = "0.5";
		versionStr = "0.5";
		author = "[SeL] Katalam";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

class CfgFactionClasses {
	class NO_CATEGORY;
	class kat_aceDisability: NO_CATEGORY {
		displayName = "KAT";
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
        class bee{};
        class createBee{};
        class events{};
        class handleInit{};
        class init{};
        class registerSettings{};
        class treatmentAdvanced_bee{};
        class treatmentAdvanced_beeLocal{};
        class treatmentAdvanced_clothes{};
        class treatmentAdvanced_clothesLocal{};
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
        class FieldDressing;
        class CutOfClothes {
          displayName = "$STR_kat_aceDisability_Action_Display";
          distance = 2.0;
          condition = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_treatment";
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
            class FieldDressing;
            class CutOfClothes {
              displayName = "$STR_kat_aceDisability_Action_Display";
              distance = 2.0;
              condition = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'body', 'CutOfClothes'] call ace_medical_fnc_treatment";
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
   class Module_F: Logic  {
     class AttributesBase {
       class Default;
       class Edit; // Default edit box (i.e., text input field)
       class Combo; // Default combo box (i.e., drop-down menu)
       class Checkbox; // Default checkbox (returned value is Bool)
       class CheckboxNumber; // Default checkbox (returned value is Number)
       class ModuleDescription; // Module description
       class Units; // Selection of units on which the module is applied
     };
     // Description base classes, for more information see below
     class ModuleDescription  {
       class AnyBrain;
     };
   };
   class kat_CreateBees: Module_F {
     // Standard object definitions
     scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
     scopeCurator = 2;
     displayName = "Create Bees"; // Name displayed in the menu
     icon = ""; // Map icon. Delete this entry to use the default icon
     category = "kat_aceDisability";

     // Name of function triggered once conditions are met
     function = "kat_aceDisability_fnc_createBee";
     // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
     functionPriority = 1;
     // 0 for server only execution, 1 for global execution, 2 for persistent global execution
     isGlobal = 1;
     // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
     isDisposable = 1;
     // // 1 to run init function in Eden Editor as well
     is3DEN = 0;

     // Menu displayed when the module is placed or double-clicked on by Zeus
     curatorInfoType = "RscDisplayAttributeModuleNuke";

     // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
     class ModuleDescription: ModuleDescription {
       description = "Short module description"; // Short description, will be formatted as structured text
       sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

       class LocationArea_F {
         description[] = { // Multi-line descriptions are supported
           "First line",
           "Second line"
         };
         position = 1; // Position is taken into effect
         direction = 1; // Direction is taken into effect
       };
     };
   }; // Close Module

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
        condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceDisability_enable',true])";
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
    class tracheaCut: CutOfClothes {
      displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
      displayNameProgress = $STR_kat_aceDisability_Action_tracheaCut_Action;
      treatmentTime = 60;
      allowedSelections[] = {"head"};
      requiredMedic = 2;
      items[] = {"ACE_surgicalKit", "ACE_epinephrine"};
      condition = "!([_target] call ace_common_fnc_isAwake) && (missionNamespace getVariable ['kat_aceDisability_enable',true]) && _target getVariable ['kat_aceDisability_checked', false]";
      category = "airway";
      callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_bee";
    };
	};
};
