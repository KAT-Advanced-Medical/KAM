class ACE_Medical_Treatment_Actions {
    class Blink {
        displayName = CSTRING(blink_display);
        displayNameProgress = CSTRING(blink_action);
        category = "bandage";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = 0;
        treatmentTime = 2;
        items[] = {};
        condition = QUOTE(missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]);
        callbackSuccess = QFUNC(treatmentAdvanced_blink);
        callbackFailure = "";
        callbackProgress = "";
        consumeItem = 0;
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
        animationMedic = "AinvPknlMstpSlayWrflDnon_medicOther";
        animationMedicProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
        animationMedicSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
        animationMedicSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
        litter[] = {};
    };
};
