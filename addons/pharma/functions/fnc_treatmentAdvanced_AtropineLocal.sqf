#include "script_component.hpp"
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
 * [player] call kat_pharma_fnc_treatmentAdvanced_AtropineLocal;
 *
 * Public: No
 */
 
params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];

_patient setVariable [QEGVAR(chemical,airPoisoning) ,false,true];
_patient setVariable [QEGVAR(chemical,isTreated) ,true,true];
_patient setVariable [QEGVAR(chemical,enteredPoison),false,true];
_patient setVariable [QEGVAR(chemical,timeleft), missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60], true];
if (_patient getVariable [QEGVAR(chemical,painEffect),0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};