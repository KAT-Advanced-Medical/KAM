#include "..\script_component.hpp"
/*
 * Author: tcvm, johnb43
 * Handles various objects on fire and determines if units close to objects deserve to get burned.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ace_fire_fnc_fireManagerPFH call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

params ["_unit", "_gasLevel"];

switch (_gasLevel) do {
    case 0: {
        diag_log "You have been poisoned by CS!";
        _unit setVariable [QGVAR(poisoned), true];
        [_unit, "CSGas", 300, 30, -10, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
    };
    case 1: {
        diag_log "You have been poisoned by Toxic!";
        _unit setVariable [QGVAR(poisoned), true];
        [_unit, "ToxicGas", 300, 30, -10, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
    };
    default {};
};
