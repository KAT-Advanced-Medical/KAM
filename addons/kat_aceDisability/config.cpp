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
        "kat_aceAirway"//,
        //"kat_aceBreathing",
        //"kat_aceCirculation",
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
        class condition_clothes{};
        class events{};
        class registerSettings{};
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
         };
       };
     };
   };
};

class ACE_Medical_Actions {
	class Advanced {
    class fieldDressing;
    class CutOfClothes: fieldDressing {
        displayName = "$STR_kat_aceDisability_Action_Display";
        displayNameProgress = $STR_kat_aceDisability_Action_Display;
        treatmentTime = 15;
        allowedSelections[] = {"body"};
        items[] = {};
        icon = "";
        category = "advanced";
        condition = "!([_target] call ace_common_fnc_isAwake)";
        //condition = "[_target] call kat_aceDisability_fnc_condition_clothes";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target] call kat_aceDisability_fnc_treatmentAdvanced_clothes";
    };
	};
};
