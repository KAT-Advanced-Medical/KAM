#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles various objects on fire and determines if units close to objects deserve to get burned.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ace_fire_fnc_fireManagerPFH call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

params ["_unit", "_gasLevel", "_infectedObject"];

// Check if unit is remote (objNull is remote)
if (!local _unit) exitWith {
    TRACE_1("unit is null or not local",_unit);
};

// Check if the unit can poison (takes care of spectators and curators)
if (getNumber (configOf _unit >> "isPlayableLogic") == 1 || {!(_unit isKindOf "CAManBase")}) exitWith {
    TRACE_1("unit is virtual or not a man",_unit);
};

// If unit is invulnerable, don't poison the unit
if !(isDamageAllowed _unit && {_unit getVariable [QACEGVAR(medical,allowDamage), true]}) exitWith {
    TRACE_1("unit is invulnerable",_unit);
};

if ((goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) && {_unit getVariable [QGVAR(gasmask_durability), 10] > 0}) exitWith {
    TRACE_1("unit has gas mask",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};

if (_gasLevel == 0) exitWith {
    _unit setVariable [QGVAR(CSGas), 30, true];
    if (random 1 <= GVAR(tearGasDropChance)) then {
        [QACEGVAR(hitreactions,dropWeapon), _unit, _unit] call CBA_fnc_targetEvent;
    };
};

private _currentInfectionArray = _unit getVariable [QGVAR(infectionArray), []];

if ((_currentInfectionArray findIf { _x isEqualTo _infectedObject}) == -1) then {
    _currentInfectionArray append [_infectedObject];
};

_unit setVariable [QGVAR(infectionArray), _currentInfectionArray, true];

//Get max infection time
private _infectionTime = missionNamespace getVariable [QGVAR(infectionTime), 60];

//Get current time left for player
private _currentInfection = _unit getVariable [QGVAR(infectionTime), 60];

private _timeLeft = _currentInfection - 1;
_timeLeft = _timeLeft max 0;

private _newTime = _timeLeft;

if (_currentInfection != _newTime) then {
    _unit setVariable [QGVAR(infectionTime), _newTime, true];
};

// Exit if infection reaches 0
if (_newTime <= 0) then {
    _unit setVariable [QGVAR(airPoisoning), true, true];
};