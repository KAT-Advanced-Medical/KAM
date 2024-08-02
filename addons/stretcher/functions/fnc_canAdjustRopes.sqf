#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if ropes can be adjusted
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Example:
 * [player] call kat_stretcher_fnc_canAdjustRopes;
 *
 * Public: No
 */

params ["_player"];

objectParent _player getVariable [QGVAR(isStretcherAttached), false] 
&& (objectParent _player getVariable [QGVAR(stretcherDeployed), false]) 
&& (ropeUnwound (ropes objectParent _player  select 0))