#include "..\script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Applies a tourniquet to the patient on the given body part.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "", "", "_usedItem", "", "_type"];

[_patient, "activity", LSTRING(Activity_convertedTourniquet), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(tourniquetLocal), [_patient, _bodyPart, _type], _patient] call CBA_fnc_targetEvent;