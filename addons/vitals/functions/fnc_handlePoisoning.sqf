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

if (_unit getVariable [QEGVAR(chemical,airPoisoning), false]) then {
    private _currentInfection = _unit getVariable [QEGVAR(chemical,infectionTime), missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60]];
    private _updateTime = _currentInfection + (1 * _deltaT);
    _updateTime = _updateTime min (missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60]);

    _unit setVariable [QEGVAR(chemical,infectionTime), _updateTime, true];
} else {
    _unit setVariable [QEGVAR(chemical,infectionTime), 0, true];
};