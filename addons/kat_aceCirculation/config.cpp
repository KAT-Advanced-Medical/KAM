#include "BIS_AddonInfo.hpp"
class CfgPatches
{
    class kat_aceCirculation
    {
        units[] = {
			"ACE_painKillerItem"
		};
        weapons[] = {
      "ACE_painKiller"
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
	class kat_aceCirculation {
    file = "kat_aceCirculation\functions";
		class functions {
        class bloodType{};
        class events{};
        class groupID{};
        class handleInit{};
        class init{};
        class registerSettings{};
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


class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
  class ACE_bloodIV;
  class ACE_bloodIV_O: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_O;
  };
  class ACE_bloodIV_A: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_A;
  };
  class ACE_bloodIV_B: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_B;
  };
  class ACE_bloodIV_AB: ACE_bloodIV {
    displayName = $STR_KAT_aceCirculation_BloodIV_AB;
  };
  class ACE_painKiller: ACE_ItemCore {
    scope = 2;
    author = "Katalam";
    displayName = $STR_KAT_aceCirculation_PainKiller_Display;
    picture = "\z\ace\addons\medical\ui\items\adenosine_x_ca.paa";
    model = "\z\ace\addons\medical\data\adenosine.p3d";
    descriptionShort = $STR_KAT_aceCirculation_PainKiller_DescShort;
    descriptionUse = $STR_KAT_aceCirculation_PainKiller_DescUse;
    class ItemInfo: CBA_MiscItem_ItemInfo {
        mass = 1;
    };
  };
};

class cfgVehicles {
	class Item_Base_F;

  class ACE_painKillerItem: Item_Base_F {
      scope = 2;
      scopeCurator = 2;
      displayName= "$STR_KAT_aceCirculation_PainKiller_Display";
      author = "Katalam";
      vehicleClass = "Items";
      //editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_PainKillers_F.jpg";
      class TransportItems {
          MACRO_ADDITEM(ACE_painKiller,1);
      };
  };

  class NATO_Box_Base;
	class ACE_medicalSupplyCrate: NATO_Box_Base {
		class TransportItems;
	};
	class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
		class TransportItems: TransportItems {
			MACRO_ADDITEM(ACE_painKiller,20);
		};
	};

class Man;
	class CAManBase: Man {
		class ACE_Actions {
      class ACE_Dogtag {
          displayName = "$STR_ACE_Dogtags_itemName";
          condition = "[_player,_target] call ace_dogtags_fnc_canTakeDogtag";
          statement = "";
          exceptions[] = {"isNotSwimming", "isNotInside"};
          showDisabled = 0;
          distance = 1.75;
          //icon = QPATHTOF(data\dogtag_icon_ca.paa);
          selection = "neck";
          class ACE_CheckDogtag {
            displayName = "$STR_ACE_Dogtags_checkDogtag";
            condition = "[_player,_target] call ace_dogtags_fnc_canTakeDogtag";
            statement = "[_player,_target] call ace_dogtags_fnc_checkDogtag";
            exceptions[] = {"isNotSwimming", "isNotInside"};
            showDisabled = 0;
            //icon = QPATHTOF(data\dogtag_icon_ca.paa);
          };
			};
      class ACE_ArmLeft {
        class FieldDressing;
        class Morphine;
        class Painkiller: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_PainKiller;
          condition = "[_player, _target, 'hand_l', 'Painkiller'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'Painkiller'] call ace_medical_fnc_treatment";
        };
        class BloodIV;
        class BloodIV_O: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_O;
          condition = "[_player, _target, 'hand_l', 'BloodIV_O'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'BloodIV_O'] call ace_medical_fnc_treatment";
        };
        class BloodIV_A: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_A;
          condition = "[_player, _target, 'hand_l', 'BloodIV_A'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'BloodIV_A'] call ace_medical_fnc_treatment";
        };
        class BloodIV_B: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_B;
          condition = "[_player, _target, 'hand_l', 'BloodIV_B'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'BloodIV_B'] call ace_medical_fnc_treatment";
        };
        class BloodIV_AB: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB;
          condition = "[_player, _target, 'hand_l', 'BloodIV_AB'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_l', 'BloodIV_AB'] call ace_medical_fnc_treatment";
        };
      };
      class ACE_ArmRight {
        class FieldDressing;
        class Morphine;
        class Painkiller: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_PainKiller;
          condition = "[_player, _target, 'hand_r', 'Painkiller'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'Painkiller'] call ace_medical_fnc_treatment";
        };
        class BloodIV;
        class BloodIV_O: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_O;
          condition = "[_player, _target, 'hand_r', 'BloodIV_O'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'BloodIV_O'] call ace_medical_fnc_treatment";
        };
        class BloodIV_A: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_A;
          condition = "[_player, _target, 'hand_r', 'BloodIV_A'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'BloodIV_A'] call ace_medical_fnc_treatment";
        };
        class BloodIV_B: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_B;
          condition = "[_player, _target, 'hand_r', 'BloodIV_B'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'BloodIV_B'] call ace_medical_fnc_treatment";
        };
        class BloodIV_AB: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB;
          condition = "[_player, _target, 'hand_r', 'BloodIV_AB'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'hand_r', 'BloodIV_AB'] call ace_medical_fnc_treatment";
        };
      };
      class ACE_LegLeft {
        class FieldDressing;
        class Morphine;
        class Painkiller: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_PainKiller;
          condition = "[_player, _target, 'leg_l', 'Painkiller'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'Painkiller'] call ace_medical_fnc_treatment";
        };
        class BloodIV;
        class BloodIV_O: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_O;
          condition = "[_player, _target, 'leg_l', 'BloodIV_O'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'BloodIV_O'] call ace_medical_fnc_treatment";
        };
        class BloodIV_A: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_A;
          condition = "[_player, _target, 'leg_l', 'BloodIV_A'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'BloodIV_A'] call ace_medical_fnc_treatment";
        };
        class BloodIV_B: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_B;
          condition = "[_player, _target, 'leg_l', 'BloodIV_B'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'BloodIV_B'] call ace_medical_fnc_treatment";
        };
        class BloodIV_AB: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB;
          condition = "[_player, _target, 'leg_l', 'BloodIV_AB'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_l', 'BloodIV_AB'] call ace_medical_fnc_treatment";
        };
      };
      class ACE_LegRight {
        class FieldDressing;
        class Morphine;
        class Painkiller: Morphine {
          displayName = $STR_KAT_aceCirculation_Inject_PainKiller;
          condition = "[_player, _target, 'leg_r', 'Painkiller'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'Painkiller'] call ace_medical_fnc_treatment";
        };
        class BloodIV;
        class BloodIV_O: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_O;
          condition = "[_player, _target, 'leg_r', 'BloodIV_O'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'BloodIV_O'] call ace_medical_fnc_treatment";
        };
        class BloodIV_A: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_A;
          condition = "[_player, _target, 'leg_r', 'BloodIV_A'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'BloodIV_A'] call ace_medical_fnc_treatment";
        };
        class BloodIV_B: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_B;
          condition = "[_player, _target, 'leg_r', 'BloodIV_B'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'BloodIV_B'] call ace_medical_fnc_treatment";
        };
        class BloodIV_AB: BloodIV {
          displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB;
          condition = "[_player, _target, 'leg_r', 'BloodIV_AB'] call ace_medical_fnc_canTreatCached";
          statement = "[_player, _target, 'leg_r', 'BloodIV_AB'] call ace_medical_fnc_treatment";
        };
      };
      class ACE_SelfActions {
          class ACE_Equipment {
              class ACE_CheckDogtags {
                  displayName = "$STR_ACE_Dogtags_checkItem";
                  condition = "true";
                  statement = "";
                  exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                  insertChildren = "_player call ace_dogtags_fnc_addDogtagActions";
              };
          };
      };
     };
   };
};

class ACE_Medical_Actions {
	class Advanced {
    class FieldDressing;
    class Morphine;
    class Painkiller: Morphine {
      displayName = $STR_KAT_aceCirculation_Inject_PainKiller;
      displayNameProgress = $STR_KAT_aceCirculation_Injecting;
      items[] = {"ACE_painKiller"};
    };
    class CheckPulse;
    class CheckDogtags: checkPulse {
      displayName = "Check Dogtags";
      displayNameProgress = "Checking";
      treatmentTime = 2;
      allowedSelections[] = {"body"};
      allowSelfTreatment = 1;
      callbackSuccess = "[_player, _target] call ace_dogtags_fnc_checkDogtag";
      condition = "true";
    };
    class BloodIV;
    class BloodIV_O: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_O
      items[] = {"ACE_bloodIV_O"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_A: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_A
      items[] = {"ACE_bloodIV_A"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_B: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_B
      items[] = {"ACE_bloodIV_B"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
    };
    class BloodIV_AB: BloodIV {
      displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB
      items[] = {"ACE_bloodIV_AB"};
      callbackSuccess = "_this call kat_aceCirculation_fnc_handleTreatment";
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
      class Painkiller {
        painReduce = 5;
        timeInSystem = 600;
        maxDose = 10;
        inCompatableMedication[] = {};
        viscosityChange = 0;
        hrIncreaseLow[] = {-1, -2, 35};
        hrIncreaseNormal[] = {-1, -3, 35};
        hrIncreaseHigh[] = {-1, -4, 50};
      };
    };
  };
};
