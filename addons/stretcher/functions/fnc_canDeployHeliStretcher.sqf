#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Checks if attached helistretcher can be deployed
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Example:
 * [player] call kat_stretcher_fnc_canDeployStretcher;
 *
 * Public: No
 */

params ["_player"];

objectParent _player getVariable [QGVAR(isStretcherAttached), false] && !(objectParent _player getVariable [QGVAR(stretcherDeployed), false])