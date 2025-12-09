#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Called when a unit is hit. Handles receiving TBIs and setting up dedicated PFHs to increase ICP.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *  0: Damage <NUMBER>
 *  1: Bodypart <STRING>
 * 2: Shooter <OBJECT>
 * 3: Ammo classname or damage type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Head"], objNull, "BulletBase"] call kat_brain_fnc_concussion
 *
 * Public: No
 */
params ["_unit", "_allDamages", "_typeOfDamage"];
if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {_this};
(_allDamages select 0) params ["_damage", "_bodyPart"]; // selection-specific
if !(GVAR(enable) && _bodyPart == "head") exitWith {_this};
if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {_this};
if (_damage <= 0) exitWith {_this};
// Increase the chance based on how much damage was received 
private _chanceIncrease = linearConversion [0,1,_damage,5,30,true];
// Increase the chance of concussions depending on the damage type
private _chanceMultiplier = 1;
if (_typeOfDamage in ["vehiclehit","explosive","shell","vehiclecrash"]) then {
	_chanceMultiplier = linearConversion [0,3,(["vehiclehit","explosive","shell","vehiclecrash"] find _typeOfDamage),1.2,2,true];
};

private _concussionChance = (GVAR(concussionChance) + _chanceIncrease) * _chanceMultiplier;
if (floor (random 100) <= _concussionChance) then {
    private _concussion = _unit getVariable [QGVAR(concussion), 0];
    private _edema      = _unit getVariable [QGVAR(edema), 0];
    private _bleeding   = _unit getVariable [QGVAR(bleeding), 0];
    private _necrosis   = _unit getVariable [QGVAR(necrosis), 0];

    private _base = random [0.05, 0.1, 0.2];
    private _impactFactor = linearConversion [0, 6, _damage, 0.1, 0.8, true];
    private _newConcussion = (_base + _impactFactor) min 1;

    private _newEdema = _edema + linearConversion [0,6,_damage,0,0.25,true];

    if (_damage > 0.6 || {_typeOfDamage in ["vehiclehit","explosive","shell","vehiclecrash"]}) then {
        private _newBleed = random [0,0.1,0.25];
        _bleeding = (_bleeding + _newBleed) min 1;
    };

    if (_damage > 3) then {
        _necrosis = (_necrosis + random [1,3,5]) min 5;
    };

    if (_damage > 5) then {
        _necrosis = (_necrosis + random [1,6,12]) min 12;
    };

    _unit setVariable [QGVAR(concussion), _newConcussion, true];
    _unit setVariable [QGVAR(edema),      _newEdema,     true];
    _unit setVariable [QGVAR(bleeding),   _bleeding,     true];
    _unit setVariable [QGVAR(necrosis),   _necrosis,     true];

    if (isNil {_unit getVariable QGVAR(concussionPFH)}) then {
        [_unit] call FUNC(concussionPFH);
    };
};

_this