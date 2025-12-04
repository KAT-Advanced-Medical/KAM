#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles the autoregulation of CVR to achieve optimal CBF. 
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * 0: PFH enabled <BOOL>
 *
 * Example:
 * [bob] call kat_brain_fnc_handleAutoregulation
 *
 * Public: No
 */

params ["_unit"];

if (!local _unit) then {
    [QGVAR(handleAutoregulation), [_unit], _unit] call CBA_fnc_targetEvent;
};
if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {};
if !(GVAR(enable) || (isNil QGVAR(autoregulationPFH))) exitWith {};

private _newPFH = [{

    params ["_args", "_idPFH"];
    _args params ["_unit"];

    if !(alive _unit) exitWith {
        _unit setVariable [QGVAR(autoregulationPFH),nil,true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _bloodPressure = [_unit] call EFUNC(circulation,getBloodPressure);
    _bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
    private _map = _bloodPressureL + (0.3333333333 * (_bloodPressureH - _bloodPressureL));
    
    private _mapHighTicks = _unit getVariable [QGVAR(mapHighTicks), 0];
    private _autoregFatigue = _unit getVariable [QGVAR(autoregFatigue), 0];
    if (_map > 120) then {
        _mapHighTicks = _mapHighTicks + 1;
    } else {
        _mapHighTicks = (_mapHighTicks - 1) max 0;
    };
    if (_mapHighTicks >= 20) then {
        private _excessTicks = (_mapHighTicks - 20) + 1;
        _autoregFatigue = (_autoregFatigue + (0.5 * _excessTicks)) min 100;
    } else {
        _autoregFatigue = (_autoregFatigue - 0.25) max 0;
    };
    _unit setVariable [QGVAR(mapHighTicks), _mapHighTicks, true];
    _unit setVariable [QGVAR(autoregFatigue), _autoregFatigue, true];

    private _CVR = _unit getVariable [QGVAR(CVR),0.1];
    private _ICP = 5 max (_unit getVariable [QGVAR(ICP),15]);

    private _paCO2 = GET_PACO2(_unit);
    private _paCO2Factor = 1 + (0.03 * (_paCO2 - 40));
    _paCO2Factor = 0 max _paCO2Factor; // prevent negative values
    private _targetCBF = 800 * (97/GET_KAT_SPO2(_unit)) * _paCO2Factor;
    private _fatigueMultiplier = 1 - ((_autoregFatigue / 100) * 0.6);

    private _targetCVR_raw = (_map - 20) / _targetCBF;
    private _targetCVR = _targetCVR_raw * _fatigueMultiplier;

    private _minCVR = 0.0375 + ((_autoregFatigue / 100) * 0.05);
    _targetCVR = _minCVR max _targetCVR;
    _targetCVR = _targetCVR min 0.17875;
    private _newCVR = (((_CVR + _targetCVR) / 2) + _targetCVR) / 2;
    private _CPP = (_map - _ICP) max 0;
    if (_CPP > 200) then { _newCVR = 0.1; };

    private _CBF = round (_CPP / _newCVR);
    private _CPR = (_CBF / 800 * 100) min 200;
    _CPR = _CPR * (GET_KAT_SPO2(_unit)/100);
    _unit setVariable [QGVAR(CVR),_newCVR,true];
    _unit setVariable [QGVAR(CBF),_CBF,true];
    _unit setVariable [QGVAR(CPR),_CPR,true];
    private _ICP_delta = 0;
    if (_mapHighTicks >= 25) then {
        private _mapOver = _map - 110;
        private _durationFactor = ((_mapHighTicks - 25) + 1);
        _ICP_delta = (_mapOver * 0.02) * (_durationFactor);
        private _fatigueIcpAmplify = 1 + ((_autoregFatigue / 100) * 0.25);
        _ICP_delta = _ICP_delta * _fatigueIcpAmplify;
        _ICP_delta = (_ICP_delta min 3) max 1;
    };
    private _newICP = _ICP + _ICP_delta;
    _newICP = (5 max _newICP) min 60;
    _unit setVariable [QGVAR(ICP), _newICP, true];

}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;

_unit setVariable [QGVAR(autoregulationPFH),_newPFH,true];
