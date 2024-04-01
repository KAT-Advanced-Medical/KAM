#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

[_unit] call FUNC(fullHealLocal);

_unit setVariable [QGVAR(PneumoBreathCooldownOn), false, true];

_unit setVariable [QGVAR(BVMInUse), false, true];
_unit setVariable [QGVAR(oxygenTankConnected), false, true];
_unit setVariable [QGVAR(oxygenTankPreferred), "", true];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(PulseOximeter_Volume), false, true];
_unit setVariable [QGVAR(PulseOximeter_VolumePatient), false, true];
_unit setVariable [QGVAR(PulseOximeter_Attached), [0,0], true];

_unit setVariable ["kat_PulseoxiInUse_PFH", nil, true];
_unit setVariable ["kat_O2Breathing_PFH", nil, true];

_unit setVariable [QGVAR(usingStethoscope), nil];
