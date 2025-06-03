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
params ["_medic", "_patient", "_bodyPart", "_type"];

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;
_ivBags = (_patient getVariable [QACEGVAR(medical,ivBags), []]);

private _hasMatchingIV = _ivBags findIf {
    (_x select 1) isEqualTo _type &&
    (_x select 2) isEqualTo _partIndex
} != -1;
TRACE_4("hasMatchingIV",_ivBags,_partIndex,_type,_hasMatchingIV);

_hasMatchingIV