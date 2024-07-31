#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for applying fluid warmers
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hypothermia_fnc_applyFluidWarmerLocal;
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _warmerArray = _patient getVariable [QGVAR(fluidWarmer), [0,0,0,0,0,0]];

if (_warmerArray select _partIndex == 0) exitWith {
	false
};

true

