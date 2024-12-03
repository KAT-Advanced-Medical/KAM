#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Attaches personal oxygen tank to player
 * Main function
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_attachPersonalOxygen;
 *
 * Public: No
 */

params ["_patient"];

if ((_patient getVariable [QGVAR(oxygenMaskActive), false])) exitWith {
    [LSTRING(PersonalOxygen_Affirm), 1.5, _patient] call ACEFUNC(common,displayTextStructured);
};

_patient setVariable [QGVAR(oxygenMaskActive), true, true];

private _availableTanks = (magazinesAmmo [_patient, false]) select {(_x select 0) isEqualTo "kat_personal_oxygen"};
private _largestTank = 0;

{ 
    if (_x select 1 > ((_availableTanks select _largestTank) select 1)) then { 
        _largestTank = _y; 
    }; 
} forEach _availableTanks;

private _largestTankValue = (_availableTanks select _largestTank) select 1;

_availableTanks deleteAt _largestTank;
_patient removeMagazines "kat_personal_oxygen";

{ _patient addMagazine _x; } forEach _availableTanks;

_patient setVariable [QGVAR(oxygenMaskStatus), [(_largestTankValue + 1), 1], true];

[{
    _this params ["_args", "_pfhID"];
    _args params ["_patient"];

    if !((_patient call EFUNC(airway,checkMask))) exitWith {
        _patient call FUNC(detachPersonalOxygen);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };
    
}, 5, [
    _patient
]] call CBA_fnc_addPerFrameHandler;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_patient"];

    if !(alive _patient) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(_patient setVariable [QGVAR(oxygenMaskActive), true]) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _maskStatus = _patient getVariable [QGVAR(oxygenMaskStatus), [0,0]];

    if ((_maskStatus select 0) == 0) exitWith {
        [LLSTRING(PersonalOxygen_Empty), 1.5, _patient] call ACEFUNC(common,displayTextStructured);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if ((_maskStatus select 1) == 0) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    _patient setVariable [QGVAR(oxygenMaskStatus), [((_maskStatus select 0) - 1), _pfhID]];
}, 60, [
    _patient
]] call CBA_fnc_addPerFrameHandler;
