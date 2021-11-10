class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class Morphine;
    class CheckPulse;
    class CPR;

    class Painkillers: Morphine {
        displayName = CSTRING(Inject_Box_Painkillers);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        items[] = {};
        callbackSuccess = QUOTE([ARR_5('kat_Painkiller', _medic, _patient, _bodyPart, 'Painkillers')] call FUNC(removeItemfromMag); [_patient] call FUNC(wrongBloodTreatment););
        condition = "[_medic, 'kat_Painkiller'] call ace_common_fnc_hasMagazine || [_patient, 'kat_Painkiller'] call ace_common_fnc_hasMagazine";
        litter[] = {};
        icon = QPATHTOF(ui\icon_painkillers_action.paa);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    /**
    * @Slatery - Does the below function even do anything? Why does this need to be redefined if all that's happening is the function has been overwritten?
    */
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
    class CheckBloodPressure: CheckPulse { // Remove the ability to check blood pressure at the head
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
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
        callbackStart = "call ace_medical_treatment_fnc_cprStart; _patient setVariable ['kat_AEDinUse', true, true];";
        callbackProgress = "call ace_medical_treatment_fnc_cprProgress; call kat_circulation_fnc_AED_sound;";
        callbackSuccess = "[_medic, _patient, 'AED'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_AEDinUse', false, true];";
        callbackFailure = "call ace_medical_treatment_fnc_cprFailure; _medic setVariable ['kat_soundplayed', false, true]; _patient setVariable ['kat_AEDinUse', false, true];";
        animationMedic = "AinvPknlMstpSnonWnonDr_medic0";
        treatmentLocations = "GVAR(useLocation_AED)";
        medicRequired = QGVAR(medLvl_AED);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class Defibrillator_station: Defibrillator {
        displayName = CSTRING(DefibS_Action_Use);
        items[] = {};
        callbackSuccess = "[_medic, _patient, 'AED-Station'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_AEDinUse', false, true];";
        condition = "kat_circulation_fnc_AEDStationCondition";
        treatmentLocations = 0;
    };
    
    class Defibrillator_AED_X: Defibrillator {
        displayName = CSTRING(AED_X_Action_Use);
        displayNameProgress = CSTRING(AED_X_Action_Progress);
        items[] = {};
        callbackSuccess = "[_medic, _patient, 'AED-X'] call kat_circulation_fnc_AEDSuccess; _patient setVariable ['kat_AEDinUse', false, true];";
        //condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X), false)]) || [ARR_2(_medic, 'kat_AED')] call ace_common_fnc_hasItem || [ARR_2(_medic, 'kat_X_AED')] call ace_common_fnc_hasItem);
        condition = "kat_circulation_fnc_AEDXCondition";
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
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), true)]);
        treatmentTime = 5;
        medicRequired = 0;
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_2(_medic, _patient)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
};
