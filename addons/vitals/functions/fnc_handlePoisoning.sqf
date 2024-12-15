#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Update poisoning

 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Poison Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * ReturnValue:
 * None
 *
 * Example:
 * [player, 1, 1, false] call kat_vitals_handlePoisoning;
 *
 * Public: No
 */

params ["_unit", "_poisonAdjustment", "_deltaT", "_syncValue"];

private _currentCS = _unit getVariable [QEGVAR(chemical,CSGas), 0];

_unit setVariable [QEGVAR(chemical,CSGas), (_currentCS - (_poisonAdjustment * _deltaT)) max 0, _syncValue];

private _infectionArray = _unit getVariable [QEGVAR(chemical,infectionArray), []];

if (count _infectionArray == 0) then {
    private _currentInfection = _unit getVariable [QEGVAR(chemical,infectionTime), missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60]];
    private _updateTime = _currentInfection + (1 * _deltaT);
    _updateTime = _updateTime min (missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60]);

    _unit setVariable [QEGVAR(chemical,infectionTime), _updateTime, true];
} else {
    {
        _x params ["_gasLogic", "_radius", "_gasLevel", "_condition", "_conditionArgs", "_isSealable"];

        // Get the distance of the unit from the center of the sphere (_gasLogic)
        private _distance = _unit distance _gasLogic;

        if (_distance > _radius) then {
            _infectionArray deleteAt _forEachIndex;
        };
    } forEach _infectionArray;

    _unit setVariable [QEGVAR(chemical,infectionArray), _infectionArray, true];
};