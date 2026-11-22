#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Returns the patients of a training computer that still exist, dead ones included.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 *
 * Return Value:
 * Patients <ARRAY>
 *
 * Example:
 * [cursorObject] call kat_training_fnc_getPatients
 *
 * Public: No
 */

params [["_computer", objNull, [objNull]]];

(_computer getVariable [QGVAR(patients), []]) select {!isNull _x}
