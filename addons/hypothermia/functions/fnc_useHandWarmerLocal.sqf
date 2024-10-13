#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for applying hand warmers
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, "LeftLeg"] call kat_hypothermia_fnc_useHandWarmerLocal;
 *
 * Public: No
 */
params ["_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _warmerArray = _patient getVariable [QGVAR(handWarmers), [0,0,0,0,0,0]];
_warmerArray set [_partIndex, 60];

_patient setVariable [QGVAR(handWarmers), _warmerArray];