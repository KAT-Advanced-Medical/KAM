class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class Morphine;
    class CheckPulse;
    class CPR {
        condition = QUOTE(([ARR_2(_medic,_patient)] call ace_medical_treatment_fnc_canCPR) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
    };

    class CheckDogtags: CheckPulse {
        displayName = CSTRING(DogTag);
        displayNameProgress = CSTRING(DogTag_Action);
        treatmentTime = 2;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        callbackSuccess = "[_medic, _patient] call ace_dogtags_fnc_checkDogtag";
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
        items[] = {"kat_AED", "kat_X_AED"};
        condition = "true";
        callbackStart = QUOTE([ARR_2(_medic, _patient)] call FUNC(AEDanalyze));
        callbackSuccess = "";
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class KAT_DrawBlood500: CheckPulse {
        displayName = CSTRING(DrawBlood500_Action_Use);
        displayNameProgress = CSTRING(DrawBlood_Action_Progress);
        treatmentTime = GVAR(blood_drawTime_500ml);
        allowedSelections[] = {"LeftArm", "RightArm"};
        allowSelfTreatment = GVAR(enable_selfBloodDraw);
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
        treatmentTime = GVAR(blood_drawTime_250ml);
        allowedSelections[] = {"LeftArm", "RightArm"};
        allowSelfTreatment = GVAR(enable_selfBloodDraw);
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
    
    class Defibrillator: CPR {
        displayName = CSTRING(Defib_Action_Use);
        displayNameProgress = "$STR_KAT_circulation_AED_PROGRESS";
        icon = QPATHTOF(ui\defib.paa);
        items[] = {"kat_AED"};
        treatmentTime = 10;
        condition = QUOTE(([_medic,_patient] call ace_medical_treatment_fnc_canCPR) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        callbackStart = "call ace_medical_treatment_fnc_cprStart; _patient setVariable ['kat_circulation_AEDinUse', true, true];";
        callbackProgress = "call ace_medical_treatment_fnc_cprProgress; call kat_circulation_fnc_AED_sound;";
        callbackSuccess = "[_medic, _patient, 'AED'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_circulation_AEDinUse', false, true];";
        callbackFailure = "call ace_medical_treatment_fnc_cprFailure; _medic setVariable ['kat_soundplayed', false, true]; _patient setVariable ['kat_circulation_AEDinUse', false, true];";
        animationMedic = "AinvPknlMstpSnonWnonDr_medic0";
        treatmentLocations = QGVAR(useLocation_AED);
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class Defibrillator_station: Defibrillator {
        displayName = CSTRING(DefibS_Action_Use);
        items[] = {};
        callbackSuccess = "[_medic, _patient, 'AED-Station'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_circulation_AEDinUse', false, true];";
        condition = "kat_circulation_fnc_AEDStationCondition";
        treatmentLocations = 0;
    };
    class Defibrillator_AED_X: Defibrillator {
        displayName = CSTRING(AED_X_Action_Use);
        displayNameProgress = CSTRING(AED_X_Action_Progress);
        items[] = {};
        callbackSuccess = "[_medic, _patient, 'AED-X'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_circulation_AEDinUse', false, true];";
        condition = QFUNC(AEDXCondition);
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class X_Defibrillator_AED_X: Defibrillator_AED_X {
        displayName = CSTRING(X_Action_Use);
        displayNameProgress = CSTRING(X_Action_Progress);
        items[] = {"kat_X_AED"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(X), false)]));
        consumeItem = 1;
        medicRequired = QGVAR(medLvl_AED_X);
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(treatmentAdvanced_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class Remove_X_Defibrillator: Defibrillator_AED_X {
        displayName = CSTRING(X_Action_Remove);
        displayNameProgress = CSTRING(X_Remove_Action_Progress);
        items[] = {};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), true)] && !(_patient getVariable [ARR_2(QQGVAR(vehicleTrue), false)]));
        treatmentTime = 5;
        medicRequired = 0;
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, true)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class Defibrillator_AED_X_vehicle: Defibrillator {
        displayName = CSTRING(Vehicle_AED_X_Action_Use);
        displayNameProgress = CSTRING(AED_X_Action_Progress);
        items[] = {};
        callbackSuccess = "[_medic, _patient, 'AED-X'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_circulation_AEDinUse', false, true];";
        //condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X), false)]) || [ARR_2(_medic, 'kat_AED')] call ace_common_fnc_hasItem || [ARR_2(_medic, 'kat_X_AED')] call ace_common_fnc_hasItem);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(vehicleTrue), true)]) && (_patient getVariable [ARR_2(QQGVAR(X), true)]));
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class X_Defibrillator_AED_X_vehicle: Defibrillator_AED_X_vehicle {
        displayName = CSTRING(Vehicle_X_Action_Use);
        displayNameProgress = CSTRING(X_Action_Progress);
        items[] = {};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(X), false)]) && FUNC(vehicleCheck));
        consumeItem = 1;
        medicRequired = QGVAR(medLvl_AED_X);
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(treatmentAdvanced_X_Vehicle);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class Remove_X_Defibrillator_vehicle: Defibrillator_AED_X_vehicle {
        displayName = CSTRING(Vehicle_X_Action_Remove);
        displayNameProgress = CSTRING(X_Remove_Action_Progress);
        items[] = {};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(vehicleTrue), true)]) && (_patient getVariable [ARR_2(QQGVAR(X), true)]));
        treatmentTime = 5;
        medicRequired = 0;
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, false)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
};
