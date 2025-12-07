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

_patient setVariable [QGVAR(CMR),100,true]; // Cerebral Metabolic Rate (%)
_patient setVariable [QGVAR(CBF),800,true]; // Cerebral Blood Flow
_patient setVariable [QGVAR(CVR),0.1,true]; // Cerebral Vascular Resistance
_patient setVariable [QGVAR(ICP),15,true]; // Intracranial Pressure
_patient setVariable [QGVAR(CPR),100,true]; // Cerebral Perfusion Rate
_patient setVariable [QGVAR(rO2),80,true]; // Brain O2 saturation

_patient setVariable [QGVAR(necrosis),0,true];
_patient setVariable [QGVAR(deoxygenatedTicks),0,true];
_patient setVariable [QGVAR(reversibleDamage),0,true];
_patient setVariable [QGVAR(mapHighTicks),0,true];
_patient setVariable [QGVAR(autoregFatigue),0,true];
_patient setVariable [QGVAR(edema),0,true];
_patient setVariable [QGVAR(bleeding),0,true];
_patient setVariable [QGVAR(isSwelling),false,true];


//TODO fix these PFHs so that they dont create duplicates when a player is healed
_patient setVariable [QGVAR(autoregulationPFH), [_patient] call FUNC(handleAutoregulation),true];
_patient setVariable [QGVAR(activityPFH), [_patient] call FUNC(handleBrainActivity),true];

_patient setVariable [QGVAR(concussionPFH),nil,true];
_patient setVariable [QGVAR(concussion),0,true];