#include "BIS_AddonInfo.hpp"
class CfgPatches {
    class kat_aceMisc {
        units[] = {

        };
        weapons[] = {

        };
        requiredVersion = 1.80;
        requiredAddons[] = {
            "ace_medical",
            "cba_settings"
        };
        version = "1.0";
        versionStr = "1.0";
        author = "[SeL] Katalam";
        authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgFunctions {
    class kat_aceMisc {
        file = "kat_aceMisc\functions";
        class functions {
            class addIVbag{};
            class conditionIV;
            class conditionIVstand{};
            class events{};
            class handleInit{};
            class init{};
            class registerSettings{};
            class removeIVbag{};
            class treatmentIV{};
        };
    };
};

class Extended_PreInit_EventHandlers {
    class kat_aceMisc_preInit {
        init = "call kat_aceMisc_fnc_registerSettings";
    };
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceMisc_init {
            init = "_this call kat_aceMisc_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
    class kat_aceMisc_postInit {
        init = "call kat_aceMisc_fnc_events";
    };
};

class cfgVehicles {
    class Land_IntravenStand_01_base_F;

    class Land_IntravenStand_01_empty_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };
    class Land_IntravenStand_01_1bag_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };
    class Land_IntravenStand_01_2bags_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_ArmLeft {
                class SalineIV;

                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_ArmRight {
                class SalineIV;

                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_LegLeft {
                class SalineIV;

                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_LegRight {
                class SalineIV;

                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
        };
    };
};

class ACE_Medical_Actions {
    class Advanced {
        class SalineIV;

        class SalineIV_Stand: SalineIV {
            displayName = "$STR_kat_aceMisc_Display_IVStand";
            requiredMedic = 0;
            condition = "kat_aceMisc_fnc_conditionIV";
            items[] = {};
            callbackSuccess = "[_player, _target, _selectionName, 'SalineIV', ['SalineIV']] call kat_aceMisc_fnc_treatmentIV";
            itemConsumed = 0;
        };
    };
};
