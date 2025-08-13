#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * VX gas poisoning handler
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_contaminatedEH;
 *
 * Public: No
 */

params ["_unit"];

if (_unit getVariable [QGVAR(Contaminated), false] && {!alive _unit}) exitWith {};

private _timeBetween = missionNamespace getVariable [QGVAR(burnTime), 15];

if (_unit getVariable [QGVAR(contaminatedHead), false]) then {
    if (random 1 < 0.5) then {
        [_unit, 0.2, "head", "chemburn"] call ace_medical_fnc_addDamageToUnit;
    };
};

//if doesnt have suit on give damage on body
if (_unit getVariable [QGVAR(contaminatedBody), false]) then {
    private _bodyParts = ["body", "leftarm", "rightarm", "leftleg", "rightleg"];
    private _randomPart = selectRandom _bodyParts;
    [_unit, 0.2, _randomPart, "chemburn"] call ace_medical_fnc_addDamageToUnit;
};

[{
    params ["_unit"];
    [_unit] call FUNC(contaminatedEH)
}, [_unit], _timeBetween] call CBA_fnc_waitAndExecute;
