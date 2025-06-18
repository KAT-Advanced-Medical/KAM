#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Removing Guedeltubus & KingLT
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus"] call kat_airway_fnc_treatmentAdvanced_RemoveAirwayItemLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname"];
private _canPlace = false;
private _catastrophicState = _patient getVariable [QGVAR(catastrophicAirway), [false, false]];

 if (!((_catastrophicState select 0) || (_catastrophicState select 1)) || (_classname isEqualTo "NPA")) then {
        _canPlace = true;
    };

_canPlace
