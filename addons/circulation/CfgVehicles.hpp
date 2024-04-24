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

    class ThingX;
    class kat_AEDItem: ThingX {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(AED_DISPLAYNAME);
        author = "Katalam";
        vehicleClass = "Items";
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        class TransportItems {
            MACRO_ADDITEM(kat_AED,1);
        };

        ACEGVAR(dragging,canDrag) = 1;
        ACEGVAR(dragging,canCarry) = 1;
        ACEGVAR(dragging,dragPosition)[] = {0,1.1,0};
        ACEGVAR(dragging,carryPosition)[] = {0,1.1,1};

        class ACE_Actions {
            class ACE_MainActions {
                selection = "interaction_point";
                distance = 4.2;
                displayName = "AED";
                condition = "true";
                class KAT_AED_AnalyzeRhythm {
                    displayName = CSTRING(AnalyzeRhythm);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,2)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_2(_player,(_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]))] call FUNC(AED_Analyze));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_Shock {
                    displayName = CSTRING(Defibrillator_Action_Shock);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,3)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE((_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]) setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]);
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_PlacePads {
                    displayName = CSTRING(AED_Action_PlacePads);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED))] call ACEFUNC(medical_treatment,isMedic) && [ARR_2(_player,_target)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = "";
                    insertChildren = QUOTE([ARR_2(_player,_target)] call FUNC(addDefibrillatorActions));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
                };
                class KAT_AED_RemovePads: KAT_AED_PlacePads {
                    displayName = CSTRING(Defibrillator_Action_RemovePads);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,4)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_4(_player,(_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]),'body','DefibrillatorRemovePads')] call ace_medical_treatment_fnc_treatment);
                    insertChildren = "";
                };
            };
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
                distance = 4.2;
                displayName = CSTRING(X_Display);
                condition = "true";
                class KAT_AED_X_ViewMonitor {
                    displayName = CSTRING(ViewMonitor);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic));
                    statement = QUOTE([ARR_3(_player,_target,1)] call FUNC(AEDX_ViewMonitor));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aedx_monitor.paa);
                };
                class KAT_AED_X_ManualCharge {
                    displayName = CSTRING(Defibrillator_Action_Charge);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,7)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_2(_player,(_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]))] call FUNC(Defibrillator_ManualCharge));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_X_CancelCharge {
                    displayName = CSTRING(Defibrillator_Action_CancelCharge);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,8)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE((_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]) setVariable [ARR_3(QQGVAR(DefibrillatorInUse),false,true)]; (_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]) setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]);
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_X_Shock {
                    displayName = CSTRING(Defibrillator_Action_Shock);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,3)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE((_target getVariable QQGVAR(Defibrillator_Patient)) setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]);
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_X_AnalyzeRhythm {
                    displayName = CSTRING(AnalyzeRhythm);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,2)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_3(_player,(_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]),'AEDX')] call FUNC(AED_Analyze));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_shock.paa);
                };
                class KAT_AED_X_PlacePads {
                    displayName = CSTRING(AEDX_Action_PlacePads);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,1)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_5(_player,(_target getVariable QQGVAR(AED_X_VitalsMonitor_Patient)),'body','AEDXStationPlacePads',[_target])] call EFUNC(misc,treatment));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
                };
                class KAT_AED_X_PlacePadsTo: KAT_AED_X_PlacePads {
                    displayName = CSTRING(AEDX_Action_PlacePads);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_2(_player,_target)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = "";
                    insertChildren = QUOTE([ARR_3(_player,_target,1)] call FUNC(addDefibrillatorActions));
                };
                class KAT_AED_X_RemovePads: KAT_AED_X_PlacePads {
                    displayName = CSTRING(Defibrillator_Action_RemovePads);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,4)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_4(_player,(_target getVariable [ARR_2(QQGVAR(Defibrillator_Patient),nil)]),'body','DefibrillatorRemovePads')] call EFUNC(misc,treatment));
                    insertChildren = "";
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
                };
                class KAT_AED_X_ConnectMonitor {
                    displayName = CSTRING(AEDX_Action_ConnectMonitor);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,5)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_5(_player,(_target getVariable QQGVAR(Defibrillator_Patient)),'rightarm','AEDXStationConnectVitalsMonitor',[_target])] call EFUNC(misc,treatment));
                    insertChildren = QUOTE([ARR_3(_player,_target,3)] call FUNC(addDefibrillatorActions));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
                };
                class KAT_AED_X_ConnectMonitorTo: KAT_AED_X_ConnectMonitor {
                    displayName = CSTRING(AEDX_Action_ConnectMonitor);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_2(_player,_target)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = "";
                    insertChildren = QUOTE([ARR_3(_player,_target,2)] call FUNC(addDefibrillatorActions));
                };
                class KAT_AED_X_DisconnectMonitor {
                    displayName = CSTRING(AEDX_Action_DisconnectMonitor);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && [ARR_3(_player,_target,6)] call FUNC(DefibrillatorPlaced_CheckCondition));
                    statement = QUOTE([ARR_4(_player,(_target getVariable QQGVAR(AED_X_VitalsMonitor_Patient)),'rightarm','AEDXDisconnectVitalsMonitor')] call EFUNC(misc,treatment));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
                };
                class KAT_AED_X_EnableAudio {
                    displayName = CSTRING(AEDX_Action_EnableAudio);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && !(_target getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Volume),false)]));
                    statement = QUOTE(_target setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_Volume),true,true)]; [ARR_2(_target,true)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aedx_volume_on.paa);
                };
                class KAT_AED_X_DisableAudio: KAT_AED_X_EnableAudio {
                    displayName = CSTRING(AEDX_Action_DisableAudio);
                    condition = QUOTE([ARR_2(_player,GVAR(medLvl_AED_X))] call ACEFUNC(medical_treatment,isMedic) && _target getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Volume),false)]);
                    statement = QUOTE(_target setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_Volume),false,true)]; [ARR_2(_target,false)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume));
                    icon = QPATHTOF(ui\icon_aedx_volume_off.paa);
                };
                class KAT_AED_X_MeasureBloodPressure {
                    displayName = CSTRING(AEDX_Monitor_MeasureBloodPressure);
                    condition = QUOTE(!(_target getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Patient),objNull)] isEqualTo objNull) && {(missionNamespace getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_BloodPressureInterval),0)] > 0)});
                    statement = QUOTE(_target getVariable QQGVAR(AED_X_VitalsMonitor_Patient) call FUNC(measureBloodPressure));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_aed_pads.paa);
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
            class KAT_Equipment {
                class openCrossPanel {
                    displayName = CSTRING(open_crosspanel);
                    condition = "('kat_crossPanel' in (uniformItems _player)) || ('kat_crossPanel' in (vestItems _player))";
                    statement = QUOTE(createDialog QQGVAR(CrossPanel_Dialog));
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "";
                };
                class KAT_placeAED {
                    displayName = CSTRING(place_AED);
                    condition = QUOTE('kat_AED' in (items _player) && !((_player getVariable [ARR_2(QQGVAR(MedicDefibrillator_Patient),objNull)]) getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)]));
                    statement = QUOTE([ARR_2(_player,'kat_AED')] call FUNC(placeAED));
                    icon = "";
                    showDisabled = 0;
                };
                class KAT_placeAEDX: KAT_placeAED {
                    displayName = CSTRING(place_AEDX);
                    condition = QUOTE('kat_X_AED' in (items _player) && !((_player getVariable [ARR_2(QQGVAR(MedicDefibrillator_Patient),objNull)]) getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)]));
                    statement = QUOTE([ARR_2(_player,'kat_X_AED')] call FUNC(placeAED));
                    icon = QPATHTOF(ui\icon_aedx.paa);
                };
                class KAT_AED_X_Interactions {
                    displayName = CSTRING(AED_X);
                    condition = QUOTE('kat_X_AED' in (items _player));
                    icon = QPATHTOF(ui\icon_aedx.paa);
                    class KAT_AED_X_ViewMonitor {
                        displayName = CSTRING(ViewMonitor);
                        condition = "true";
                        statement = QUOTE([ARR_3(_player,objNull,2)] call FUNC(AEDX_ViewMonitor));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\icon_aedx_monitor.paa);
                    };
                    class KAT_AED_X_removeSound {
                        displayName = CSTRING(AEDX_Action_DisableAudio);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Volume),false)]);
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_Volume),false,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\icon_aedx_volume_off.paa);
                    };
                    class KAT_AED_X_addSound : KAT_AED_X_removeSound {
                        displayName = CSTRING(AEDX_Action_EnableAudio);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Volume),false)]));
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_Volume),true,true)]);
                        icon = QPATHTOF(ui\icon_aedx_volume_on.paa);
                    };
                };
            };
        };
    };
};
