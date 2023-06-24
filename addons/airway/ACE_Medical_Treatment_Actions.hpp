class ACE_Medical_Treatment_Actions {
    class Larynxtubus {
        displayName = CSTRING(Larynxtubus_Display);
        displayNameProgress = CSTRING(action_placing);
        category = "airway";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Larynxtubus);
        treatmentTime = QGVAR(Larynxtubus_time);
        items[] = {"kat_larynx"};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]) && !(_patient getVariable [ARR_2(QQGVAR(recovery),false)]) && !(_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Larynxtubus') && !(_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Guedeltubus'));
        callbackSuccess = QFUNC(treatmentAdvanced_airway);
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
    class RemoveLarynxtubus: Larynxtubus {
        displayName = CSTRING(Cancel_Larynxtubus);
        displayNameProgress = CSTRING(action_removing);
        medicRequired = QGVAR(medLvl_Larynxtubus);
        treatmentTime = QGVAR(Larynxtubus_time);
        items[] = {};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]) && (_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Larynxtubus'));
        callbackSuccess = QFUNC(treatmentAdvanced_RemoveAirwayItem);
    };
    class Guedeltubus: Larynxtubus {
        displayName = CSTRING(Guedeltubus_Display);
        medicRequired = QGVAR(medLvl_Guedeltubus);
        treatmentTime = QGVAR(Guedeltubus_time);
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && missionNamespace getVariable [ARR_2(QQGVAR(enable),true)] && !(_patient getVariable [ARR_2(QQGVAR(recovery),false)]) && !(_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Guedeltubus') && !(_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Larynxtubus'));
        items[] = {"kat_guedel"};
        icon = QPATHTOF(ui\guedel.paa);
        callbackSuccess = QFUNC(treatmentAdvanced_airway);
    };
    class RemoveGuedeltubus: RemoveLarynxtubus {
        displayName = CSTRING(Cancel_Guedeltubus);
        displayNameProgress = CSTRING(action_removing);
        medicRequired = QGVAR(medLvl_Guedeltubus);
        treatmentTime = QGVAR(Guedeltubus_time);
        items[] = {};
        icon = QPATHTOF(ui\guedel.paa);
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]) && (_patient getVariable [ARR_2(QQGVAR(airway_item), '')] == 'Guedeltubus'));
        callbackSuccess = QFUNC(treatmentAdvanced_RemoveAirwayItem);
    };
    class Accuvac: Larynxtubus {
        displayName = "Accuvac";
        treatmentTime = QGVAR(Accuvac_time);
        items[] = {"kat_accuvac"};
        icon = QPATHTOF(ui\accuvac.paa);
        consumeItem = 0;
        medicRequired = QGVAR(medLvl_Accuvac);
        callbackSuccess = QFUNC(treatmentAdvanced_accuvac);
        sounds[] = {{QPATHTO_R(sounds\suction.wav),6,1,15}};
    };
    class Overstretch: Larynxtubus {
        displayName = CSTRING(overstretch);
        displayNameProgress = CSTRING(overstretching);
        treatmentTime = QGVAR(Overstretch_time);
        medicRequired = 0;
        items[] = {};
        icon = "";
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && !(_patient getVariable [ARR_2(QQGVAR(overstretch), false)]) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
        callbackSuccess = QFUNC(treatmentAdvanced_overstretchHead);
    };
    class TurnAround: Larynxtubus {
        displayName = CSTRING(turnaround);
        displayNameProgress = CSTRING(turnaround_action);
        treatmentTime = QGVAR(TurnAround_time);
        medicRequired = 0;
        items[] = {};
        icon = "";
        callbackSuccess = QFUNC(treatmentAdvanced_turnaroundHead);
    };
    class RecoveryPosition: Larynxtubus {
        displayName = CSTRING(RecoveryPosition_displayName);
        displayNameProgress = CSTRING(RecoveryPosition_displayNameProgress);
        category="advanced";
        treatmentTime = QGVAR(RecoveryPosition_Time);
        allowedSelections[] = {"Body"};
        medicRequired = 0;
        items[] = {};
        condition = QUOTE((!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]) && !(_patient getVariable [ARR_2(QQGVAR(recovery),false)])) && FUNC(checkRecovery));
        icon = "";
        callbackSuccess = QFUNC(treatmentAdvanced_RecoveryPosition);
    };
    class CancelRecoveryPosition: Larynxtubus {
        displayName = CSTRING(CancelRecoveryPosition_displayName);
        displayNameProgress = CSTRING(CancelRecoveryPosition_displayNameProgress);
        category="advanced";
        treatmentTime = QGVAR(CancelRecoveryPosition_Time);
        allowedSelections[] = {"Body"};
        medicRequired = 0;
        items[] = {};
        condition = QUOTE((!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]) && (_patient getVariable [ARR_2(QQGVAR(recovery),false)])));
        icon = "";
        callbackSuccess = QFUNC(treatmentAdvanced_CancelRecoveryPosition);
    };
    class CheckPulse;
    class CheckAirway: CheckPulse {
        displayName = CSTRING(checkAirway);
        displayNameProgress = CSTRING(action_checking);
        category = "airway";
        treatmentTime = QGVAR(CheckAirway_time);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(checkAirway);
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && (missionNamespace getVariable [ARR_2(QQGVAR(enable),true)]));
    };
};
