/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceCirculation_fnc_init
 *
 * Public: No
 */

params ["_unit"];

//#define BLOOD_TYPES ["O POS", "O NEG", "A POS", "A NEG", "B POS", "B NEG", "AB POS", "AB NEG"]
#define BLOOD_TYPES ["O", "A", "B", "AB"]

_type = BLOOD_TYPES select random(3);

_unit setVariable ["kat_aceCirculation_bloodtype", _type, true];
_unit setVariable ["kat_aceCirculation_IV_counts", 0, true];
