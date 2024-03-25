#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

_unit setVariable ["kat_AEDXPatient_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_HR_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_PulseOx_PFH", nil, true];
_unit setVariable [QGVAR(Defibrillator_Charged), false, true];
_unit setVariable [QGVAR(DefibrillatorPads_Connected), false, true];
_unit setVariable [QGVAR(AED_X_MedicVitalsMonitor_Connected), false, true];
_unit setVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), nil, true];
_unit setVariable [QGVAR(AED_X_VitalsMonitor_Connected), false, true];
_unit setVariable [QGVAR(AED_X_VitalsMonitor_Provider), nil, true];
_unit setVariable [QGVAR(AED_X_VitalsMonitor_Volume), false, true];
_unit setVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false, true];
_unit setVariable [QGVAR(Defibrillator_Provider), nil, true];
_unit setVariable [QGVAR(Defibrillator_ShockAmount), 0, true];
_unit setVariable [QGVAR(DefibrillatorInUse), false, true];
_unit setVariable [QGVAR(MedicDefibrillatorInUse), false, true];
_unit setVariable [QGVAR(MedicDefibrillator_Patient), nil, true];
_unit setVariable [QGVAR(bloodtype), [_unit, _dead, true] call FUNC(generateBloodType), true];
_unit setVariable [QGVAR(internalBleeding), 0, true];
_unit setVariable [QGVAR(StoredBloodPressure), [0,0], true];

[_unit] call FUNC(fullHealLocal);
