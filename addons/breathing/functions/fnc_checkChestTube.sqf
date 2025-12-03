#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handle checking of the chest tube for blood
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1] call kat_breathing_fnc;
 *
 * Public: No
 */
 params ["_medic", "_patient", "_side"];

private _drain = (_patient getVariable [QGVAR(drainRate), [0, 0]] select _side) / GVAR(chestTubeDrainAmount);
private _hintcTStatus = LLSTRING(chestTubeStatus_ClearDry);
private _cTStatus = LSTRING(chestTubeStatus_ClearDry_short);
private _hintWidth = 17;
private _hintSize = 2;
switch (true) do {
        case (_drain > 0.03): {
            _hintWidth = 17;
            _hintcTStatus = LLSTRING(chestTubeStatus_HeavyDrain);
            _cTStatus = LSTRING(chestTubeStatus_HeavyDrain_short);
        };
        case (_drain > 0.015): {
            _hintWidth = 17;
            _hintcTStatus = LLSTRING(chestTubeStatus_NormalDrain);
            _cTStatus = LSTRING(chestTubeStatus_NormalDrain_short);
        };
        case (_drain > 0.010): {
            _hintWidth = 17;
            _hintcTStatus = LLSTRING(chestTubeStatus_SlowDrain);
            _cTStatus = LSTRING(chestTubeStatus_SlowDrain_short);
        };
        case (_drain < 0.010): {
            _hintWidth = 17;
            _hintcTStatus = LLSTRING(chestTubeStatus_MinimalDrain);
            _cTStatus = LSTRING(chestTubeStatus_MinimalDrain_short);
        };
        default {
            _hintcTStatus = LLSTRING(chestTubeStatus_ClearDry);
            _cTStatus = LSTRING(chestTubeStatus_ClearDry_short);
        };
};

[_hintcTStatus, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);
private _sideText = LSTRING(LeftSide);
if (_side == 1) then {_sideText = LSTRING(RightSide)};
[_patient, "quick_view", LSTRING(CheckChestTube_Log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(CheckChestTube_Log), [[_medic] call ACEFUNC(common,getName), _sideText, _cTStatus]] call ACEFUNC(medical_treatment,addToLog);