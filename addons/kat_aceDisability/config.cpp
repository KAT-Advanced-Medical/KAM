#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceDisability
    {
        units[] = {};
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

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgFunctions {
	class kat_aceDisability {
    file = "kat_aceDisability\functions";
		class functions {
        class bee{};
        class condition_clothes{};
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
        class CutOfClothes: fieldDressing {
          displayName = "$STR_kat_aceDisability_Action_Display";
          displayNameProgress = $STR_kat_aceDisability_Action_Display;
          treatmentLocations[] = {"All"};
          treatmentTime = 15;
          requiredMedic = 0;
          items[] = {};
          icon = "";
          category = "advanced";
          patientStateCondition = 0;
          condition = "[_target] call kat_aceDisability_fnc_condition_clothes";
          statement = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
        };
			};
    class ACE_Head {
        class FieldDressing;
        class tracheaCut: fieldDressing {
          displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
          displayNameProgress = $STR_kat_aceDisability_Action_tracheaCut_Action;
          treatmentTime = 60;
          treatmentLocations[] = {"All"};
          requiredMedic = 2;
          items[] = {"ACE_surgicalKit"};
          category = "airway";
          patientStateCondition = 0;
          condition = "!([_target] call ace_common_fnc_isAwake) && _target getVariable [""kat_aceDisability_checked"",false] && kat_aceAirway_enable && kat_aceDisability_enable";
          statement = "[_player, _target, 'ACE_surgicalKit'] call kat_aceDisability_fnc_treatmentAdvanced_bee";
          icon = "";
        };
    };
			class ACE_MainActions {
				class Medical {
					class ACE_Torso {
            class CutOfClothes {
              displayName = "$STR_kat_aceDisability_Action_Display";
              displayNameProgress = $STR_kat_aceDisability_Action_Display;
              treatmentLocations[] = {"All"};
              treatmentTime = 15;
              requiredMedic = 0;
              items[] = {};
              icon = "";
              category = "advanced";
              patientStateCondition = 0;
              condition = "[_target] call kat_aceDisability_fnc_condition_clothes";
              statement = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
            };
				  };
         class ACE_Head {
             class FieldDressing;
             class tracheaCut: fieldDressing {
               displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
               displayNameProgress = $STR_kat_aceDisability_Action_tracheaCut_Action;
               treatmentTime = 60;
               treatmentLocations[] = {"All"};
               requiredMedic = 2;
               items[] = {"ACE_surgicalKit"};
               category = "airway";
               patientStateCondition = 0;
               condition = "!([_target] call ace_common_fnc_isAwake) && _target getVariable [""kat_aceDisability_checked"",false] && kat_aceAirway_enable && kat_aceDisability_enable";
               statement = "[_player, _target, 'ACE_surgicalKit'] call kat_aceDisability_fnc_treatmentAdvanced_bee";
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
    class FieldDressing;
    class CutOfClothes: fieldDressing {
        displayName = "$STR_kat_aceDisability_Action_Display";
        displayNameProgress = $STR_kat_aceDisability_Action_Display;
        treatmentTime = 15;
        allowedSelections[] = {"body"};
        items[] = {};
        category = "advanced";
        condition = "!([_target] call ace_common_fnc_isAwake)";
        //condition = "[_target] call kat_aceDisability_fnc_condition_clothes";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
    };
    class tracheaCut: fieldDressing {
      displayName = "$STR_kat_aceDisability_Action_tracheaCut_Display";
      displayNameProgress = $STR_kat_aceDisability_Action_tracheaCut_Action;
      treatmentTime = 60;
      allowedSelections[] = {"head"};
      requiredMedic = 2;
      items[] = {"ACE_surgicalKit"};
      category = "airway";
      patientStateCondition = 0;
      condition = "!([_target] call ace_common_fnc_isAwake)";
      //condition = "!([_target] call ace_common_fnc_isAwake) && _target getVariable [""kat_aceDisability_checked"",false] && kat_aceAirway_enable && kat_aceDisability_enable";
      callbackSuccess = "[_player, _target, 'ACE_surgicalKit'] call kat_aceDisability_fnc_treatmentAdvanced_bee";
    };
	};
};
