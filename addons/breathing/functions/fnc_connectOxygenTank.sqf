#include "script_component.hpp"
/*
 * Author: Blue
 * Sets if non-portable oxygen tank is connected to patient BVM
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Is connected <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, true] call kat_breathing_fnc_connectOxygenTank;
 *
 * Public: No
 */

params ["_patient","_connect"];

if(_connect) then { 
    if (_patient getVariable [QGVAR(portableOxygenTankConnected), false]) then {
        _patient setVariable [QGVAR(portableOxygenTankConnected), false, true];
        _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
    };
    [{
        params ["_patient"];
        !(_patient call ACEFUNC(medical_treatment,isInMedicalFacility) || _patient call ACEFUNC(medical_treatment,isInMedicalVehicle));
    }, {
        params ["_patient"];
        if !(_patient getVariable [QGVAR(oxygenTankConnected), false]) exitWith {};
        _patient setVariable [QGVAR(oxygenTankConnected), false, true];
    }, [_patient], 3600, {
        params ["_patient"];
        if !(_patient getVariable [QGVAR(oxygenTankConnected), false]) exitWith {};
        _patient setVariable [QGVAR(oxygenTankConnected), false, true];
    }] call CBA_fnc_waitUntilAndExecute;
};

_patient setVariable [QGVAR(oxygenTankConnected), _connect, true];