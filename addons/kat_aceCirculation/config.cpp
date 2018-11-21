#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceCirculation
    {
        units[] = {
			"KAT_PainkillersItem",
      "KAT_PainkillersBoxItem",
      "KAT_X_AEDItem"
		};
        weapons[] = {
      "KAT_Painkillers",
      "KAT_bloodIV_O",
      "KAT_bloodIV_A",
      "KAT_bloodIV_B",
      "KAT_bloodIV_AB",
      "KAT_Painkillers",
      "KAT_X_AED"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical",
      "ace_dogtags",
      "adv_aceCPR",
      "cba_settings"
		};
		version = "0.6";
		versionStr = "0.6";
		author = "[SeL] Katalam";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgFunctions {
	class kat_aceCirculation {
    file = "kat_aceCirculation\functions";
		class functions {
        class bloodType{};
        class compatible{};
        class events{};
        class groupID{};
        class handleInit{};
        class handleTreatment{};
        class init{};
        class registerSettings{};
        class removeEffect_IV{};
        class removeItemfromMag{};
        class treatmentAdvanced_IV{};
        class treatmentAdvanced_X{};
		};
	};
  class kat_aceDogtag {
    tag = "ace_dogtags";
    class ace_dogtags {
      class getDogtagData {
        file = "kat_aceCirculation\functions\fn_getDogtagData.sqf";
      };
      class canCheckDogtag {
        file = "kat_aceCirculation\functions\fn_canCheckDogtag.sqf";
      };
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

class CfgSounds {
  sounds[] = {};
  class KAT_HeartRate {
      name = "KAT_HeartRate";
      sound[] = {"kat_aceCirculation\sounds\heartrate.wav", db + 2, 1, 15};
      titles[]	= {};
  };
  class KAT_NoHeartRate {
      name = "KAT_NoHeartRate";
      sound[] = {"kat_aceCirculation\sounds\noheartrate.wav", db + 2, 1, 15};
      titles[]	= {};
  };
  class KAT_NoShock {
      name = "KAT_NoShock";
      sound[] = {"kat_aceCirculation\sounds\noshock.wav", db + 2, 1, 15};
      titles[]	= {};
  };
};

class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
  class ACE_bloodIV;
  class adv_aceCPR_AED;
  class KAT_bloodIV_O: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_O;
  };
  class KAT_bloodIV_A: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_A;
  };
  class KAT_bloodIV_B: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_B;
  };
  class KAT_bloodIV_AB: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_AB;
  };
  class KAT_Painkillers: ACE_ItemCore {
    scope = 2;
    author = "Katalam";
    displayName = $STR_KAT_aceCirculation_Painkillers_Display;
    picture = "\z\ace\addons\medical\ui\items\adenosine_x_ca.paa";
    model = "\z\ace\addons\medical\data\adenosine.p3d";
    descriptionShort = $STR_KAT_aceCirculation_Painkillers_DescShort;
    descriptionUse = $STR_KAT_aceCirculation_Painkillers_DescUse;
    class ItemInfo: CBA_MiscItem_ItemInfo {
        mass = 1;
    };
  };
  class KAT_X_AED: adv_aceCPR_AED {
    scope = 2;
    displayName = $STR_KAT_aceCirculation_X_Display;
    picture = "\kat_acecirculation\images\x-series.paa";
    model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
    descriptionShort = $STR_KAT_aceCirculation_X_Desc;
    descriptionUse = $STR_KAT_aceCirculation_X_Desc;
    class ItemInfo: CBA_MiscItem_ItemInfo {
      mass = 40;
    };
  };
};

class cfgMagazines {
  class CA_Magazine;
  class KAT_PainkillersBoxPill: CA_Magazine {
    author = "Katalam";
    scope = 2;

    displayName = "$STR_KAT_aceCirculation_Painkillers_Box_Display";
    descriptionShort = "$STR_KAT_aceCirculation_Painkillers_DescShort";
    model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";
    picture = "\kat_acecirculation\images\icon_painkillers.paa";

    ammo = "";
    count = 10;
    initSpeed = 0;
    tracersEvery = 0;
    lastRoundsTracer = 0;
    mass = 1;
  };
};

class cfgVehicles {
	class Item_Base_F;
  class KAT_PainkillersItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_KAT_aceCirculation_Painkillers_Display";
      author = "Katalam";
      vehicleClass = "Items";
      class TransportItems {
          MACRO_ADDITEM(KAT_Painkillers,1);
      };
  };
  class WeaponHolder_Single_limited_item_F;
  class KAT_PainkillersBoxItem: WeaponHolder_Single_limited_item_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_KAT_aceCirculation_Painkillers_Box_Display";
      author = "Katalam";
      vehicleClass = "Magazines";
      class TransportItems {
          MACRO_ADDITEM(KAT_PainkillersBoxPill,1);
      };
  };
  class adv_aceCPR_AEDItem;
  class KAT_X_AEDItem: adv_aceCPR_AEDItem {
    scope = 2;
    scopeCurator = 2;
    displayName = "$STR_KAT_aceCirculation_X_Display";
    author = "[SeL] Katalam";
    class TransportItems {
        MACRO_ADDITEM(KAT_X_AED,1);
    };
	};

  class NATO_Box_Base;
	class ACE_medicalSupplyCrate: NATO_Box_Base {
		class TransportItems;
	};
	class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
		class TransportItems: TransportItems {
			MACRO_ADDITEM(KAT_Painkillers,20);
      MACRO_ADDITEM(KAT_PainkillersBoxPill,5);
      MACRO_ADDITEM(KAT_X_AED,1);
		};
	};

class Man;
	class CAManBase: Man {
		class ACE_Actions {
      class ACE_Dogtag {
        condition = "[_player, _target] call ace_dogtags_fnc_canCheckDogtag";
      };
      class ACE_Head {
        class CheckBloodPressure {}; // Remove the ability to check blood pressure at the head
        class PainkillersBox {
          displayName = "$STR_KAT_aceCirculation_Inject_Box_Painkillers";
          condition = "'KAT_PainkillersBoxPill' in (magazines _player)";
          statement = "['KAT_PainkillersBoxPill', _player, _target, 'head', 'Painkillers'] call kat_aceCirculation_fnc_removeItemfromMag";
          showDisabled = 0;
          exceptions[] = {"isNotInside", "isNotSitting"};
          icon = "kat_aceCirculation\images\icon_painkillers_action.paa";
        };
      };
      class ACE_Torso {
  			class CPR;
  			class KAT_X_AED: CPR {
  				displayName = $STR_KAT_aceCirculation_X_Action_Use;
  				condition = "[_player, _target, 'body', 'X_Defibrillator'] call ace_medical_fnc_canTreatCached";
  				statement = "[_player, _target, 'body', 'X_Defibrillator'] call ace_medical_fnc_treatment";
  				exceptions[] = {""};
  				icon = "kat_aceCirculation\images\X_Series-Device_W.paa";
  			};
        class KAT_R_X_AED: CPR {
          displayName = $STR_KAT_aceCirculation_X_Action_Remove;
          condition = "[_player, _target, 'body', 'Remove_X_Defibrillator'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'body', 'Remove_X_Defibrillator'] call ace_medical_fnc_treatment";
          exceptions[] = {""};
          icon = "kat_aceCirculation\images\X_Series-Device_W.paa";
        };
      };
      class ACE_ArmLeft {
        class FieldDressing;
        class Morphine;
        class Painkillers: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
          condition = "[_player, _target, 'hand_l', 'Painkillers'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'Painkillers'] call ace_medical_fnc_treatment";
        };
        #include "Blood_ArmL.hpp"
      };
      class ACE_ArmRight {
        class FieldDressing;
        class Morphine;
        class Painkillers: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
          condition = "[_player, _target, 'hand_r', 'Painkillers'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'Painkillers'] call ace_medical_fnc_treatment";
        };
        #include "Blood_ArmR.hpp"
      };
      class ACE_LegLeft {
        class FieldDressing;
        class Morphine;
        class Painkillers: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
          condition = "[_player, _target, 'leg_l', 'Painkillers'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'Painkillers'] call ace_medical_fnc_treatment";
        };
        #include "Blood_LegL.hpp"
      };
      class ACE_LegRight {
        class FieldDressing;
        class Morphine;
        class Painkillers: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
          condition = "[_player, _target, 'leg_r', 'Painkillers'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'Painkillers'] call ace_medical_fnc_treatment";
        };
        #include "Blood_LegR.hpp"
      };
      class ACE_MainActions {
        class Medical {
          class ACE_Head {
            class CheckBloodPressure {}; // Remove the ability to check blood pressure at the head
            class PainkillersBox {
              displayName = "$STR_KAT_aceCirculation_Inject_Box_Painkillers";
              condition = "'KAT_PainkillersBoxPill' in (magazines _player)";
              statement = "['KAT_PainkillersBoxPill', _player, _target, 'head', 'Painkillers'] call kat_aceCirculation_fnc_removeItemfromMag";
              showDisabled = 0;
              exceptions[] = {"isNotInside", "isNotSitting"};
              icon = "kat_aceCirculation\images\icon_painkillers_action.paa";
            };
          };
          class ACE_Torso {
      			class CPR;
            class KAT_X_AED: CPR {
      				displayName = $STR_KAT_aceCirculation_X_Action_Use;
      				condition = "[_player, _target, 'body', 'X_Defibrillator'] call ace_medical_fnc_canTreatCached";
      				statement = "[_player, _target, 'body', 'X_Defibrillator'] call ace_medical_fnc_treatment";
      				exceptions[] = {""};
      				icon = "kat_aceCirculation\images\X_Series-Device_W.paa";
      			};
            class KAT_R_X_AED: CPR {
              displayName = $STR_KAT_aceCirculation_X_Action_Remove;
              condition = "[_player, _target, 'body', 'Remove_X_Defibrillator'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'body', 'Remove_X_Defibrillator'] call ace_medical_fnc_treatment";
              exceptions[] = {""};
              icon = "kat_aceCirculation\images\X_Series-Device_W.paa";
            };
          };
          class ACE_ArmLeft {
            class FieldDressing;
            class Morphine;
            class Painkillers: Morphine {
              displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
              condition = "[_player, _target, 'hand_l', 'Painkillers'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'hand_l', 'Painkillers'] call ace_medical_fnc_treatment";
            };
            #include "Blood_ArmL.hpp"
          };
          class ACE_ArmRight {
            class FieldDressing;
            class Morphine;
            class Painkillers: Morphine {
              displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
              condition = "[_player, _target, 'hand_r', 'Painkillers'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'hand_r', 'Painkillers'] call ace_medical_fnc_treatment";
            };
            #include "Blood_ArmR.hpp"
          };
          class ACE_LegLeft {
            class FieldDressing;
            class Morphine;
            class Painkillers: Morphine {
              displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
              condition = "[_player, _target, 'leg_l', 'Painkillers'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'leg_l', 'Painkillers'] call ace_medical_fnc_treatment";
            };
            #include "Blood_LegL.hpp"
          };
          class ACE_LegRight {
            class FieldDressing;
            class Morphine;
            class Painkillers: Morphine {
              displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
              condition = "[_player, _target, 'leg_r', 'Painkillers'] call ace_medical_fnc_canTreatCached";
              statement = "[_player, _target, 'leg_r', 'Painkillers'] call ace_medical_fnc_treatment";
            };
            #include "Blood_LegR.hpp"
          };
        };
      };
    };
    class ACE_SelfActions {
      class Medical {
        class ACE_Head {
          class PainkillersBox {
            displayName = "$STR_KAT_aceCirculation_Inject_Box_Painkillers";
            condition = "'KAT_PainkillersBoxPill' in (magazines _player)";
            statement = "['KAT_PainkillersBoxPill', _player, _target, 'head', 'Painkillers'] call kat_aceCirculation_fnc_removeItemfromMag";
            showDisabled = 0;
            exceptions[] = {"isNotInside", "isNotSitting"};
            icon = "kat_aceCirculation\images\icon_painkillers_action.paa";
          };
        };
      };
      class ACE_Equipment {
        class removeSound {
          displayName = "$STR_KAT_aceCirculation_X_Action_removeSound";
          condition = "'KAT_X_AED' in (items _player) && !((_player getVariable 'kat_aceCirculation_X_sound1') isEqualTo '')";
          statement = "_player setVariable ['kat_aceCirculation_X_sound1', '', true]; _player setVariable ['kat_aceCirculation_X_sound2', '', true];";
          showDisabled = 0;
          exceptions[] = {"isNotInside", "isNotSitting"};
          icon = "";
        };
        class addSound {
          displayName = "$STR_KAT_aceCirculation_X_Action_addSound";
          condition = "'KAT_X_AED' in (items _player) && ((_player getVariable 'kat_aceCirculation_X_sound1') isEqualTo '')";
          statement = "_player setVariable ['kat_aceCirculation_X_sound1', 'kat_aceCirculation\sounds\noheartrate.wav', true]; _player setVariable ['kat_aceCirculation_X_sound2', 'kat_aceCirculation\sounds\heartrate.wav', true];";
          showDisabled = 0;
          exceptions[] = {"isNotInside", "isNotSitting"};
          icon = "";
        };
      };
    };
  };
};

class ACE_Medical_Actions {
	class Advanced {
    class FieldDressing;
    class Morphine;
    class Painkillers: Morphine {
      displayName = $STR_KAT_aceCirculation_Inject_Painkillers;
      displayNameProgress = $STR_KAT_aceCirculation_Injecting;
      items[] = {"KAT_Painkillers"};
    };
    class KAT_PainkillersBoxPill: Morphine {
      displayName = $STR_KAT_aceCirculation_Inject_Box_Painkillers;
      displayNameProgress = $STR_KAT_aceCirculation_Injecting;
      allowedSelections[] = {"head"};
      items[] = {};
      condition = "'KAT_PainkillersBoxPill' in (magazines _player)";
    };
    class CheckPulse;
    class CheckDogtags: checkPulse {
      displayName = $STR_KAT_aceCirculation_DogTag;
      displayNameProgress = $STR_KAT_aceCirculation_DogTag_Action;
      treatmentTime = 2;
      allowedSelections[] = {"body"};
      allowSelfTreatment = 1;
      callbackSuccess = "[_player, _target] call ace_dogtags_fnc_checkDogtag";
      condition = "true";
    };
    class BloodIV;
    class BloodIV_O: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_O
      items[] = {"KAT_bloodIV_O"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_A: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_A
      items[] = {"KAT_bloodIV_A"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_B: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_B
      items[] = {"KAT_bloodIV_B"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_AB: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB
      items[] = {"KAT_bloodIV_AB"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class CPR;
    class Defibrillator: CPR {
      items[] = {{"adv_aceCPR_AED", "KAT_X_AED"}};
    };
    class X_Defibrillator: CPR {
      displayName = $STR_KAT_aceCirculation_X_Action_Use;
      displayNameProgress = $STR_KAT_aceCirculation_X_Action_Progress;
      items[] = {"KAT_X_AED"};
      condition = "!(_player getVariable ['kat_aceCirculation_use',false])";
      treatmentTime = 2;
      requiredMedic = 1;
      callbackProgress = "";
      callbackSuccess = "[_player, _target] call kat_aceCirculation_fnc_treatmentAdvanced_X";
      animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
    };
    class Remove_X_Defibrillator: X_Defibrillator {
      displayName = $STR_KAT_aceCirculation_X_Action_Remove;
      items[] = {};
      condition = "_target getVariable ['kat_aceCirculation_X', true]";
      treatmentTime = 2;
      callbackProgress = "";
      callbackSuccess = "_target setVariable ['kat_aceCirculation_X', false, true]; _player setVariable ['kat_aceCirculation_use', false, true]";
    };
	};
  class Treatment {
    class IV {
      class BloodIV;
      class BloodIV_O: BloodIV {
        bloodType = "O";
        compatibility[] = {"O", "A", "B", "AB"};
      };
      class BloodIV_A: BloodIV {
        bloodType = "A";
        compatibility[] = {"A", "AB"};
      };
      class BloodIV_B: BloodIV {
        bloodType = "B";
        compatibility[] = {"B", "AB"};
      };
      class BloodIV_AB: BloodIV {
        bloodType = "AB";
        compatibility[] = {"AB"};
      };

      class BloodIV_500;
      class BloodIV_500_O: BloodIV_500 {
        bloodType = "O";
        compatibility[] = {"O", "A", "B", "AB"};
      };
      class BloodIV_500_A: BloodIV_500 {
        bloodType = "A";
        compatibility[] = {"A", "AB"};
      };
      class BloodIV_500_B: BloodIV_500 {
        bloodType = "B";
        compatibility[] = {"B", "AB"};
      };
      class BloodIV_500_AB: BloodIV_500 {
        bloodType = "AB";
        compatibility[] = {"AB"};
      };

      class BloodIV_250;
      class BloodIV_250_O: BloodIV_250 {
        bloodType = "O";
        compatibility[] = {"O", "A", "B", "AB"};
      };
      class BloodIV_250_A: BloodIV_250 {
        bloodType = "A";
        compatibility[] = {"A", "AB"};
      };
      class BloodIV_250_B: BloodIV_250 {
        bloodType = "B";
        compatibility[] = {"B", "AB"};
      };
      class BloodIV_250_AB: BloodIV_250 {
        bloodType = "AB";
        compatibility[] = {"AB"};
      };
    };
    class Medication {
      class Atropine {
        //{minIncrease, maxIncrease, seconds}
        //change for effect from Atropine. Anomalie here, if you give more it will push your heart rate
        hrIncreaseLow[] = {2, 5, 15};
        hrIncreaseNormal[] = {10, 15, 20};
        hrIncreaseHigh[] = {5, 20, 10};
      };
    };
  };
};
