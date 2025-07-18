#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski, kolmipilot
 * Handles poisoning of units in chemical-contaminated areas.
 * Handles poisoning units in chemical-contaminated areas.
 *
 * Arguments:
 * 0: Unit to poison <OBJECT>
 * 1: Gas level <NUMBER>
 * 2: Infected Object (source of gas) <OBJECT>
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

if (((_gasLevel == 0)||(_gasLevel == 1))&&(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) &&((_unit getVariable [QGVAR(SCBAEnabled), false]) ||{_unit getVariable [QGVAR(gasmask_durability), 10] > 0})) exitWith {
    TRACE_1("unit has gas mask",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};
if (((uniform _unit in (missionNamespace getVariable [QGVAR(availSuitsList), []])))&&(_gasLevel == 2)&&(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) &&((_unit getVariable [QGVAR(SCBAEnabled), false]) || {_unit getVariable [QGVAR(gasmask_durability), 10] > 0})) exitWith {
    TRACE_1("unit has gas mask, and suit",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};
if (((uniform _unit in (missionNamespace getVariable [QGVAR(availSuitsList), []])))&&((backpack _unit in (missionNamespace getVariable [QGVAR(availBackpackList), []])) && (_unit getVariable [QGVAR(SCBAEnabled), false]))&&(_gasLevel == 3)&&(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []]))) exitWith {
    TRACE_1("unit has gas mask, and backpack, and suit",_unit);
    [QGVAR(handleGasMaskDur), _unit, _unit] call CBA_fnc_targetEvent;
};

if (_gasLevel == 0) exitWith {
    _unit setVariable [QGVAR(CSGas), 30, true];
    if (random 1 <= GVAR(tearGasDropChance)) then {
        [QACEGVAR(hitreactions,dropWeapon), _unit, _unit] call CBA_fnc_targetEvent;
    };
};

// We assume that oxygen masks only cover the mouth and nose, leaving the eyes exposed to CS gas
if ((_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false])) exitWith {
    TRACE_1("unit has oxygen mask",_unit);
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
    if !(_unit getVariable [QGVAR(airPoisoning), false]) then {
        [QEGVAR(breathing,playCough), [_unit], _unit] call CBA_fnc_targetEvent;
    };

    _unit setVariable [QGVAR(airPoisoning), true, true];
    //Damage and burns
    switch (_gasLevel) do {
        case 0: { };  //cs gas, none
        case 1: { };  //pulmonary damage
        case 2: {     //burns, if dont mask on face, if dont cbrn suit on body
            [QGVAR(applyBurnDamage), [_unit, _infectedObject], _unit] call CBA_fnc_targetEvent;
            };  
        case 3: { };  //some nerve agent symphtoms
        default { };
    };
};
