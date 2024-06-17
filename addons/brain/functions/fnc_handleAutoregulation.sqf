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

if (!GVAR(enable) || _unit getVariable [QGVAR(autoregulationPFH),false]) exitWith {
    true
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        _unit setVariable [QGVAR(activityPFH),false,true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    GET_BLOOD_PRESSURE(_unit) params ["_systolic","_diastolic"];
    private _MAP = _diastolic + ((_systolic-_diastolic)/3);

    private _CVR = _unit getVariable [QGVAR(CVR),0.1];
    private _ICP = 20 max (_unit getVariable [QGVAR(ICP),10]);

    // calculate cerebral blood flow and autoregulation
    private _targetCBF = 800; //TODO change this value depending on blood oxygen saturation
    
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

    _unit setVariable [QGVAR(CVR),_newCVR,true];
    _unit setVariable [QGVAR(CBF),_CBF,true];

}, 15, [_unit]] call CBA_fnc_addPerFrameHandler;

true;
