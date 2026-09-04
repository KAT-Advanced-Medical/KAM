#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks or not whether the airway is clear
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Airway Clearance <BOOL>
 *
 * Example:
 * [player] call kat_airway_fnc_airwayStatus;
 *
 * Public: No
 */

params ["_patient"];

private _occulsion = _patient getVariable [QGVAR(occlusion), 0, true];
private _surgical = _patient getVariable [QGVAR(airwaySurgical), false, true];
private _obstruction = _patient getVariable [QGVAR(obstruction), [false, false, false], true];

_return = false;

private _obstructonCount = count[_obstruction select { _x isEqualTo false }];

// If a surgical airway is present, then the oral and upper airway obstructions are disregarded
if !(_surgical) then {

    // The worse the occlusion is, the fewer parts of the airway need to be obstructed for an airway blockage to occur
    switch (_occulsion) do {
        case 4: { _return = false; }; // Full occlusion, surgical
        case 3: { _return = false; }; // Full occlusion
        case 2: { _return = (_obstructionCount < 1); }; // Moderate occlusion
        case 1: { _return = (_obstructionCount < 2); }; // Mild occlusion
        default { _return = (_obstructionCount < 3); }; // No occlusion, obstruction needs 3 parts
    };
} else {
    // Only check lower airway obstruction when a surgical airway is present
    _return = !(_obstruction select 2);
}; 

_patient setVariable [QGVAR(airwayClear), _return, true];