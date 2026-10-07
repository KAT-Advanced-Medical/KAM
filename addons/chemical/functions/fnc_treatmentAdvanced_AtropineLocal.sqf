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

if !(LUNG_MODEL_ACTIVE) exitWith {
    _patient setVariable [QGVAR(airPoisoning), false, true];
};

// Atropine relieves bronchospasm and dries secretions, so the casualty stops deteriorating but it cannot reverse alveolar damage already done. Stopping the progression is literally
// what halting means; dexamethasone is still needed to clear what is already there.
_patient setVariable [QEGVAR(breathing,lungInjuryProgression), 0, true];

private _current = _patient getVariable [QEGVAR(breathing,lungInjury), 0];

if (_current > 0) then {
    _patient setVariable [QEGVAR(breathing,lungInjuryTarget), _current, true];
};

// Stop further dose accumulating into a fresh target while the drug is working.
_patient setVariable [QGVAR(lungDose), 0, true];
