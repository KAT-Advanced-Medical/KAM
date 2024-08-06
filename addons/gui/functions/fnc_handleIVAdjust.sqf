#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Adjusts IV flow rates from GUI
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Body Part <NUMBER>
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

params ["_target", "_bodyPartN", "_adjust"];

private _ivFlow = _target getVariable [QEGVAR(pharma,IVFlow),[0,0,0,0,0,0]];

_ivFlow set [_bodyPartN, ((((_ivFlow select _bodyPartN) + _adjust) max 0) min 1.5)];
_target setVariable [QEGVAR(pharma,IVFlow), _ivFlow, true];