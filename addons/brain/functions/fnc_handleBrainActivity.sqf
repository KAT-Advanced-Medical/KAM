#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles the main loop for brain vitals and maintaining perfect cerebral metabolic rate
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_brain_fnc_handleBrainActivity
 *
 * Public: No
 */

 params ["_unit"];

if (!local _unit) then {
    [QGVAR(handleBrainActivity), [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
}, 15, [_unit]] call CBA_fnc_addPerFrameHandler;
