/*
 * Author: Katalam
 * Remove the false blood effect for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceCirculation_fnc_removeEffect_IV;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable ["kat_aceCirculation_IV_counts", 0, true];
