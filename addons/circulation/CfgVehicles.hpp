#define QQPATHTOF(var1) QUOTE(QPATHTOF(var1))

class CfgVehicles {
    class Item_Base_F;
    class Items_base_F;
    class WeaponHolder_Single_limited_item_F;
    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
        class TransportMagazines;
    };

    class Land_Defibrillator_F: Items_base_F {
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0,1,1};
        ace_dragging_carryDirection = 270;
        ace_cargo_size = 1;
        ace_cargo_canLoad = 1;
    };

    class kat_AEDItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_KAT_circulation_AED_DISPLAYNAME";
        author = "Katalam";
        vehicleClass = "Items";
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        class TransportItems {
            MACRO_ADDITEM(kat_AED,1);
        };
    };

    class kat_X_AEDItem: kat_AEDItem {
        displayName = CSTRING(X_Display);
        model = QPATHTOF(models\aedx\aedx.p3d);
        class TransportItems {
            MACRO_ADDITEM(kat_X_AED,1);
        };
    };

    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_X_AED,1);
            MACRO_ADDITEM(kat_AED,1);
            MACRO_ADDITEM(KAT_Empty_bloodIV_500,10);
            MACRO_ADDITEM(KAT_Empty_bloodIV_250,20);
            MACRO_ADDITEM(kat_crossPanel,5);
        };
        class TransportMagazines: TransportMagazines {
            MACRO_ADDMAGAZINE(kat_Painkiller,10);
        };
    };
    class kat_medicalSupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(bloodbank);
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_crossPanel,5);
            MACRO_ADDITEM(kat_bloodIV_O,5);
            MACRO_ADDITEM(kat_bloodIV_O_N,5);
            MACRO_ADDITEM(kat_bloodIV_A,10);
            MACRO_ADDITEM(kat_bloodIV_A_N,10);
            MACRO_ADDITEM(kat_bloodIV_B,10);
            MACRO_ADDITEM(kat_bloodIV_B_N,10);
            MACRO_ADDITEM(kat_bloodIV_AB,10);
            MACRO_ADDITEM(kat_bloodIV_AB_N,10);
            MACRO_ADDITEM(kat_bloodIV_O_500,5);
            MACRO_ADDITEM(kat_bloodIV_O_N_500,5);
            MACRO_ADDITEM(kat_bloodIV_A_500,10);
            MACRO_ADDITEM(kat_bloodIV_A_N_500,10);
            MACRO_ADDITEM(kat_bloodIV_B_500,10);
            MACRO_ADDITEM(kat_bloodIV_B_N_500,10);
            MACRO_ADDITEM(kat_bloodIV_AB_500,10);
            MACRO_ADDITEM(kat_bloodIV_AB_N_500,10);
            MACRO_ADDITEM(kat_bloodIV_O_250,5);
            MACRO_ADDITEM(kat_bloodIV_O_N_250,5);
            MACRO_ADDITEM(kat_bloodIV_A_250,10);
            MACRO_ADDITEM(kat_bloodIV_A_N_250,10);
            MACRO_ADDITEM(kat_bloodIV_B_250,10);
            MACRO_ADDITEM(kat_bloodIV_B_N_250,10);
            MACRO_ADDITEM(kat_bloodIV_AB_250,10);
            MACRO_ADDITEM(kat_bloodIV_AB_N_250,10);
            MACRO_ADDITEM(KAT_Empty_bloodIV_500,10);
            MACRO_ADDITEM(KAT_Empty_bloodIV_250,20);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Head {
                class CheckBloodPressure {}; // Remove the ability to check blood pressure at the head
            };
            class ACE_ArmLeft {
                #include "Blood_ArmL.hpp"
            };
            class ACE_ArmRight {
                #include "Blood_ArmR.hpp"
            };
            class ACE_LegLeft {
                #include "Blood_LegL.hpp"
            };
            class ACE_LegRight {
                #include "Blood_LegR.hpp"
            };
        };
        class ACE_SelfActions {
            class Medical {
            class ACE_Head {
            class CheckBloodPressure {};
            };
            };
            class ACE_Equipment {
                class removeSound {
                    displayName = CSTRING(X_Action_removeSound);
                    condition = QUOTE('kat_X_AED' in (items _player) && !((_player getVariable QQGVAR(X_sound1)) isEqualTo ''));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(X_sound1), '', true)]; _player setVariable [ARR_3(QQGVAR(X_sound2), '', true)];);
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "";
                };
                class addSound {
                    displayName = CSTRING(X_Action_addSound);
                    condition = QUOTE('kat_X_AED' in (items _player) && ((_player getVariable QQGVAR(X_sound1)) isEqualTo ''));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(X_sound1), QQPATHTOF_SOUND(sounds\noheartrate.wav), true)]; _player setVariable [ARR_3(QQGVAR(X_sound2), QQPATHTOF_SOUND(sounds\heartrate.wav), true)];);
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "";
                };
                class openCrossPanel {
                    displayName = CSTRING(open_crosspanel);
                    condition = "('kat_crossPanel' in (uniformItems _player)) || ('kat_crossPanel' in (vestItems _player))";
                    statement = QUOTE(createDialog QQGVAR(CrossPanel_Dialog));
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "";
                };
                class placeAED {
                    displayName="$STR_KAT_circulation_place_AED";
                    condition="'kat_AED' in (items ACE_player)";
                    exceptions[]=
                    {
                        "notOnMap",
                        "isNotInside",
                        "isNotHandcuffed",
                        "isNotSurrendering",
                        "isNotSwimming",
                        "isNotOnLadder"
                    };
                    statement="call kat_circulation_fnc_placeAED";
                    icon="";
                    showDisabled=0;
                };
            };
        };
    };
};
