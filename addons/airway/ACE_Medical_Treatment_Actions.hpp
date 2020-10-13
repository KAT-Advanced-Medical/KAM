class ACE_Medical_Treatment_Actions {
    class Larynxtubus {
        displayName = CSTRING(Larynx_Display);
        displayNameProgress = CSTRING(action_placing);
        category = "airway";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Larynxtubus);
        treatmentTime = QGVAR(Larynxtubus_time);
        items[] = {"kat_larynx"};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Larynxtubus')] call FUNC(treatmentAdvanced_airway));
        callbackFailure = "";
        callbackProgress = "";
        consumeItem = 1;
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
        animationMedic = "AinvPknlMstpSlayWrflDnon_medicOther";
        animationMedicProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
        animationMedicSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
        animationMedicSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
        litter[] = {};
		icon = QPATHTOF(ui\larynx.paa);
    };
    class Guedeltubus: larynxtubus {
        displayName = CSTRING(Guedel_Display);
        medicRequired = QGVAR(medLvl_Guedeltubus);
        treatmentTime = QGVAR(Guedeltubus_time);
        items[] = {"kat_guedel"};
		icon = QPATHTOF(ui\guedel.paa);
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Guedeltubus')] call FUNC(treatmentAdvanced_airway));
    };
    class Accuvac: larynxtubus {
        displayName = "Accuvac";
        treatmentTime = QGVAR(Accuvac_time);
        items[] = {"kat_accuvac"};
		icon = QPATHTOF(ui\accuvac.paa);
        consumeItem = 0;
        medicRequired = QGVAR(medLvl_Accuvac);
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_accuvac));
        callbackProgress = QUOTE(_this call FUNC(accuvacSound));
    };
    class Overstretch: larynxtubus {
        displayName = CSTRING(overstretch);
        displayNameProgress = CSTRING(overstretching);
        treatmentTime = QGVAR(Overstretch_time);
        medicRequired = 0;
        items[] = {};
		icon = "";
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && !(_patient getVariable [ARR_2(QQGVAR(overstretch), false)]) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_overstretchHead));
    };
    class TurnAround: larynxtubus {
        displayName = CSTRING(turnaround);
        displayNameProgress = CSTRING(turnaround_action);
        treatmentTime = QGVAR(TurnAround_time);
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
        treatmentTime = QGVAR(CheckAirway_time);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(checkAirway));
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
    };
};
