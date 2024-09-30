#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the IV from the patient on the given body part.
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * Check IV <NUMBER>
 * 0: No IV/IO
 * 1: Fast IO
 * 2: 16G IV
 * 3: 14G IV
 * 4: 20G IV
 *
 * Example:
 * [cursorObject, "LeftLeg"] call kat_pharma_fnc_checkIVType;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _return = 0;

if (_IVactual > 0) then {
    _return = _IVactual;
};

_return
