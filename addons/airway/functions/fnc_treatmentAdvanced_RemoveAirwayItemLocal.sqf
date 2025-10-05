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

params ["_medic", "_patient", "_item"];
private _occlusion = _patient getVariable [QGVAR(occlusion), [0, 0, 0]];
private _total = 0; { _total = _total + _x } forEach _occlusion;
private _airwayVomit = floor (_total/3);
for "_i" from 0 to 2 do {
    _occlusion set [_i, _airwayVomit];
};
_patient setVariable [QGVAR(occlusion), _occlusion, true];
_patient setVariable [QGVAR(airway_item), "", true];
_patient setVariable [QGVAR(airway), false, true];
_patient setVariable [QGVAR(airwayStatus), [0, 0, 0], true];
_patient setVariable [QGVAR(occlusionMitigation), [0, 0, 0], true];
_patient call FUNC(handleAirway);

if !(GVAR(ReusableAirwayItems)) exitWith {};

switch (true) do {
    case (_item isEqualTo "Larynxtubus"): {
        [_medic, "kat_larynx"] call ACEFUNC(common,addToInventory);
    };
    case (_item isEqualTo "IGEL"): {
        [_medic, "kat_IGEL"] call ACEFUNC(common,addToInventory);
    };
    case (_item isEqualTo "ETT"): {
        [_medic, "kat_ETT"] call ACEFUNC(common,addToInventory);
    };
    case (_item isEqualTo "NPA"): {
        [_medic, "kat_NPA"] call ACEFUNC(common,addToInventory);
    };
    case (_item isEqualTo "Guedeltubes"): {
        [_medic, "kat_guedel"] call ACEFUNC(common,addToInventory);
    };
    default {};
};
