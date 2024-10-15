#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles a unit entering a seizure (calls for a status update).
 * Sets variables to begin seizure logic.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_statemachine_fnc_enteredStateSeizure
 *
 * Public: No
 */

 params ["_unit"];
 if (isNull _unit || {!isNil {_unit getVariable QACEGVAR(medical,causeOfDeath)}}) exitWith {
    WARNING_1("enteredStateSeizure: State transition on dead or null unit - %1",_unit);
};

private _CMR = _unit getVariable [QEGVAR(brain,CMR),100];
private _CMRdiff = 100 - _CMR;

private _time = linearConversion [0,100,_CMRdiff,GVAR(Seizure_Min_Length),GVAR(Seizure_Max_Length),true];

_unit setVariable [QGVAR(seizureTimeLeft),_time,true];
_unit setVariable [QGVAR(seizureTimeLastUpdate),CBA_missionTime];

TRACE_3("enteredStateSeizure",_unit,_time,CBA_missionTime);

// Update the unit status to reflect seizure
[_unit, true] call FUNC(setSeizureState);
