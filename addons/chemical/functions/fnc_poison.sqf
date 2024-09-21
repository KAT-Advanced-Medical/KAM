#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
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

// Check if unit is remote (objNull is remote)
if (!local _unit) exitWith {
    TRACE_1("unit is null or not local",_unit);
};

// Check if the unit can poison (takes care of spectators and curators)
if (getNumber (configOf _unit >> "isPlayableLogic") == 1 || {!(_unit isKindOf "CAManBase")}) exitWith {
    TRACE_1("unit is virtual or not a man",_unit);
};

// If unit is invulnerable, don't poison the unit
if !(isDamageAllowed _unit && {_unit getVariable [QACEGVAR(medical,allowDamage), true]}) exitWith {
    TRACE_1("unit is invulnerable",_unit);
};

if ((goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) && {_unit getVariable [QGVAR(gasmask_durability), 10] > 0}) exitWith {
    TRACE_1("unit has gas mask",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};

switch (_gasLevel) do {
    case 0: {
        _unit setVariable [QGVAR(poisoned), true];
        [_unit, "CSGas", 300, 30, -10, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
        [_unit, 0.5] call ACEFUNC(medical_status,adjustPainLevel); // Adjust pain based on severity
    };
    case 1: {
        _unit setVariable [QGVAR(poisoned), true];
        [_unit, "ToxicGas", 300, 30, -10, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
        [_unit, 1] call ACEFUNC(medical_status,adjustPainLevel); // Adjust pain based on severity
    };
    default {};
};
