#include "script_component.hpp"
/*
 * Author: Kygan
 * Re-adds the AED X to the player's inventory
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_circulation_fnc_returnAED_X;
 *
 * Public: No
 */

params ["_player", "_patient", "_AEDreturn"];
private _output = localize LSTRING(X_Action_Remove);

_patient setVariable [QGVAR(X), false, true];

private _bloodLoss = _patient getVariable ["ace_medical_bloodVolume", 6.0];
private _asystole = _patient getVariable [QGVAR(asystole), 1];

if !(GVAR(AdvRhythm)) then {
    _patient setVariable [QGVAR(asystole), 1, true];
    _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
    if (_bloodLoss > 3.6) then {
        _patient setVariable [QGVAR(asystole), 1, true];
        _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
        _patient setVariable [QGVAR(asystole), 2, true];
        _asystole = _patient getVariable [QGVAR(asystole), 2];
    };
};

if ((_patient getVariable ["ace_medical_heartRate", 0] >= 40) && GVAR(AdvRhythm)) then {
    _patient setVariable [QGVAR(asystole), 1, true];
};

if (_AEDreturn) then {
    _player setVariable [QGVAR(use), false, true];
    [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
    [_player, "kat_X_AED"] call ace_common_fnc_addToInventory;
    _player setVariable [QGVAR(returnedAED), true, true];
} else {
    _patient setVariable [QGVAR(AEDvehicle), "", true];
    _patient setVariable [QGVAR(vehicleTrue), false, true];
};

true;