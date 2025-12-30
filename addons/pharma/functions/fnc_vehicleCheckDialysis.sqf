#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Allows for dialysis to occur around medical vehicles
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_pharma_fnc_vehicleCheckDialysis
 *
 * Public: No
 */

params ["_medic", "_patient"];
private _isRunning = _patient getVariable [QGVAR(dialysisRunning), false];
if (!(_isRunning) &&
    ((_patient nearEntities 10) findIf {
        _x getVariable [QACEGVAR(medical,isMedicalVehicle), false]
    } > -1)
) exitWith {true };
if (!(_isRunning) && (_patient call ACEFUNC(medical_treatment,isInMedicalFacility))) exitWith { true };
if (!(_isRunning) && (_patient call ACEFUNC(medical_treatment,isInMedicalVehicle))) exitWith { true };
false