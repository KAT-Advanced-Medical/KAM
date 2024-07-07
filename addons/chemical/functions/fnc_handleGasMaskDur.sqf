#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_handleGasMAskDur;
 *
 * Public: No
*/

params ["_unit"];

[
    {
        params["_unit"];
        !(missionNamespace getVariable [QGVAR(availGasmaskList), []] isEqualTo []) && _unit getVariable [QGVAR(enteredPoison), false]
    },
    {
        params["_unit"];
        if(_unit getVariable [QGVAR(enteredPoison), false] && (goggles _unit) in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {
            private _timeEntered = CBA_missionTime;
            private _maxTime = missionNamespace getVariable [QGVAR(gasmask_durability),900];
            private _currentDurability = _unit getVariable [QGVAR(gasmask_durability),10];
            [{
                params["_args","_handler"];
                _args params ["_unit","_timeEntered","_maxTime","_currentDurability"];
                private _currentDurability = _unit getVariable[QGVAR(gasmask_durability),10];

                if (_unit getVariable [QGVAR(gasmask_durability_reset),false]) then {
                    _unit setVariable [QGVAR(gasmask_durability_reset),false,true];
                    [_handler] call CBA_fnc_removePerFrameHandler;
                    [_unit] call FUNC(handleGasMaskDur);
                };

                private _timeLeft = _maxTime - (CBA_missionTime - _timeEntered);
                private _percent = round ((10/_maxTime)*_timeLeft);

                if(_currentDurability != _percent) then {
                    _unit setVariable [QGVAR(gasmask_durability),_percent];
                };

                if(_currentDurability <= 0 || _percent <= 0 || !(alive _unit)) exitWith {
                    [_handler] call CBA_fnc_removePerFrameHandler;
                    _unit setVariable [QGVAR(gasmask_durability),0];
                    [_unit] call FUNC(handleGasMaskDur);
                };

                if !(_unit getVariable [QGVAR(enteredPoison), false]) exitWith{
                    [_handler] call CBA_fnc_removePerFrameHandler;
                    [_unit] call FUNC(handleGasMaskDur);
                };

            },1,[_unit,_timeEntered,_maxTime,_currentDurability]] call CBA_fnc_addPerFrameHandler;
        } else {
            [
                {
                    params["_unit"];
                    _unit getVariable [QGVAR(enteredPoison), false] || (goggles _unit) in (missionNamespace getVariable [QGVAR(availGasmaskList), []])
                },
                {
                    [_unit] call FUNC(handleGasMaskDur);
                },
                [_unit]
            ] call CBA_fnc_waitUntilAndExecute;
        };
    },
    [_unit]
] call CBA_fnc_waitUntilAndExecute;
