#include "..\script_component.hpp"
/*
 * Author: kymckay/cplhardcore
 * Prevents bandage actions from showing if selected body part isn't bleeding.
 * Toggles between showing all or only basic bandage action for advanced setting.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Can Bandage <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Head", "FieldDressing"] call ace_medical_treatment_fnc_canBandage
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart", "_bandage"];
_bodyPart = toLowerANSI _bodyPart;

private _wounds = (GET_OPEN_WOUNDS(_patient)) getOrDefault [_bodyPart, []];
private _canBandage = false;
if ((_bandage == "BasicBandage") isEqualTo (ACEGVAR(medical_treatment,advancedBandages) != 0)) exitWith {false};

{
    _x params ["_woundClassID", "_amountOf", "_bleeding"];

    private _classIndex = _woundClassID / 10;
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

    if ((_className isNotEqualTo "InternalBleeding") && (_amountOf * _bleeding > 0)) exitWith {
        _canBandage = true;
    };
} forEach _wounds;
_canBandage