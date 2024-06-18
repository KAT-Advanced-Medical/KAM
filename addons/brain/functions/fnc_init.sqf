#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_brain_fnc_init
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

_unit setVariable [QGVAR(CMR),20,true]; // Cerebral Metabolic Rate
_unit setVariable [QGVAR(CBF),800,true]; // Cerebral Blood Flow
_unit setVariable [QGVAR(CVR),0.1,true]; // Cerebral Vascular Resistance
_unit setVariable [QGVAR(ICP),10,true]; // Intracranial Pressure
_unit setVariable [QGVAR(CPR),100,true]; // Cerebral Perfusion Rate
_unit setVariable [QGVAR(rO2),80,true]; // Brain O2 saturation

_unit setVariable [QGVAR(necrosis),0,true];
_unit setVariable [QGVAR(reversibleDamage),0,true];

_unit setVariable [QGVAR(autoregulationPFH), [_unit] call FUNC(handleAutoregulation),true];
_unit setVariable [QGVAR(activityPFH), [_unit] call FUNC(handleBrainActivity),true];