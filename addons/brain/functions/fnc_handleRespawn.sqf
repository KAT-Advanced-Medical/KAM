#include "..\script_component.hpp"
/*
 * Author: apo_tle
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
 * [alive, body] call kat_brain_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

[_unit] call FUNC(fullHealLocal);

_unit setVariable [QEGVAR(brain,CMR),100,true];
_unit setVariable [QEGVAR(brain,CBF),800,true];
_unit setVariable [QEGVAR(brain,CVR),0.1,true];
_unit setVariable [QEGVAR(brain,ICP),15,true];
_unit setVariable [QEGVAR(brain,CPR),100,true];
_unit setVariable [QEGVAR(brain,rO2),80,true];
_unit setVariable [QEGVAR(brain,necrosis),0,true];
_unit setVariable [QGVAR(deoxygenatedTicks),0,true];
_unit setVariable [QEGVAR(brain,reversibleDamage),0,true];
_unit setVariable [QEGVAR(brain,autoregulationPFH), [_unit] call EFUNC(brain,handleAutoregulation),true];
_unit setVariable [QEGVAR(brain,activityPFH), [_unit] call EFUNC(brain,handleBrainActivity),true];
_unit setVariable [QEGVAR(brain,concussionPFH),0,true];
_unit setVariable [QEGVAR(brain,concussionSeverity),0,true];