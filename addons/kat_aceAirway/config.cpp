#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceAirway
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
    file = "kat_aceAirway\functions";
		class functions {
        class registerSettings{};
        class handleDamage_airway{};
        class handleDie{};
        class handleInit{};
        class handleKilled{};
        class handleRespawn{};
        class init{};
        class treatmentAdvanced_Accuvac{}
        class treatmentAdvanced_AccuvacLocal{};
        class treatmentAdvanced_guedel{}
        class treatmentAdvanced_guedelLocal{}
        class treatmentAdvanced_larynx{};
        class treatmentAdvanced_larynxLocal{};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class kat_aceAirway_preInit {
		init = "call kat_aceAirway_fnc_registerSettings";
	};
};
class Extended_PostInit_EventHandlers {
  class CAManBase {
    class kat_aceAirway_postInit {
      init = "[_this] call kat_aceAirway_fnc_init";
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
  class ACE_guedel: ACE_ItemCore {
      scope=2;
      author = "Katalam";
      displayName= "$STR_kat_aceAirway_Guedel_Display";
      descriptionShort =  "$STR_kat_aceAirway_Guedel_Desc_Short";
      descriptionUse = "$STR_kat_aceAirway_Guedel_Desc_Use";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 1;
      };
  };
  class ACE_Accuvac: ACE_ItemCore {
      scope=2;
      author = "Katalam";
      displayName= "Accuvac";
      descriptionShort = "$STR_kat_aceAirway_Accuvac_Desc_Short";
      descriptionUse = "$STR_kat_aceAirway_Accuvac_Desc_Use";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 7;
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
            condition = "true";//"[_player, _target, 'body', 'Larynx'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
            statement = "[_player, _target, 'body', 'Larynx'] call ace_medical_fnc_treatment";
        };
        class Guedeltubus {
            displayName = "$STR_kat_aceAirway_Guedel_Display";
            condition = "true";//"[_player, _target, 'body', 'Guedel'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
            statement = "[_player, _target, 'body', 'Guedel'] call ace_medical_fnc_treatment";
        };
        class Accuvac {
            displayName = "Accuvac";
            condition = "true";//"[_player, _target, 'body', 'Accuvac'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
            statement = "[_player, _target, 'body', 'Accuvac'] call ace_medical_fnc_treatment";
        };
			};
			class ACE_MainActions {
				class Medical {
					class ACE_Head {
            class Larynxtubus {
                displayName = "$STR_kat_aceAirway_Larynx_Display";
                condition = "true";//"[_player, _target, 'body', 'Larynx'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
                statement = "[_player, _target, 'body', 'Larynx'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAirway\addons\kat_aceAirway\images\larynx.paa";
            };
            class Guedeltubus {
                displayName = "$STR_kat_aceAirway_Guedel_Display";
                condition = "true";//"[_player, _target, 'body', 'Guedel'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
                statement = "[_player, _target, 'body', 'Guedel'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAirway\addons\kat_aceAirway\images\guedel.paa";
            };
            class Accuvac {
                displayName = "Accuvac";
                condition = "true";//"[_player, _target, 'body', 'Accuvac'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['kat_aceAirway_enable',true])";
                statement = "[_player, _target, 'body', 'Accuvac'] call ace_medical_fnc_treatment";
                icon = "\kat_aceAirway\addons\kat_aceAirway\images\accuvac.paa";
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
        displayName = CSTRING(Actions_Larynxtubus);
        displayNameProgress = CSTRING(Placing);
        treatmentTime = 5;
        allowedSelections[] = {"head"};
        items[] = {"ACE_larynx"};
        condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
        patientStateCondition = 0;
        callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_larynx));
    };
    class Guedeltubus: Larynxtubus {
      displayName = CSTRING(Actions_Guedeltubus);
      displayNameProgress = CSTRING(Placing);
      treatmentTime = 5;
      allowedSelections[] = {"head"};
      items[] = {"ACE_larynx"};
      condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
      patientStateCondition = 0;
      callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_guedel));
    };
    class Accuvac: Larynxtubus {
      displayName = "Accuvac";
      displayNameProgress = CSTRING(Placing);
      treatmentTime = 10;
      allowedSelections[] = {"head"};
      items[] = {"ACE_Accuvac"};
      condition = "!([(_this select 1)] call ace_common_fnc_isAwake)";
      patientStateCondition = 0;
      callbackSuccess = QUOTE(DFUNC(treatmentAdvanced_Accuvac));
    };
	};
};
