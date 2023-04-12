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
        displayName = CSTRING(Defib_Action_Use);
        displayNameProgress = CSTRING(AED_PROGRESS);
        icon = QPATHTOF(ui\defib.paa);
        items[] = {"kat_AED"};
        treatmentTime = 10;
        condition = QUOTE(([ARR_2(_medic,_patient)] call ACEFUNC(medical_treatment,canCPR)) && !(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        callbackStart = QFUNC(AEDStart);
        callbackProgress = QFUNC(AEDProgress);
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
        displayName = CSTRING(DefibS_Action_Use);
        items[] = {};
        condition = QFUNC(AEDStationCondition);
        treatmentLocations = 0;
    };
    class AEDX: AED {
        displayName = CSTRING(AED_X_Action_Use);
        displayNameProgress = CSTRING(AED_X_Action_Progress);
        items[] = {};
        condition = QFUNC(AEDXCondition);
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class AttachAEDX: AED {
        displayName = CSTRING(X_Action_Use);
        displayNameProgress = CSTRING(X_Action_Progress);
        items[] = {"kat_X_AED"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(X), false)]));
        consumeItem = 1;
        medicRequired = QGVAR(medLvl_AED_X);
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(attachAEDX);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class DetachAEDX: AttachAEDX {
        displayName = CSTRING(X_Action_Remove);
        displayNameProgress = CSTRING(X_Remove_Action_Progress);
        items[] = {};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), true)] && !(_patient getVariable [ARR_2(QQGVAR(vehicleTrue), false)]));
        treatmentTime = 5;
        medicRequired = 0;
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, true)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class AEDXVehicle: AED {
        displayName = CSTRING(Vehicle_AED_X_Action_Use);
        displayNameProgress = CSTRING(AED_X_Action_Progress);
        items[] = {};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(vehicleTrue), true)]) && (_patient getVariable [ARR_2(QQGVAR(X), true)]));
        medicRequired = QGVAR(medLvl_AED_X);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class AttachAEDXVehicle: AttachAEDX {
        displayName = CSTRING(Vehicle_X_Action_Use);
        displayNameProgress = CSTRING(X_Action_Progress);
        items[] = {};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(X), false)]) && FUNC(vehicleCheck));
        consumeItem = 0;
        medicRequired = QGVAR(medLvl_AED_X);
        callbackSuccess = QFUNC(attachAEDXVehicle);
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class DetachAEDXVehicle: DetachAEDX {
        displayName = CSTRING(Vehicle_X_Action_Remove);
        displayNameProgress = CSTRING(X_Remove_Action_Progress);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(vehicleTrue), true)]) && (_patient getVariable [ARR_2(QQGVAR(X), true)]));
        callbackSuccess = QUOTE([ARR_3(_medic, _patient, false)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
};
