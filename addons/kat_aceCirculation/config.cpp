#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceCirculation
    {
        units[] = {
			"kat_aceAirway_guedelItem"
		};
        weapons[] = {
      "kat_aceAirway_guedel"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical",
      "kat_aceAirway",
      "kat_aceBreathing",
      "cba_settings"
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
	class kat_aceAirway {
    file = "kat_aceCirculation\functions";
		class functions {
        class checkAirway{};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class kat_aceCirculation_preInit {
		init = "call kat_aceCirculation_fnc_registerSettings";
	};
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceCirculation_init {
            init = "_this call kat_aceCirculation_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
  class kat_aceCirculation_postInit {
    init = "call kat_aceCirculation_fnc_events";
  };
};


class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;

  class ACE_larynx: ACE_ItemCore {
      scope=2;
      author = "Katalam";
      displayName= "$STR_kat_aceAirway_Larynx_Display";
      descriptionShort = "$STR_kat_aceAirway_Larynx_Desc_Short";
      descriptionUse = "$STR_kat_aceAirway_Larynx_Desc_Use";
      picture = "\kat_aceAirway\images\larynx_normal.paa";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 1;
      };
  };
};

class cfgVehicles {
	class Item_Base_F;

  class ACE_larynxItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_kat_aceAirway_Larynx_Display";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(ACE_larynx,1);
      };
  };

class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_Head {
        class FieldDressing;
        class Larynxtubus: fieldDressing {
          displayName = "$STR_kat_aceAirway_Larynx_Display";
          displayNameProgress = $STR_kat_aceAirway_action_placing;
          treatmentLocations[] = {"All"};
          treatmentTime = 5;
          requiredMedic = 1;
          items[] = {"ACE_larynx"};
          category = "airway";
          patientStateCondition = 0;
          condition = "!([_target] call ace_common_fnc_isAwake)";
          statement = "[_player, _target, 'head', 'larynx'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
          icon = "\kat_aceAirway\images\larynx.paa";
        };
			};
			class ACE_MainActions {
				class Medical {
					class ACE_Head {
            class Larynxtubus {
              displayName = "$STR_kat_aceAirway_Larynx_Display";
              displayNameProgress = $STR_kat_aceAirway_action_placing;
              treatmentLocations[] = {"All"};
              treatmentTime = 5;
              requiredMedic = 1;
              items[] = {"ACE_larynx"};
              category = "airway";
              patientStateCondition = 0;
              condition = "!([_target] call ace_common_fnc_isAwake)";
              statement = "[_player, _target, 'head', 'larynx'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
              icon = "\kat_aceAirway\images\larynx.paa";
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
    class Larynxtubus: fieldDressing {
        displayName = "$STR_kat_aceAirway_Larynx_Display";
        displayNameProgress = $STR_kat_aceAirway_action_placing;
        treatmentTime = 5;
        allowedSelections[] = {"head"};
        items[] = {"ACE_larynx"};
        category = "airway";
        condition = "!([_target] call ace_common_fnc_isAwake)";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target, 'head', 'larynx'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
    };
	};
};
