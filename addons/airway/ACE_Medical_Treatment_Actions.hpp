class ACE_Medical_Treatment_Actions {
    class Larynxtubus {
        displayName = CSTRING(Larynx_Display);
        displayNameProgress = CSTRING(action_placing);
        category = "airway";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {"kat_larynx"};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Larynxtubus')] call FUNC(treatmentAdvanced_airway));
        callbackFailure = "";
        callbackProgress = "";
        itemConsumed = 1;
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
        animationCaller = "AinvPknlMstpSlayWrflDnon_medicOther";
        animationCallerProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
        animationCallerSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
        animationCallerSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
        litter[] = {};
		icon = QPATHTOF(ui\larynx.paa);
    };
    class Guedeltubus: larynxtubus {
        displayName = CSTRING(Guedel_Display);
        medicRequired = 0;
        items[] = {"kat_guedel"};
		icon = QPATHTOF(ui\guedel.paa);
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Guedeltubus')] call FUNC(treatmentAdvanced_airway));
    };
    class Accuvac: larynxtubus {
        displayName = "Accuvac";
        treatmentTime = 8;
        items[] = {"kat_accuvac"};
		icon = QPATHTOF(ui\accuvac.paa);
        itemConsumed = 0;
        medicRequired = QGVAR(medLvl_Accuvac);
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_accuvac));
        callbackProgress = QUOTE(_this call FUNC(accuvacSound));
    };
    class Overstretch: larynxtubus {
        displayName = CSTRING(overstretch);
        displayNameProgress = CSTRING(overstretching);
        treatmentTime = 2;
        medicRequired = 0;
        items[] = {};
		icon = "";
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && !(_patient getVariable [ARR_2(QQGVAR(overstretch), false)]) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_overstretchHead));
    };
    class TurnAround: larynxtubus {
        displayName = CSTRING(turnaround);
        displayNameProgress = CSTRING(turnaround_action);
        treatmentTime = 5;
        medicRequired = 0;
        items[] = {};
		icon = "";
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_turnaroundHead));
    };
    class CheckPulse;
    class CheckAirway: checkPulse {
        displayName = CSTRING(checkAirway);
        displayNameProgress = CSTRING(action_checking);
		category = "airway";
        treatmentTime = 5;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(checkAirway));
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
    };
};
