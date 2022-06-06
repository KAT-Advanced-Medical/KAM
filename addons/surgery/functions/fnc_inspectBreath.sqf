#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
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
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_fractureCheck;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _ph = _patient getVariable [QGVAR(ph), 1500];

if (_ph > 750) exitWith {
    private _output = localize LSTRING(breath_good);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

if (_ph > 250) exitWith {
    private _output = localize LSTRING(breath_mild);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _output = localize LSTRING(breath_stink);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;