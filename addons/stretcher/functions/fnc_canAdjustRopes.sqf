#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if ropes can be adjusted
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Example:
 * [cursorObject] call kat_stretcher_fnc_canAdjustRopes;
 *
 * Public: No
 */

params ["_target"];

_target getVariable [QGVAR(isStretcherAttached), false] 
&& (_target getVariable [QGVAR(stretcherDeployed), false]) 
&& (ropeUnwound (_target getVariable [QGVAR(ropes), []] param [0, objNull]))