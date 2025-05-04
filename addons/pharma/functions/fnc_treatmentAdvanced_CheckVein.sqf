#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Checks the Coag Factors and displays it to the player
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Bodypart <String>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget, "LeftLeg"] call kat_pharma_fnc_treatmentAdvanced_CheckVein;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodypart"];

 private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
 private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
 private _IVactual = _IVarray select _partIndex;

 if (_IVactual == 9) then {
    hint str LLSTRING(CheckVein_VeinBlown);
    [{hint "";}, [], 10] call CBA_fnc_waitAndExecute;
} else {
    hint str LLSTRING(CheckVein_VeinFine);
    [{hint "";}, [], 10] call CBA_fnc_waitAndExecute;
};
