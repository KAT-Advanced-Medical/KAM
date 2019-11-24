#include "script_component.hpp"
/*
 * Author: Katalam
 * Called when a unit enters the injured state over KAM_airway_fnc_handleAirway
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: Airway injury possible <BOOLEAN>
 * 1: Reason <ARRAY>
 *  0: Counted internal head injuries <NUMBER>
 *  1: Counted internal chest wounds with 35 % possibility for beeing the reason for a collpased lung
 *
 * Example:
 * [player] call KAM_airway_fnc_possibleAirwayInjury;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(enable)) exitWith {false};

private _return = [];

// internal head bleeding possible?
private _airwayInjuries = {
    _x params ["_woundClassID", "_bodyPartN"];
    if !(_bodyPartN == 0) exitWith {false};
    if !(getNumber (configFile >> "ACE_Medical_Injuries" >> ace_medical_damage_woundClassNamesComplex select _woundClassID >> "internal") > 0) exitWith {false};
    true;
} count (_unit getVariable ["ace_medical_openWounds", []]);
if (_airwayInjuries isEqualType false) then {_airwayInjuries = 0};
_return pushBack _airwayInjuries;

// collpased lung possible?
// ALL_BODY_PARTS ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"]
private _chestWounds = {
    _x params ["_woundClassID", "_bodyPartN"];
    if !(_bodyPartN == 1) exitWith {false};
    if !(getNumber (configFile >> "ACE_Medical_Injuries" >> ace_medical_damage_woundClassNamesComplex select _woundClassID >> "internal") > 0) exitWith {false};
    if !(random 100 < PROBABILITY_BONES) exitWith {false};
    true;
} count (_unit getVariable ["ace_medical_openWounds", []]);
if (_chestWounds isEqualType false) then {_chestWounds = 0};
_return pushBack _chestWounds;

// return type: first airway damage possible, second the possible reasons
[(_airwayInjuries > 0) || {_chestWounds > 0}, _return]
