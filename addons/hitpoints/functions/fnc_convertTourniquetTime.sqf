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

params ["_type"];

private _tqTime = 1;
if (_type == 0) then {
    _tqTime = GVAR(treatmentTimeDelibrateTourniquet) - GVAR(treatmentTimeHastyTourniquet);
} else {
    _tqTime = GVAR(treatmentTimeTrainedDelibrateTourniquet) - GVAR(treatmentTimeTrainedHastyTourniquet);
};
_tqTime