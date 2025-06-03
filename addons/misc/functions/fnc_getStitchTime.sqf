#include "..\script_component.hpp"
/*
 * Author: kymckay
 * Calculates the Surgical Kit treatment time based on the amount of stitchable wounds.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Treatment Time <NUMBER>
 *
 * Example:
 * [player, cursorObject, "head"] call ace_medical_treatment_fnc_getStitchTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];

private _unstitchableTypes = ["ETD", "Israeli_Bandage"];

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient) getOrDefault [_bodyPart, []];

private _stitchableWounds = _bandagedWounds select {
    _x params ["_woundClassID", "_amountOf", "_bleedingRate", "", "_type"];
    
    private _classIndex = _woundClassID / 10;
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    !(_type in _unstitchableTypes) && !(_className in ["InternalBleeding", "Evisceration", "Thermal_Burn"]);
};

count _stitchableWounds * ACEGVAR(medical_treatment,woundStitchTime)