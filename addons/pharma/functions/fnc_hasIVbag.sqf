#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks if any IV bags are present
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Check IV Condition <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "saline"] call kat_pharma_fnc_ivBagCheck;
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;
private _ivBags = _patient getVariable [QACEGVAR(medical,ivBags), []];

private _hasIV = _ivBags findIf {
    private _bagType = _x select 1;
    !(_bagType in ["FBTK_500", "FBTK_250"])
    &&
    (_x select 2) isEqualTo _partIndex
} != -1;

TRACE_3("hasMatchingIV", _ivBags, _partIndex, _hasIV);
_hasIV