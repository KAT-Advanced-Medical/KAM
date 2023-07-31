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
        displayName = CSTRING(AED_DISPLAYNAME);
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

        class ACE_Actions {
            class ACE_MainActions {
                selection = "interaction_point";
                distance = 4;
                displayName = "AED-X";
                condition = "true";
                class AED_X_Shock {
                    displayName = CSTRING(AEDXStation_Action_Shock);
                    condition = QUOTE([ARR_2(_player, GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && _target getVariable [ARR_2(QQGVAR(AED_X_Connected), false)] && !(_target getVariable [ARR_2(QQGVAR(AEDInUse), false)]) && {!((_target getVariable QQGVAR(AED_X_Patient)) getVariable [ARR_2(QQEGVAR(airway,recovery),false)])});
                    statement = QUOTE([ARR_4(_player, (_target getVariable QQGVAR(AED_X_Patient)), 'body', 'AEDXPlaced')] call ACEFUNC(medical_treatment,treatment));
                    showDisabled = 0;
                    //icon = QPATHTOF(ui\X_Series-Device_W.paa);
                };
                class AED_X_ConnectMonitor {
                    displayName = CSTRING(AEDX_Action_ConnectMonitor);
                    condition = QUOTE([ARR_2(_player, GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && !(_target getVariable [ARR_2(QQGVAR(AED_X_Connected), false)]) && !(_target getVariable [ARR_2(QQGVAR(AEDInUse), false)]));
                    statement = "";
                    insertChildren = QUOTE([ARR_2(_player, _target)] call FUNC(addAEDXActions));
                    showDisabled = 0;
                };
                class AED_X_DisconnectMonitor {
                    displayName = CSTRING(AEDX_Action_DisconnectMonitor);
                    condition = QUOTE([ARR_2(_player, GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && _target getVariable [ARR_2(QQGVAR(AED_X_Connected), false)] && !(_target getVariable [ARR_2(QQGVAR(AEDInUse), false)]));
                    statement = QUOTE(_target setVariable [ARR_3(QQGVAR(AED_X_Connected), false, true)]);
                    showDisabled = 0;
                };
                class AED_X_EnableAudio {
                    displayName = CSTRING(AEDX_Action_EnableAudio);
                    condition = QUOTE([ARR_2(_player, GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && !(_target getVariable [ARR_2(QQGVAR(AED_X_Volume), false)]));
                    statement = QUOTE(_target setVariable [ARR_3(QQGVAR(AED_X_Volume), true, true)]; if !(isNull (_target getVariable [ARR_2(QQGVAR(AED_X_Patient), objNull)])) then {(_target getVariable QQGVAR(AED_X_Patient)) setVariable [ARR_3(QQGVAR(AED_X_VolumePatient), true, true)]});
                    showDisabled = 0;
                };
                class AED_X_DisableAudio {
                    displayName = CSTRING(AEDX_Action_DisableAudio);
                    condition = QUOTE([ARR_2(_player, GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && _target getVariable [ARR_2(QQGVAR(AED_X_Volume), false)]);
                    statement = QUOTE(_target setVariable [ARR_3(QQGVAR(AED_X_Volume), false, true)]; if !(isNull (_target getVariable [ARR_2(QQGVAR(AED_X_Patient), objNull)])) then {(_target getVariable QQGVAR(AED_X_Patient)) setVariable [ARR_3(QQGVAR(AED_X_VolumePatient), false, true)]});
                    showDisabled = 0;
                };
            };
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
            MACRO_ADDITEM(kat_crossPanel,2);
            MACRO_ADDITEM(kat_IO_FAST,15);
            MACRO_ADDITEM(kat_IV_16,15);
            MACRO_ADDITEM(KAT_Empty_bloodIV_250,7);
            MACRO_ADDITEM(KAT_Empty_bloodIV_500,7);
            MACRO_ADDITEM(kat_bloodIV_O,7);
            MACRO_ADDITEM(kat_bloodIV_O_N,7);
            MACRO_ADDITEM(kat_bloodIV_A,7);
            MACRO_ADDITEM(kat_bloodIV_A_N,7);
            MACRO_ADDITEM(kat_bloodIV_B,7);
            MACRO_ADDITEM(kat_bloodIV_B_N,7);
            MACRO_ADDITEM(kat_bloodIV_AB,7);
            MACRO_ADDITEM(kat_bloodIV_AB_N,7);
            MACRO_ADDITEM(kat_bloodIV_O_500,7);
            MACRO_ADDITEM(kat_bloodIV_O_N_500,7);
            MACRO_ADDITEM(kat_bloodIV_A_500,7);
            MACRO_ADDITEM(kat_bloodIV_A_N_500,7);
            MACRO_ADDITEM(kat_bloodIV_B_500,7);
            MACRO_ADDITEM(kat_bloodIV_B_N_500,7);
            MACRO_ADDITEM(kat_bloodIV_AB_500,7);
            MACRO_ADDITEM(kat_bloodIV_AB_N_500,7);
            MACRO_ADDITEM(kat_bloodIV_O_250,7);
            MACRO_ADDITEM(kat_bloodIV_O_N_250,7);
            MACRO_ADDITEM(kat_bloodIV_A_250,7);
            MACRO_ADDITEM(kat_bloodIV_A_N_250,7);
            MACRO_ADDITEM(kat_bloodIV_B_250,7);
            MACRO_ADDITEM(kat_bloodIV_B_N_250,7);
            MACRO_ADDITEM(kat_bloodIV_AB_250,7);
            MACRO_ADDITEM(kat_bloodIV_AB_N_250,7);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Head {
                class CheckBloodPressure {}; // Remove the ability to check blood pressure at the head
            };
        };
        class ACE_SelfActions {
            class Medical {
                class ACE_Head {
                    class CheckBloodPressure {};
                };
            };
            class ACE_Equipment {
                class AED_X_removeSound {
                    displayName = CSTRING(AEDX_Action_addSound);
                    condition = QUOTE('kat_X_AED' in (items _player) && (_player getVariable [ARR_2(QQGVAR(AED_X_Volume), false])));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(AED_X_Volume), false, true)]);
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = QPATHTOF(ui\X_Series-Device_W.paa);
                };
                class AED_X_addSound : AED_X_removeSound {
                    displayName = CSTRING(AEDX_Action_removeSound);
                    condition = QUOTE('kat_X_AED' in (items _player) && !(_player getVariable [ARR_2(QQGVAR(AED_X_Volume), false])));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(AED_X_Volume), true, true)]);
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
                    displayName = CSTRING(place_AED);
                    condition = QUOTE('kat_AED' in (items _player));
                    exceptions[] =
                    {
                        "notOnMap",
                        "isNotInside",
                        "isNotHandcuffed",
                        "isNotSurrendering",
                        "isNotSwimming",
                        "isNotOnLadder"
                    };
                    statement = QUOTE([ARR_2(_player,'kat_AED')] call FUNC(placeAED));
                    icon = "";
                    showDisabled = 0;
                };
                class placeAEDX : placeAED {
                    displayName = "Place AED-X";//CSTRING(place_AEDX);
                    condition = QUOTE('kat_X_AED' in (items _player));
                    statement = QUOTE([ARR_2(_player,'kat_X_AED')] call FUNC(placeAED));
                    icon = QPATHTOF(ui\X_Series-Device_W.paa);
                };
            };
        };
    };
};
