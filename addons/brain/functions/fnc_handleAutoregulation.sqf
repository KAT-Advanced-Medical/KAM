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

    private _CVR = _unit getVariable [QGVAR(CVR),0.1];
    private _ICP = 5 max (_unit getVariable [QGVAR(ICP),15]);

    private _paCO2 = GET_PACO2(_unit);
    private _paCO2Factor = 1 + (0.03 * (_paCO2 - 40));
    _paCO2Factor = 0 max _paCO2Factor; // prevent negative values
    private _targetCBF = 800 * (97/GET_KAT_SPO2(_unit)) * _paCO2Factor;
    
    private _targetCVR = (_MAP-20)/_targetCBF;
    _targetCVR = (0.0375 max _targetCVR)  min 0.17875; //Clamp CVR between two values:
    //If the required CVR is less than 0.0375, CBF will not be able to be high enough and reduced perfusion occurs.
    //If the required CVR exceeds 0.17875, CBF will be too high and luxury perfusion occurs.

    private _newCVR = (((_CVR+_targetCVR ) / 2) + _targetCVR) / 2; // interpolate CVR to target value

    private _CPP = _MAP-_ICP max 0; 
    if (_CPP > 200) then { // Simulate autoregulation breakthrough (too large CPP causes spike in CBF)
        _newCVR = 0.1;
    };

    private _CBF = round (_CPP/_newCVR);
    private _CPR = (_CBF/800 * 100) min 200;
    _CPR = _CPR * (GET_KAT_SPO2(_unit)/100);

    _unit setVariable [QGVAR(CVR),_newCVR,true];
    _unit setVariable [QGVAR(CBF),_CBF,true];
    _unit setVariable [QGVAR(CPR),_CPR,true];

}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;
_unit setVariable [QGVAR(autoregulationPFH),_newPFH,true];
