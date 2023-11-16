#include "..\script_component.hpp"
/*
 * Author: Blue
 * Measure and store blood pressure for unit
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_measureBloodPressure;
 *
 * Public: No
 */

params ["_unit"];

[{
    params ["_unit"];

    _unit setVariable [QGVAR(StoredBloodPressure), (_unit getVariable [QACEGVAR(medical,bloodPressure), [0,0]]), true];
}, [_unit], 1] call CBA_fnc_waitAndExecute;
