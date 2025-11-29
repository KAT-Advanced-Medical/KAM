#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle pneumothorax deterioration
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Deterioration chance increase <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 15] call kat_breathing_fnc_handlePneumothoraxTreatment;
 *
 * Public: No
 */

params ["_unit", "_side"];

[{
    params ["_unit", "_side"];

    private _hemo = _unit getVariable [QGVAR(hemopneumothorax), [0, 0]];
    private _currentVol = _hemo select _side;

    if (_currentVol <= 0) exitWith {};
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit", "_side"];

        private _hemo = _unit getVariable [QGVAR(hemopneumothorax), [0, 0]];
        private _drain = _unit getVariable [QGVAR(drainRate), [0, 0]];
        private _val = _hemo select _side;
        if (!alive _unit || (_val <= 0 && (INTERNAL_BLEEDING_RATE(_unit,2) == 0))) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _drain set [_side, 0];
            _unit setVariable [QGVAR(drainRate), _drain, true];
            private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
            _ht deleteAt (_ht find "hemo");
            _unit setVariable [QEGVAR(circulation,ht), _ht, true];
        };
        private _suctionEnabled = _unit getVariable [QGVAR(chestTubeSuction), false];  
        private _baseDrain = GVAR(chestTubeDrainAmount) * 0.001;
        private _pressureFactor = linearConversion [0, 1, _val, 0.4, 1.2, true];
        private _drainAmount = _baseDrain * _pressureFactor;
        private _newVal = _val - _drainAmount;
        if (_newVal < 0.01) then { _newVal = 0; };
        _hemo set [_side, _newVal];
        _unit setVariable [QGVAR(hemopneumothorax), _hemo, true];
        _drain set [_side, _drainAmount];
        _unit setVariable [QGVAR(drainRate), _drain, true];

    }, (3 * random [0.8, 1, 1.2]), [_unit, _side]] call CBA_fnc_addPerFrameHandler;

}, 
[_unit, _side], (3 * random [0.8, 1, 1.2])] call CBA_fnc_waitAndExecute;