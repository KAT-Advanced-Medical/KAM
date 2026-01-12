#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Attaches BVM to a Patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_breathing_fnc_attachBVM
 *
 * Public: No
 */

params ["_patient", "_state"];
_patient setVariable [QGVAR(attachedLucasState), _state, true];
if (_state) then {
    _patient call FUNC(lucasPFH);
    _patient setVariable [QACEGVAR(medical,CPR_provider), _patient, true];
};



