#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_misc_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

// Remove the tourniquet effects PFH if it is still running
private _pfh = _patient getVariable [QGVAR(Tourniquet_PFH), -1];
if (_pfh != -1) then {
    [_pfh] call CBA_fnc_removePerFrameHandler;
};

// Reset tourniquet necrosis so the sway multiplier and leg effects are cleared
_patient setVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
_patient setVariable [QGVAR(Tourniquet_LegNecrosis), 0];
_patient setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];
_patient setVariable [QGVAR(Tourniquet_PFH), -1];

[_patient] call FUNC(updateDamageEffects);
