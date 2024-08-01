#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - attaching it and using it.
 *
 *
 * Example:
 * [_unit,_item] call kat_misc_fnc_heliStretcherAttach;
 *
 * Public: No
 */

params ["_player"];
objectParent _player getVariable [QGVAR(isStretcherAttached), false] && !(objectParent _player getVariable [QGVAR(stretcherDeployed), false])