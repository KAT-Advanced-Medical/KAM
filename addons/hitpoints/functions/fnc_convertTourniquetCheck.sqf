#include "..\script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Applies a tourniquet to the patient on the given body part.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet
 *
 * Public: No
 */

params ["_unit", "_bodyPart"];

private _index = ALL_BODY_PARTS find toLowerANSI _bodyPart;
_hasCovertableTQ = false;
if (_index >= 0) then {
    private _tqValue = (_unit getVariable [VAR_KAT_TOURNIQUET, [0,0,0,0,0,0,0,0,0,0,0,0]] select _index);
    _hasCovertableTQ = (_tqValue > 0.1 && _tqValue < 1);
};
_hasCovertableTQ