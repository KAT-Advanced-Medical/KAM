class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class Morphine;
    class CheckPulse;
    class CPR {
        displayNameProgress = "";
        treatmentTime = 0.01;
        callbackStart = "";
        callbackProgress = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_2(_medic,_patient)] call FUNC(CPRStart););
        condition = QACEFUNC(medical_treatment,canCPR);
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class CheckDogtags: CheckPulse {
        displayName = CSTRING(DogTag);
        displayNameProgress = CSTRING(DogTag_Action);
        treatmentTime = 2;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(bloodTypeLog); [ARR_2(_medic,_patient)] call ACEFUNC(dogtags,checkDogtag););
        condition = "true";
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class CheckBloodPressure: CheckPulse {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class KAT_DrawBlood500: CheckPulse {
        displayName = CSTRING(DrawBlood500_Action_Use);
        displayNameProgress = CSTRING(DrawBlood_Action_Progress);
        treatmentTime = QGVAR(blood_drawTime_500ml);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = QGVAR(enable_selfBloodDraw);
        category = "advanced";
        medicRequired = 0;
        consumeItem = 1;
        callbackSuccess = QUOTE([ARR_3(_medic,_patient,500)] call FUNC(drawBlood));
        condition = QUOTE([ARR_3(_medic,_patient,500)] call FUNC(canDraw) && (!(EGVAR(pharma,RequireInsIVBloodDraw)) || EFUNC(pharma,removeIV)));
        items[] = {"KAT_Empty_bloodIV_500"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class KAT_DrawBlood250: CheckPulse {
        displayName = CSTRING(DrawBlood250_Action_Use);
        displayNameProgress = CSTRING(DrawBlood_Action_Progress);
        treatmentTime = QGVAR(blood_drawTime_250ml);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = QGVAR(enable_selfBloodDraw);
        category = "advanced";
        medicRequired = 0;
        consumeItem = 1;
        callbackSuccess = QUOTE([ARR_3(_medic,_patient,250)] call FUNC(drawBlood));
        condition = QUOTE([ARR_3(_medic,_patient,250)] call FUNC(canDraw) && (!(EGVAR(pharma,RequireInsIVBloodDraw)) || EFUNC(pharma,removeIV)));
        items[] = {"KAT_Empty_bloodIV_250"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };

    #include "Blood_Medical.hpp"

    class AnalyzeRhythm: CheckPulse {
        displayName = CSTRING(AnalyzeRhythm);
        displayNameProgress = "";
        allowedSelections[] = {"Body"};
        icon = QPATHTOF(ui\icon_aed_shock.paa);
        treatmentTime = 0.01;
        items[] = {};
        consumeItem = 0;
        condition = QUOTE([ARR_2(_medic,_patient)] call FUNC(Defibrillator_CheckCondition));
        callbackStart = "";
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(AED_Analyze));
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class AEDShock: CheckPulse {
        displayName = CSTRING(Defibrillator_Action_Shock);
        displayNameProgress = "";
        allowedSelections[] = {"Body"};
        icon = QPATHTOF(ui\icon_aed_shock.paa);
        category = "advanced";
        items[] = {};
        treatmentTime = 0.01;
        condition = QUOTE(([ARR_2(_medic,_patient)] call ACEFUNC(medical_treatment,canCPR)) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]) && _patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && _patient getVariable [ARR_2(QQGVAR(Defibrillator_Charged),false)]);
        consumeItem = 0;
        callbackStart = "";
        callbackProgress = "";
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]);
        callbackFailure = "";
        animationMedic = "";
        treatmentLocations = QGVAR(useLocation_AED);
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class AEDPlacePads: CPR {
        displayName = CSTRING(AED_Action_PlacePads);
        displayNameProgress = CSTRING(Defibrillator_Action_PlacePads_Progress);
        icon = QPATHTOF(ui\icon_aed_pads.paa);
        items[] = {"kat_AED"};
        treatmentTime = QGVAR(DefibrillatorPads_AttachTime);
        condition = QUOTE([ARR_3(_medic,_patient,0)] call FUNC(Defibrillator_Pads_CheckCondition));
        consumeItem = 0;
        callbackStart = "";
        callbackProgress = "";
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_4(_medic,_patient,0,'kat_AED')] call FUNC(Defibrillator_AttachPads););
        callbackFailure = "";
        animationMedic = "AinvPknlMstpSnonWnonDr_medic0";
        treatmentLocations = QGVAR(useLocation_AED);
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class AEDStationPlacePads: AEDPlacePads {
        displayName = CSTRING(AEDStation_Action_PlacePads);
        items[] = {};
        condition = QUOTE([ARR_5(_medic,_patient,1,'kat_AED',_extraArgs)] call FUNC(Defibrillator_Pads_CheckCondition));
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_5(_medic,_patient,1,'kat_AED',_extraArgs)] call FUNC(Defibrillator_AttachPads));
    };
    class AEDVehiclePlacePads: AEDPlacePads {
        displayName = CSTRING(AEDVehicle_Action_PlacePads);
        items[] = {};
        condition = QUOTE([ARR_3(_medic,_patient,2)] call FUNC(Defibrillator_Pads_CheckCondition));
        callbackSuccess = QUOTE([ARR_4(_medic,_patient,2,'kat_AED')] call FUNC(Defibrillator_AttachPads));
    };
    class AEDXCharge: AEDShock {
        displayName = CSTRING(Defibrillator_Action_Charge);
        condition = QUOTE(([ARR_2(_medic,_patient)] call ACEFUNC(medical_treatment,canCPR)) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]) && _patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && !(_patient getVariable [ARR_2(QQGVAR(Defibrillator_Charged),false)]) && !(_patient getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)]) && {((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[])]) select 2) isEqualTo 'kat_X_AED'});
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(Defibrillator_ManualCharge));
        medicRequired = QGVAR(medLvl_AED_X);
    };
    class AEDCancelCharge: AEDShock {
        displayName = CSTRING(Defibrillator_Action_CancelCharge);
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && _patient getVariable [ARR_2(QQGVAR(Defibrillator_Charged),false)] && _patient getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)]);
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(DefibrillatorInUse),false,true)]; _patient setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]);
        medicRequired = QGVAR(medLvl_AED);
    };
    class AEDXPlacePads: AEDPlacePads {
        displayName = CSTRING(AEDX_Action_PlacePads);
        displayNameProgress = CSTRING(Defibrillator_Action_PlacePads_Progress);
        items[] = {"kat_X_AED"};
        condition = QUOTE([ARR_4(_medic,_patient,0,'kat_X_AED')] call FUNC(Defibrillator_Pads_CheckCondition));
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_4(_medic,_patient,0,'kat_X_AED')] call FUNC(Defibrillator_AttachPads));
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\icon_aedx.paa);
    };
    class AEDXStationPlacePads: AEDXPlacePads {
        displayName = CSTRING(AEDXStation_Action_PlacePads);
        items[] = {};
        condition = QUOTE([ARR_5(_medic,_patient,1,'kat_X_AED',_extraArgs)] call FUNC(Defibrillator_Pads_CheckCondition););
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_5(_medic,_patient,1,'kat_X_AED',_extraArgs)] call FUNC(Defibrillator_AttachPads));
    };
    class AEDXVehiclePlacePads: AEDXPlacePads {
        displayName = CSTRING(AEDXVehicle_Action_PlacePads);
        items[] = {};
        condition = QUOTE([ARR_4(_medic,_patient,2,'kat_X_AED')] call FUNC(Defibrillator_Pads_CheckCondition));
        callbackSuccess = QUOTE([ARR_4(_medic,_patient,2,'kat_X_AED')] call FUNC(Defibrillator_AttachPads));
    };
    class DefibrillatorRemovePads: AEDPlacePads {
        displayName = CSTRING(Defibrillator_Action_RemovePads);
        displayNameProgress = CSTRING(Defibrillator_Action_RemovePads_Progress);
        items[] = {};
        treatmentTime = QGVAR(DefibrillatorPads_DetachTime);
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)]);
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(Defibrillator_RemovePads));
        animationMedic = "AinvPknlMstpSnonWnonDr_medic0";
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon", "kat_recoveryposition"};
    };
    class AEDXConnectVitalsMonitor: AEDXPlacePads {
        displayName = CSTRING(AEDX_Action_ConnectMonitor);
        displayNameProgress = CSTRING(AEDX_Action_Connecting_Progress);
        allowedSelections[] = {"LeftArm", "RightArm"};
        category = "examine";
        items[] = {"kat_X_AED"};
        treatmentTime = QGVAR(AEDX_VitalsMonitor_AttachTime);
        condition = QUOTE([ARR_2(_medic,_patient)] call FUNC(AEDX_VitalsMonitor_CheckCondition));
        callbackSuccess = QUOTE([ARR_4(_medic,_patient,_bodyPart,0)] call FUNC(AEDX_ConnectVitalsMonitor));
    };
    class AEDXStationConnectVitalsMonitor: AEDXConnectVitalsMonitor {
        displayName = CSTRING(AEDXStation_Action_ConnectMonitor);
        items[] = {};
        condition = QUOTE([ARR_4(_medic,_patient,1,_extraArgs)] call FUNC(AEDX_VitalsMonitor_CheckCondition));
        callbackSuccess = QUOTE([ARR_5(_medic,_patient,_bodyPart,1,_extraArgs)] call FUNC(AEDX_ConnectVitalsMonitor));
    };
    class AEDXVehicleConnectVitalsMonitor: AEDXConnectVitalsMonitor {
        displayName = CSTRING(AEDXVehicle_Action_ConnectMonitor);
        items[] = {};
        condition = QUOTE([ARR_3(_medic,_patient,2)] call FUNC(AEDX_VitalsMonitor_CheckCondition));
        callbackSuccess = QUOTE([ARR_4(_medic,_patient,_bodyPart,2)] call FUNC(AEDX_ConnectVitalsMonitor));
    };
    class AEDXDisconnectVitalsMonitor: AEDXConnectVitalsMonitor {
        displayName = CSTRING(AEDX_Action_DisconnectMonitor);
        displayNameProgress = CSTRING(AEDX_Action_Disconnecting_Progress);
        items[] = {};
        treatmentTime = QGVAR(AEDX_VitalsMonitor_DetachTime);
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Connected),false)]);
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(AEDX_DisconnectVitalsMonitor));
    };
    class DisableAEDXAudio {
        displayName = CSTRING(AEDX_Action_DisableAudio);
        displayNameProgress = "";
        icon = QPATHTOF(ui\icon_aedx_volume_off.paa);
        category = "examine";
        treatmentLocations = 0;
        medicRequired = QGVAR(medLvl_AED_X);
        allowedSelections[] = {"Head","LeftArm","RightArm","Body","LeftLeg","RightLeg"};
        treatmentTime = 0.01;
        allowSelfTreatment = 0;
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] || _patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Connected),false)]) && ((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])]) select 2 isEqualTo 'kat_X_AED') && (_patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_VolumePatient),false)]));
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_VolumePatient),false,true)]; if((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])]) select 1 isEqualTo 1) then {[ARR_2(((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),nil)]) select 0),false)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume)});
        animationPatient = "";
        animationMedic = "";
    };
    class EnableAEDXAudio: DisableAEDXAudio {
        displayName = CSTRING(AEDX_Action_EnableAudio);
        icon = QPATHTOF(ui\icon_aedx_volume_on.paa);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] || _patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Connected),false)]) && {((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])]) select 2 isEqualTo 'kat_X_AED') && !(_patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_VolumePatient),false)])});
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_VolumePatient),true,true)]; if((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])]) select 1 isEqualTo 1) then {[ARR_2(((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])]) select 0),true)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume)});
    };
    class AEDXMeasureBloodPressure: AnalyzeRhythm {
        displayName = CSTRING(AEDX_Monitor_MeasureBloodPressure);
        allowedSelections[] = {"Head","LeftArm","RightArm","Body","LeftLeg","RightLeg"};
        icon = QPATHTOF(ui\icon_aed_pads.paa);
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Connected),false)] && (missionNamespace getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_BloodPressureInterval),0)] > 0));
        callbackSuccess = QUOTE(_patient call FUNC(measureBloodPressure));
        medicRequired = QGVAR(medLvl_AED_X);
    };
    class ViewMonitor: CheckPulse {
        displayName = CSTRING(ViewMonitor);
        displayNameProgress = "";
        icon = QPATHTOF(ui\icon_aedx_monitor.paa);
        category = "examine";
        medicRequired = QGVAR(medLvl_AED_X);
        allowedSelections[] = {"Head","LeftArm","RightArm","Body","LeftLeg","RightLeg"};
        treatmentTime = 0.01;
        items[] = {};
        consumeItem = 0;
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && {((_patient getVariable [ARR_2(QQGVAR(Defibrillator_Provider),[ARR_3(-1,-1,-1)])] select 2) isEqualTo 'kat_X_AED')}) || (_patient getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_Connected),false)]));
        callbackStart = "";
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(AEDX_ViewMonitor));
        animationPatient = "";
        animationPatientUnconscious = "";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
};
