class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class Morphine;
    class CheckPulse;
    class CPR {
        condition = QUOTE(([ARR_2(_medic,_patient)] call ACEFUNC(medical_treatment,canCPR)) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
    };
    class CheckDogtags: CheckPulse {
        displayName = CSTRING(DogTag);
        displayNameProgress = CSTRING(DogTag_Action);
        treatmentTime = 2;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        callbackSuccess = QACEFUNC(dogtags,checkDogtag);
        condition = "true";
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class CheckBloodPressure: CheckPulse {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class CheckRhythm: CheckPulse {
        displayName = CSTRING(Rhythm);
        displayNameProgress = CSTRING(Checking_Rhythm);
        allowedSelections[] = {"Body"};
        treatmentTime = 2;
        items[] = {};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X),false)]) || ([ARR_2(_medic,'kat_AED')] call ACEFUNC(common,hasItem)));
        callbackStart = QFUNC(AEDanalyze);
        callbackSuccess = "";
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class KAT_DrawBlood500: CheckPulse {
        displayName = CSTRING(DrawBlood500_Action_Use);
        displayNameProgress = CSTRING(DrawBlood_Action_Progress);
        treatmentTime = QGVAR(blood_drawTime_500ml);
        allowedSelections[] = {"LeftArm", "RightArm"};
        allowSelfTreatment = QGVAR(enable_selfBloodDraw);
        category = "advanced";
        medicRequired = 0;
        consumeItem = 1;
        callbackSuccess = QUOTE([ARR_3(_medic, _patient,500)] call FUNC(drawBlood));
        condition = QUOTE([ARR_3(_medic, _patient,500)] call FUNC(canDraw));
        items[] = {"KAT_Empty_bloodIV_500"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class KAT_DrawBlood250: CheckPulse {
        displayName = CSTRING(DrawBlood250_Action_Use);
        displayNameProgress = CSTRING(DrawBlood_Action_Progress);
        treatmentTime = QGVAR(blood_drawTime_250ml);
        allowedSelections[] = {"LeftArm", "RightArm"};
        allowSelfTreatment = QGVAR(enable_selfBloodDraw);
        category = "advanced";
        medicRequired = 0;
        consumeItem = 1;
        callbackSuccess = QUOTE([ARR_3(_medic, _patient,250)] call FUNC(drawBlood));
        condition = QUOTE([ARR_3(_medic, _patient,250)] call FUNC(canDraw));
        items[] = {"KAT_Empty_bloodIV_250"};
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };

    #include "Blood_Medical.hpp"

    class AED: CPR {
        displayName = CSTRING(AED_Action_Use);
        displayNameProgress = CSTRING(AED_Action_Progress);
        icon = QPATHTOF(ui\defib.paa);
        items[] = {"kat_AED"};
        treatmentTime = 10;
        condition = QUOTE(([ARR_2(_medic,_patient)] call ACEFUNC(medical_treatment,canCPR)) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        consumeItem = 0;
        callbackStart = QFUNC(AEDStart);
        callbackProgress = QUOTE([ARR_4(_args, _elapsedTime, _totalTime, _errorCode)] call FUNC(AEDProgress));
        callbackSuccess = QFUNC(AEDSuccess);
        callbackFailure = QFUNC(AEDFailure);
        animationMedic = "AinvPknlMstpSnonWnonDr_medic0";
        treatmentLocations = QGVAR(useLocation_AED);
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class AEDStation: AED {
        displayName = CSTRING(AEDStation_Action_Use);
        items[] = {};
        callbackProgress = QUOTE([ARR_5(_args, _elapsedTime, _totalTime, _errorCode, 1)] call FUNC(AEDProgress));
        condition = QUOTE([ARR_2(_medic, _patient)] call FUNC(AEDStationCondition));
        treatmentLocations = 0;
    };
    class AEDVehicle: AED {
        displayName = CSTRING(AEDVehicle_Action_Use);
        items[] = {};
        condition = QUOTE([ARR_2(_patient,'kat_AED')] call FUNC(AEDVehicleCondition));
        callbackProgress = QUOTE([ARR_5(_args, _elapsedTime, _totalTime, _errorCode, 2)] call FUNC(AEDProgress));
    };
    class AEDX: AED {
        displayName = CSTRING(AEDX_Action_Use);
        displayNameProgress = CSTRING(AEDX_Action_Progress);
        items[] = {"kat_X_AED"};
        condition = QUOTE([ARR_2(_medic, _patient)] call FUNC(AEDXCondition));
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class AEDXPlaced: AEDX {
        displayName = CSTRING(AEDXStation_Action_Use);
        items[] = {};
        condition = QUOTE([ARR_3(_medic, _patient, true)] call FUNC(AEDXCondition));
        callbackProgress = QUOTE([ARR_5(_args, _elapsedTime, _totalTime, _errorCode, 1)] call FUNC(AEDProgress));
    };
    class AttachAEDX: AEDX {
        displayName = CSTRING(AEDX_Action_ConnectMonitor);
        displayNameProgress = CSTRING(AEDX_Action_Connecting_Progress);
        treatmentTime = QGVAR(AED_X_AttachTime);
        condition = QUOTE([ARR_2(_medic, _patient)] call FUNC(AEDXMonitorCondition));
        medicRequired = QGVAR(medLvl_AED_X);
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_2(_medic, _patient)] call FUNC(attachAEDX));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class AEDXVehicle: AEDX {
        displayName = CSTRING(AEDXVehicle_Action_Use);
        items[] = {};
        condition = QUOTE([ARR_2(_patient,'kat_X_AED')] call FUNC(AEDVehicleCondition));
        callbackProgress = QUOTE([ARR_5(_args, _elapsedTime, _totalTime, _errorCode, 2)] call FUNC(AEDProgress));
    };
    class AttachAEDXPlaced: AttachAEDX {
        displayName = CSTRING(AEDXStation_Action_ConnectMonitor);
        items[] = {};
        condition = QUOTE([ARR_3(_medic, _patient, 1)] call FUNC(AEDXMonitorCondition));
        medicRequired = QGVAR(medLvl_AED_X);
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, 1)] call FUNC(attachAEDX));
    };
    class AttachAEDXVehicle: AttachAEDX {
        displayName = CSTRING(AEDXVehicle_Action_ConnectMonitor);
        items[] = {};
        condition = QUOTE([ARR_3(_medic, _patient, 2)] call FUNC(AEDXMonitorCondition) && [ARR_2(_patient,'kat_X_AED')] call FUNC(AEDVehicleCondition));
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, 2)] call FUNC(attachAEDX));
    };
    class DetachAEDX: AttachAEDX {
        displayName = CSTRING(AEDX_Action_DisconnectMonitor);
        displayNameProgress = CSTRING(AEDX_Action_Disconnecting_Progress);
        items[] = {};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), false)]);
        treatmentTime = QGVAR(AED_X_DetachTime);
        medicRequired = 0;
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(X), false, true)]);
    };
    class DisableAEDXAudio {
        displayName = CSTRING(AEDX_Action_DisableAudio);
        displayNameProgress = "";
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
        category = "examine";
        treatmentLocations = 0;
        medicRequired = 0;
        allowedSelections[] = {"Body"};
        treatmentTime = 0.01;
        allowSelfTreatment = 0;
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X), false)]) && (_patient getVariable [ARR_2(QQGVAR(AED_X_VolumePatient), false)]));
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(AED_X_VolumePatient), false, true)]);
        animationPatient = "";
        animationMedic = "";
    };
    class EnableAEDXAudio: DisableAEDXAudio {
        displayName = CSTRING(AEDX_Action_EnableAudio);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X), false)]) && !(_patient getVariable [ARR_2(QQGVAR(AED_X_VolumePatient), false)]));
        callbackSuccess = QUOTE(_patient setVariable [ARR_3(QQGVAR(AED_X_VolumePatient), true, true)]);
    };
};
