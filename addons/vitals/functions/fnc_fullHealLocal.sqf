#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_vitals_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(simpleMedical), false, true];
_patient setVariable [QGVAR(respiratoryDepth), DEFAULT_RESPIRATORY_DEPTH, true];

if (GVAR(enableSimpleMedical)) then {
    _patient setVariable [QGVAR(simpleMedical), true, true];
};

if (("RemoveStamina" call ACEFUNC(common,isModLoaded)) || (isNil QACEGVAR(advanced_fatigue,enabled))) then {
    _patient setVariable [QGVAR(fatigueEnabled), false, true];
} else {
    _patient setVariable [QGVAR(fatigueEnabled), (ACEGVAR(advanced_fatigue,enabled)), true];
};
