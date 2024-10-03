#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Sedates the patient
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: bodypart
 * 2 classname
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, leftLeg, syringe_kat_ketamine_5ml_2] call kat_pharma_fnc_treatmentAdvanced_ketamineLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_classname"];
if !(_classname isEqualTo "syringe_kat_ketamine_5ml_2") exitWith {};

_patient setVariable [QEGVAR(surgery,sedated), true, true];
[_patient, true] call ACEFUNC(medical,setUnconscious);

[{ 
    _patient setVariable ["kat_surgery_sedated", false, true]; 
}, 30] call CBA_fnc_waitAndExecute;
