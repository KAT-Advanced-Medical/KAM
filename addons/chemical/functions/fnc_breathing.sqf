#include "..\script_component.hpp"
/*
* Author: DiGii
*
* Handles the breathing sound for gasMasks
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* NONE
*
* Example:
* [player, "kat_mask_M50"] call kat_chemical_fnc_breathing;
*
* Public: No
*
*/
params ["_unit", "_glassesClass"];

if !(_glassesClass in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitWith {};


[
    {
        params["_args", "_handler"];
        _args params ["_unit"];
        if (!(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) || !(alive _unit) || (_unit getVariable [QACEGVAR(medical,inCardiacArrest), false])) then {
            [_handler] call CBA_fnc_removePerFrameHandler;
        } else {
            if ((GET_PAIN_PERCEIVED(_unit) >= 0.4) || (_unit getVariable [QACEGVAR(medical,heartrate), 80] >= 105)) then {
                _unit say3D QGVAR(mask_breath_heavy);
            } else {
                private _random = selectRandom [QGVAR(mask_breath_1), QGVAR(mask_breath_2)];
                _unit say3D _random;
            };
        };
    },
    5,
    [_unit]
] call CBA_fnc_addPerFrameHandler;

