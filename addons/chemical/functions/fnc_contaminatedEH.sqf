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

if (_unit getVariable [QGVAR(Contaminated), false]) exitWith {};

_unit setVariable [QGVAR(Contaminated), true, true];

private _timeBetween = missionNamespace getVariable [QGVAR(burnTime), 15];


//replace spawn with replacing it into vitals loop maybe?
[_unit, _timebetween] spawn {
    params ["_unit", "_timebetween"];

    while {alive _unit && (_unit getVariable [QGVAR(Contaminated), false])} do {

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

        sleep _timebetween;
    };
    _unit setVariable [QGVAR(Contaminated), false, true];
};
