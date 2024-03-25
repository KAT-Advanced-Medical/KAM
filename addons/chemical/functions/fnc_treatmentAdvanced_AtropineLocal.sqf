#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes Bradycardia Effect.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_treatmentAdvanced_AtropineLocal;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(airPoisoning) ,false,true];
_patient setVariable [QGVAR(isTreated) ,true,true];
_patient setVariable [QGVAR(enteredPoison),false,true];
_patient setVariable [QGVAR(timeleft), missionNamespace getVariable [QGVAR(infectionTime), 60], true];
if (_patient getVariable [QGVAR(painEffect),0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};
