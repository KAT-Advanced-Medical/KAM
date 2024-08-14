#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_brain_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_unit setVariable [QGVAR(CMR),100,true]; // Cerebral Metabolic Rate (%)
_unit setVariable [QGVAR(CBF),800,true]; // Cerebral Blood Flow
_unit setVariable [QGVAR(CVR),0.1,true]; // Cerebral Vascular Resistance
_unit setVariable [QGVAR(ICP),15,true]; // Intracranial Pressure
_unit setVariable [QGVAR(CPR),100,true]; // Cerebral Perfusion Rate
_unit setVariable [QGVAR(rO2),80,true]; // Brain O2 saturation

_unit setVariable [QGVAR(necrosis),0,true];
_unit setVariable [QGVAR(deoxygenatedTicks),0,true];
_unit setVariable [QGVAR(reversibleDamage),0,true];

//TODO fix these PFHs so that they dont create duplicates when a player is healed
_unit setVariable [QGVAR(autoregulationPFH), [_unit] call FUNC(handleAutoregulation),true];
_unit setVariable [QGVAR(activityPFH), [_unit] call FUNC(handleBrainActivity),true];

_unit setVariable [QGVAR(concussionPFH),0,true];
_unit setVariable [QGVAR(concussionSeverity),0,true];