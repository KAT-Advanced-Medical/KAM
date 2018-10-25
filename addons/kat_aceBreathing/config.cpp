#include "BIS_AddonInfo.hpp"
#include "gui.hpp"
class CfgPatches
{
    class kat_aceBreathing
    {
        units[] = {
			"kat_aceBreathing_pulsoximeterItem"
		};
        weapons[] = {
      "kat_aceBreathing_pulsoximeter"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical",
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
	class kat_aceBreathing {
    file = "kat_aceBreathing\functions";
		class functions {
        class events{};
        class handleInit{};
        class init{};
        class openMenu{};
        class registerSettings{};
        class treatmentAdvanced_pulsoximeter{};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class kat_aceBreathing_preInit {
		init = "call kat_aceBreathing_fnc_registerSettings";
	};
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceBreathing_init {
            init = "_this call kat_aceBreathing_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
  class kat_aceBreathing_postInit {
    init = "call kat_aceBreathing_fnc_events";
  };
};


class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;

  class Kat_Pulsoximeter: ACE_ItemCore {
      scope=2;
      author = "Katalam";
      displayName= "$STR_kat_aceBreathing_Pulsoximeter_Display";
      descriptionShort = "$STR_kat_aceBreathing_Pulsoximeter_Desc_Short";
      descriptionUse = "$STR_kat_aceBreathing_Pulsoximeter_Desc_Use";
      picture = "\kat_aceBreathing\images\Pulsoximeter_normal.paa";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 1;
      };
  };
};

class cfgVehicles {
	class Item_Base_F;

  class Kat_PulsoximeterItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_kat_aceBreathing_Pulsoximeter_Display";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(Kat_Pulsoximeter,1);
      };
  };

  class NATO_Box_Base;
  class ACE_medicalSupplyCrate: NATO_Box_Base {
    class TransportItems;
  };
  class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
    class TransportItems: TransportItems {
      MACRO_ADDITEM(Kat_Pulsoximeter,3);
    };
  };

class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_ArmLeft {
        class Pulsoximeter {
          displayName = "$STR_kat_aceBreathing_Pulsoximeter_Display";
          distance = 2.0;
          condition = "[_player, _target, 'hand_l', 'Pulsoximeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'Pulsoximeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
			};
      class ACE_ArmRight {
        class Pulsoximeter {
          displayName = "$STR_kat_aceBreathing_Pulsoximeter_Display";
          distance = 2.0;
          condition = "[_player, _target, 'hand_r', 'Pulsoximeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'Pulsoximeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
      };
			class ACE_MainActions {
				class Medical {
					class ACE_ArmLeft {
            class Pulsoximeter {
              displayName = "$STR_kat_aceBreathing_Pulsoximeter_Display";
              distance = 2.0;
              condition = "[_player, _target, 'hand_l', 'Pulsoximeter'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'hand_l', 'Pulsoximeter'] call ace_medical_fnc_treatment";
              exceptions[] = {""};
              showDisabled = 0;
              icon = "";
            };
				   };
         class ACE_ArmRight {
           class Pulsoximeter {
             displayName = "$STR_kat_aceBreathing_Pulsoximeter_Display";
             distance = 2.0;
             condition = "[_player, _target, 'hand_r', 'Pulsoximeter'] call ace_medical_fnc_canTreatCached";
             statement = "[_player, _target, 'hand_r', 'Pulsoximeter'] call ace_medical_fnc_treatment";
             exceptions[] = {""};
             showDisabled = 0;
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
    class Pulsoximeter {
        displayName = "$STR_kat_aceBreathing_Pulsoximeter_Display";
        displayNameProgress = $STR_kat_aceBreathing_placing;
        category = "advanced";
        treatmentLocations[] = {"All"};
        allowedSelections[] = {"hand_l", "hand_r"};
        allowSelfTreatment = 0;
        requiredMedic = 1;
        treatmentTime = 2;
        items[] = {"Kat_Pulsoximeter"};
        condition = "!([_target] call ace_common_fnc_isAwake) && kat_aceBreathing_enable";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target] call kat_aceBreathing_fnc_treatmentAdvanced_pulsoximeter";
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
	};
};
