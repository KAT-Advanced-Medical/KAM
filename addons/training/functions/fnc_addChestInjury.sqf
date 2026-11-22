#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Gives a patient a chest injury the same way KAM breathing does after a torso hit.
 * Has to run where the patient is local.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Injury ("pneumothorax", "tension", "hemo" or "tamponade") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, "tension"] call kat_training_fnc_addChestInjury
 *
 * Public: No
 */

#define PNEUMOTHORAX_PAIN 0.2
#define ADVANCED_PNEUMOTHORAX_PAIN 0.7
#define PNEUMOTHORAX_INITIAL 1
#define PNEUMOTHORAX_FULL 4

params [["_patient", objNull, [objNull]], ["_injury", "", [""]]];

switch (_injury) do {
    case "pneumothorax": {
        if ((_patient getVariable [QEGVAR(breathing,pneumothorax), 0]) > 0) exitWith {};

        [_patient, PNEUMOTHORAX_PAIN] call ACEFUNC(medical_status,adjustPainLevel);

        _patient setVariable [QEGVAR(breathing,pneumothorax), PNEUMOTHORAX_INITIAL, true];
        _patient setVariable [QEGVAR(breathing,deepPenetratingInjury), true, true];
        _patient setVariable [QEGVAR(breathing,activeChestSeal), false, true];

        [_patient, 0] call EFUNC(breathing,handlePneumothoraxDeterioration);
    };
    case "tension";
    case "hemo": {
        private _isHemo = _injury == "hemo";

        [_patient, ADVANCED_PNEUMOTHORAX_PAIN] call ACEFUNC(medical_status,adjustPainLevel);

        // KAM never gives a patient both at once
        _patient setVariable [QEGVAR(breathing,hemopneumothorax), _isHemo, true];
        _patient setVariable [QEGVAR(breathing,tensionpneumothorax), !_isHemo, true];
        _patient setVariable [QEGVAR(breathing,pneumothorax), PNEUMOTHORAX_FULL, true];
        _patient setVariable [QEGVAR(breathing,deepPenetratingInjury), true, true];
        _patient setVariable [QEGVAR(breathing,activeChestSeal), false, true];

        [_patient] call EFUNC(circulation,updateInternalBleeding);
    };
    case "tamponade": {
        if ((_patient getVariable [QEGVAR(circulation,effusion), 0]) > 0) exitWith {};

        [_patient] call EFUNC(breathing,createTamponade);
    };
};
