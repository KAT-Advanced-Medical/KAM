#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceBreathing
    {
        units[] = {
			"kat_aceAirway_guedelItem",
      "kat_aceAirway_larynxItem",
      "kat_aceAirway_accuvacItem"
		};
        weapons[] = {
      "kat_aceAirway_guedel",
      "kat_aceAirway_larynx",
      "kat_aceAirway_accuvac"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical"
			,"cba_settings"
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
    file = "kat_acebreathing\functions";
		class functions {
        class registerSettings{};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class kat_aceBreathing_preInit {
		init = "call kat_aceBreathing_fnc_registerSettings";
	};
};
class Extended_PostInit_EventHandlers {
  class CAManBase {
    class kat_aceBreathing_postInit {
      init = "[_this] call kat_aceBreathing_fnc_init";
    };
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
  class ACE_guedelItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_kat_aceAirway_Guedel_Display";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(ACE_guedel,1);
      };
  };
  class ACE_AccuvacItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "Accuvac";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(ACE_Accuvac,1);
      };
  };
};
	//ace_medical_actions:
class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_Head {
        class Larynxtubus {
            displayName = "$STR_kat_aceAirway_Larynx_Display";
            condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
            statement = "[_player, _target, 'body', 'Larynx'] call kat_aceAirway_fnc_treatmentAdvanced_larynx";
        };
        class Guedeltubus {
            displayName = "$STR_kat_aceAirway_Guedel_Display";
            condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
            statement = "[_player, _target, 'body', 'Guedel'] call kat_aceAirway_fnc_treatmentAdvanced_guedel";
        };
        class Accuvac {
            displayName = "Accuvac";
            condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
            statement = "[_player, _target, 'body', 'Accuvac'] call kat_aceAirway_fnc_treatmentAdvanced_accuvac";
        };
			};
			class ACE_MainActions {
				class Medical {
					class ACE_Head {
            class Larynxtubus {
                displayName = "$STR_kat_aceAirway_Larynx_Display";
                condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
                statement = "[_player, _target, 'body', 'Larynx'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAirway\addons\kat_aceAirway\images\larynx.paa";
            };
            class Guedeltubus {
                displayName = "$STR_kat_aceAirway_Guedel_Display";
                condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
                statement = "[_player, _target, 'body', 'Guedel'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAirway\addons\kat_aceAirway\images\guedel.paa";
            };
            class Accuvac {
                displayName = "Accuvac";
                condition = "missionNamespace getVariable ['kat_aceAirway_enable',true]";
                statement = "[_player, _target, 'body', 'Accuvac'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAdvmedical\addons\kat_aceAirway\images\accuvac.paa";
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
        displayNameProgress = $STR_kat_aceAirway_action_playing;
        treatmentTime = 5;
        allowedSelections[] = {"head"};
        items[] = {"ACE_larynx"};
        condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
        patientStateCondition = 0;
        callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_larynx));
    };
    class Guedeltubus: Larynxtubus {
      displayName = $STR_kat_aceAirway_Guedel_Display;
      displayNameProgress = $STR_kat_aceAirway_action_playing;
      treatmentTime = 5;
      allowedSelections[] = {"head"};
      items[] = {"ACE_guedel"};
      condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
      patientStateCondition = 0;
      callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_guedel));
    };
    class Accuvac: Larynxtubus {
      displayName = "Accuvac";
      displayNameProgress = $STR_kat_aceAirway_action_playing;
      treatmentTime = 10;
      allowedSelections[] = {"head"};
      items[] = {"ACE_Accuvac"};
      condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
      patientStateCondition = 0;
      callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_Accuvac));
    };
	};
};
