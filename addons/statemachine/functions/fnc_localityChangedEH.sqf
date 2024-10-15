#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Modified: apo_tle
 * Handles locality switch. Will also be called at unit init.
 * Because state machine state is local only, when a unit transfers locality we need to manually transition to it's current state
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: isLocal <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call ace_medical_statemachine_fnc_localityChangedEH
 *
 * Public: No
 */

params ["_unit", "_isLocal"];
TRACE_2("localityChangedEH",_unit,_isLocal);

if (!alive _unit) exitWith {};

if (_isLocal) then {
    private _currentState = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("local",_currentState);

    switch (true) do {
        case (IN_CRDC_ARRST(_unit)): {
            if (_currentState == "CardiacArrest") exitWith {};
            _unit setVariable [VAR_CRDC_ARRST, false]; // force reset vars so setCardiacArrestState can run (enteredStateCardiacArrest will also be called)
            _unit setVariable [VAR_UNCON, false];
            TRACE_1("manually changing state to CardiacArrest",_currentState);
            [_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, "CardiacArrest", {}, "LocalityChange"] call CBA_statemachine_fnc_manualTransition;
        };
        case (IN_SEIZURE(_unit)): {
            if (_currentState == "Seizure") exitWith {};
            _unit setVariable [VAR_SEIZURE, false]; // force reset vars so setSeizureState can run (enteredSeizureState will also be called)
            _unit setVariable [VAR_UNCON, false];
            TRACE_1("manually changing state to Seizure",_currentState);
            [_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, "Seizure", {}, "LocalityChange"] call CBA_statemachine_fnc_manualTransition;
        };
        case (IS_UNCONSCIOUS(_unit)): {
            if (_currentState == "Unconscious") exitWith {};
            _unit setVariable [VAR_UNCON, false]; // force reset var so ace_medical_status_fnc_setUnconsciousState can run
            TRACE_1("manually changing state to Unconscious",_currentState);
            [_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, "Unconscious", {}, "LocalityChange"] call CBA_statemachine_fnc_manualTransition;
        };
        case (IS_BLEEDING(_unit) || {IS_IN_PAIN(_unit)}): {
            if (_currentState == "Injured") exitWith {};
            TRACE_1("manually changing state to Injured",_currentState);
            [_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, "Injured", {}, "LocalityChange"] call CBA_statemachine_fnc_manualTransition;
        };
        default {
            // If locality transfers back and forth, we could be in an old state and should transfer back to default
            if (_currentState == "Default") exitWith {};
            TRACE_1("manually changing state to Default",_currentState);
            [_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, "Default", {}, "LocalityChange"] call CBA_statemachine_fnc_manualTransition;
        };
    };
}