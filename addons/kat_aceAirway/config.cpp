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

class CfgMods {
    class kat_aceAirway {
        dir = "@kat_aceAdvMedical";
        name = "KAT - ACE Airway Extension";
        picture = "kat_aceAdvMedical\addons\kat_aceAirway\images\larynx.paa";
        hidePicture = "false";
        hideName = "false";
        actionName = "Website";
        action = "$STR_KAT_URL";
    };
};

class CfgFunctions {
	class kat_aceAirway {
    file = "kat_aceAirway\functions";
		class functions {
        class checkAirway{};
        class events{};
        class handleDamage_airway{};
        class handleDie{};
        class handleInit{};
        class handleTimer{};
        class init{};
        class registerSettings{};
        class treatmentAdvanced_accuvac{};
        class treatmentAdvanced_accuvacLocal{};
        class treatmentAdvanced_airway{};
        class treatmentAdvanced_guedelLocal{};
        class treatmentAdvanced_larynxLocal{};
        class treatmentAdvanced_overstretchHead{};
		};
	};
  class kat_aceMedical_Menu {
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
  class kat_aceairway_pstInit {
    init = "call kat_aceAirway_fnc_events";
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
  class ACE_guedel: ACE_ItemCore {
      scope=2;
      author = "Katalam";
      displayName= "$STR_kat_aceAirway_Guedel_Display";
      descriptionShort =  "$STR_kat_aceAirway_Guedel_Desc_Short";
      descriptionUse = "$STR_kat_aceAirway_Guedel_Desc_Use";
      picture = "\kat_aceAirway\images\guedel_normal.paa";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 1;
      };
  };
  class ACE_accuvac: ACE_ItemCore {
      scope=2;
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
  class ACE_accuvacItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "Accuvac";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(ACE_accuvac,1);
      };
  };

  class NATO_Box_Base;
	class ACE_medicalSupplyCrate: NATO_Box_Base {
		class TransportItems;
	};
	class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
		class TransportItems: TransportItems {
			MACRO_ADDITEM(ACE_larynx,15);
      MACRO_ADDITEM(ACE_guedel,15);
      MACRO_ADDITEM(ACE_accuvac,1);
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
        class Guedeltubus: larynxtubus {
          displayName = "$STR_kat_aceAirway_Guedel_Display";
          requiredMedic = 0;
          items[] = {"ACE_guedel"};
          statement = "[_player, _target, 'head', 'guedel'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
          icon = "\kat_aceAirway\images\guedel.paa";
        };
        class Accuvac: larynxtubus {
          displayName = "Accuvac";
          items[] = {"ACE_accuvac"};
          statement = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_accuvac";
          icon = "\kat_aceAirway\images\accuvac.paa";
        };
        class Overstretch: larynxtubus {
          displayName = "$STR_kat_aceAirway_overstretch";
          displayNameProgress = $STR_kat_aceAirway_overstretching;
          treatmentTime = 2;
          requiredMedic = 0;
          items[] = {};
          icon = "";
          condition = "!([_target] call ace_common_fnc_isAwake) && ((_target getVariable ""kat_aceAirway_overstretch"") isEqualTo false)";
          statement = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_overstretchHead";
        };
        class CheckPulse;
        class CheckAirway: checkPulse {
          displayName = "$STR_kat_aceAirway_checkAirway";
          displayNameProgress = "$STR_kat_aceAirway_checkAirway";
          treatmentLocations[] = {"All"};
          requiredMedic = 0;
          treatmentTime = 2;
          items[] = {};
          condition = "!([_target] call ace_common_fnc_isAwake)";
          statement = "[_player, _target] call kat_aceAirway_fnc_checkAirway";
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
            class Guedeltubus: larynxtubus {
              displayName = "$STR_kat_aceAirway_Guedel_Display";
              requiredMedic = 0;
              items[] = {"ACE_guedel"};
              statement = "[_player, _target, 'head', 'guedel'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
              icon = "\kat_aceAirway\images\guedel.paa";
            };
            class Accuvac: larynxtubus {
              displayName = "Accuvac";
              statement = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_accuvac";
              items[] = {"ACE_accuvac"};
              icon = "\kat_aceAirway\images\accuvac.paa";
            };
            class Overstretch: larynxtubus {
              displayName = "$STR_kat_aceAirway_overstretch";
              displayNameProgress = $STR_kat_aceAirway_overstretching;
              treatmentTime = 2;
              requiredMedic = 0;
              items[] = {};
              icon = "";
              condition = "!([_target] call ace_common_fnc_isAwake) && ((_target getVariable ""kat_aceAirway_overstretch"") isEqualTo false)";
              statement = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_overstretchHead";
            };
            class CheckPulse;
            class CheckAirway: checkPulse {
              displayName = "$STR_kat_aceAirway_checkAirway";
              displayNameProgress = "$STR_kat_aceAirway_checkAirway";
              treatmentLocations[] = {"All"};
              requiredMedic = 0;
              treatmentTime = 2;
              items[] = {};
              condition = "!([_target] call ace_common_fnc_isAwake)";
              statement = "[_player, _target] call kat_aceAirway_fnc_checkAirway";
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
    class Guedeltubus: larynxtubus {
      displayName = $STR_kat_aceAirway_Guedel_Display;
      items[] = {"ACE_guedel"};
      condition = "!([_target] call ace_common_fnc_isAwake)";
      callbackSuccess = "[_player, _target, 'head', 'guedel'] call kat_aceAirway_fnc_treatmentAdvanced_airway";
    };
    class Accuvac: larynxtubus {
      displayName = "Accuvac";
      treatmentTime = 10;
      items[] = {"ACE_accuvac"};
      condition = "!([_target] call ace_common_fnc_isAwake)";
      callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_accuvac";
    };
    class Overstretch: larynxtubus {
      displayName = "$STR_kat_aceAirway_overstretch";
      displayNameProgress = $STR_kat_aceAirway_overstretching;
      treatmentTime = 2;
      requiredMedic = 0;
      items[] = {};
      patientStateCondition = 0;
      condition = "!([_target] call ace_common_fnc_isAwake) && ((_target getVariable ""kat_aceAirway_overstretch"") isEqualTo false)";
      callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_treatmentAdvanced_overstretchHead";
    };
    class CheckPulse;
    class CheckAirway: checkPulse {
      displayName = "$STR_kat_aceAirway_checkAirway";
      displayNameProgress = $STR_kat_aceAirway_action_checking;
      treatmentTime = 10;
      allowedSelections[] = {"head"};
      items[] = {};
      condition = "!([_target] call ace_common_fnc_isAwake)";
      patientStateCondition = 0;
      callbackSuccess = "[_player, _target] call kat_aceAirway_fnc_checkAirway";
    };
	};
};
