#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Logic <MODULE>
 * 1: Radius <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [logic, 10] call kat_chemical_fnc_handleCSGas;
 *
 * Public: No
*/
params ["_logic","_radius"];
[{
    params["_params","_handler"];
    _params params["_unit"];
    if (_unit getVariable[QGVAR(enteredPoison),false]) then {
        if (_unit getVariable [QACEGVAR(medical,pain), 0] < 0.25) then {_unit setVariable [QACEGVAR(medical,pain), 0.41]};
        if (goggles _unit in GVAR(availGasmaskList)) then {_unit setVariable [QGVAR(enteredPoison), false, true]};
        _unit setVariable [QGVAR(CS), true, true];
        _unit say3D QGVAR(cough_1);
        private _rndBlur = selectRandom [5, 6, 7, 8];
        ppBlur ppEffectAdjust [_rndBlur]; 
        ppBlur ppEffectEnable true;  
        ppBlur ppEffectCommit 5;
    } else {
        ppBlur ppEffectAdjust [0]; 
        ppBlur ppEffectEnable true; 
        ppBlur ppEffectCommit 20;
        _unit setVariable [QGVAR(CS), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
        
    };
}, 5, [player]] call CBA_fnc_addPerFrameHandler;

//Pos Check
[{
    params ["_param","_handler"];
    _param params ["_logic","_radius","_unit"];
    private _pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
    if ( _unit distance _pos > _radius || !(_logic getVariable[QGVAR(gas_active),false]) || isNull _logic ) exitWith {
        _unit setVariable[QGVAR(enteredPoison), false, true];
        [_handler] call CBA_fnc_removePerFrameHandler;
    };
},2,[_logic, _radius, player]] call CBA_fnc_addPerFrameHandler;