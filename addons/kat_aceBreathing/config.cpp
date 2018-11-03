#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceBreathing
    {
        units[] = {
			"KAT_PulsoxymeterItem"
		};
        weapons[] = {
      "KAT_Pulsoxymeter"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical",
      "kat_aceAirway",
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
        class canPulsoxymeter{};
        class events{};
        class handleInit{};
        class handleTimer{};
        class handleTimerAlive{};
        class init{};
        class registerSettings{};
        class treatmentAdvanced_pulsoxymeter{};
        class treatmentAdvanced_pulsoxymeterLocal{};
        class treatmentAdvanced_removePulsoxymeter{};
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

  class KAT_Pulsoxymeter: ACE_ItemCore {
      scope = 2;
      author = "Katalam";
      displayName= "$STR_kat_aceBreathing_Pulsoxymeter_Display";
      descriptionShort = "$STR_kat_aceBreathing_Pulsoxymeter_Desc_Short";
      descriptionUse = "$STR_kat_aceBreathing_Pulsoxymeter_Desc_Use";
      picture = "\kat_aceBreathing\images\Pulsoxymeter_normal.paa";
      class ItemInfo: CBA_MiscItem_ItemInfo {
          mass = 1;
      };
  };
};

class cfgVehicles {
	class Item_Base_F;

  class KAT_PulsoxymeterItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_kat_aceBreathing_Pulsoxymeter_Display";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(KAT_Pulsoxymeter,1);
      };
  };

  class NATO_Box_Base;
  class ACE_medicalSupplyCrate: NATO_Box_Base {
    class TransportItems;
  };
  class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
    class TransportItems: TransportItems {
      MACRO_ADDITEM(KAT_Pulsoxymeter,3);
    };
  };

class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_ArmLeft {
        class Pulsoxymeter {
          displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display;
          distance = 2.0;
          condition = "[_player, _target, 'hand_l', 'Pulsoxymeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'Pulsoxymeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
        class RemovePulsoxymeter {
          displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display_Remove;
          distance = 2.0;
          condition = "[_player, _target, 'hand_l', 'RemovePulsoxymeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'RemovePulsoxymeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
			};
      class ACE_ArmRight {
        class Pulsoxymeter {
          displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display;
          distance = 2.0;
          condition = "[_player, _target, 'hand_r', 'Pulsoxymeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'Pulsoxymeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
        class RemovePulsoxymeter {
          displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display_Remove;
          distance = 2.0;
          condition = "[_player, _target, 'hand_r', 'RemovePulsoxymeter'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'RemovePulsoxymeter'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          showDisabled = 0;
          icon = "";
        };
      };
			class ACE_MainActions {
				class Medical {
					class ACE_ArmLeft {
            class Pulsoxymeter {
              displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display;
              distance = 2.0;
              condition = "[_player, _target, 'hand_l', 'Pulsoxymeter'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'hand_l', 'Pulsoxymeter'] call ace_medical_fnc_treatment";
              exceptions[] = {""};
              showDisabled = 0;
              icon = "";
            };
            class RemovePulsoxymeter {
              displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display_Remove;
              distance = 2.0;
              condition = "[_player, _target, 'hand_l', 'RemovePulsoxymeter'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'hand_l', 'RemovePulsoxymeter'] call ace_medical_fnc_treatment";
              exceptions[] = {""};
              showDisabled = 0;
              icon = "";
            };
				   };
         class ACE_ArmRight {
           class Pulsoxymeter {
             displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display;
             distance = 2.0;
             condition = "[_player, _target, 'hand_r', 'Pulsoxymeter'] call ace_medical_fnc_canTreatCached";
             statement = "[_player, _target, 'hand_r', 'Pulsoxymeter'] call ace_medical_fnc_treatment";
             exceptions[] = {""};
             showDisabled = 0;
             icon = "";
           };
           class RemovePulsoxymeter {
             displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display_Remove;
             distance = 2.0;
             condition = "[_player, _target, 'hand_r', 'RemovePulsoxymeter'] call ace_medical_fnc_canTreatCached";
             statement = "[_player, _target, 'hand_r', 'RemovePulsoxymeter'] call ace_medical_fnc_treatment";
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
    class Pulsoxymeter {
        displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display;
        displayNameProgress = $STR_kat_aceBreathing_placing;
        category = "examine";
        treatmentLocations[] = {"All"};
        allowedSelections[] = {"hand_l", "hand_r"};
        allowSelfTreatment = 0;
        requiredMedic = 1;
        treatmentTime = 2;
        items[] = {"KAT_Pulsoxymeter"};
        condition = "missionNamespace getVariable 'kat_aceBreathing_enable'";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target] call kat_aceBreathing_fnc_treatmentAdvanced_pulsoxymeter";
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
    class RemovePulsoxymeter {
        displayName = $STR_kat_aceBreathing_Pulsoxymeter_Display_Remove;
        displayNameProgress = $STR_kat_aceBreathing_remove;
        category = "examine";
        treatmentLocations[] = {"All"};
        allowedSelections[] = {"hand_l", "hand_r"};
        allowSelfTreatment = 0;
        requiredMedic = 1;
        treatmentTime = 2;
        items[] = {};
        condition = "[_target] call kat_aceBreathing_fnc_canPulsoxymeter";
        patientStateCondition = 0;
        callbackSuccess = "[_player, _target] call kat_aceBreathing_fnc_treatmentAdvanced_removePulsoxymeter";
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
	};
};
