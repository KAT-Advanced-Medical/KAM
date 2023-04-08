#include "script_component.hpp"
/*
 * Author: Blue
 * Sets if portable oxygen tank is connected to patient BVM
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Is connected <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, true] call kat_breathing_fnc_connectPortableOxygenTank;
 *
 * Public: No
 */

params ["_medic","_patient","_connect"];

if(_connect && _patient getVariable [QGVAR(oxygenTankConnected), false]) then {
    _patient setVariable [QGVAR(oxygenTankConnected), false, true];
};

_patient setVariable [QGVAR(portableOxygenTankConnected), _connect, true];
if(_connect) then {
    _patient setVariable [QGVAR(oxygenTankProvider), _medic, true];
    [{
        params ["_medic", "_patient"];
        (_patient distance _medic) > 8;
    }, {
        params ["_medic", "_patient"];
        if !(_patient getVariable [QGVAR(portableOxygenTankConnected), false]) exitWith {};
        _patient setVariable [QGVAR(portableOxygenTankConnected), false, true];
        _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
        ["Oxygen Tank Disconnected", 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    }, [_medic, _patient], 3600, {
        params ["_medic", "_patient"];
        if !(_patient getVariable [QGVAR(portableOxygenTankConnected), false]) exitWith {};
        _patient setVariable [QGVAR(portableOxygenTankConnected), false, true];
        _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
        ["Oxygen Tank Disconnected", 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    }] call CBA_fnc_waitUntilAndExecute;
} else {
    _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
};