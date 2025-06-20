#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Adjusts ventilator Rate
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 2: Adjust Value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target, 2, 0.5] call kat_medical_gui_fnc_handleIVAdjust;
 *
 * Public: No
 */

params ["_medic", "_target", "_adjust"];
private _ventRate = _target getVariable [QGVAR(ventRate), 2];
_target setVariable [QGVAR(ventRate), (((_ventRate + _adjust) min 8) max 1), true];
private _hint = format [LLSTRING(ventRate), (60 / (((_ventRate + _adjust) min 8) max 1))];
[_hint, 2, _medic] call ACEFUNC(common,displayTextStructured);
