#include "..\script_component.hpp"
/*
 * Author: Glowbal, kymckay, mharis001
 * Updates the body image for given target.
 *
 * Arguments:
 * 0: Body image controls group <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _target, 0] call ace_medical_gui_fnc_updateBodyImage
 *
 * Public: No
 */

params ["_target", "_bodyPartN", "_adjust"];

private _ivFlow = _target getVariable [QEGVAR(pharma,IVFlow),[0,0,0,0,0,0]];

_ivFlow set [_bodyPartN, ((((_ivFlow select _bodyPartN) + _adjust) max 0) min 1.5)];
_target setVariable [QEGVAR(pharma,IVFlow), _ivFlow, true];