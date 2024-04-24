#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Medic <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, cursorObject] call kat_chemical_fnc_checkGasMaskDur;
 *
 * Public: No
*/

params ["_patient","_medic"];

if (_medic isEqualTo _patient) then {
    [_medic, "Gear", 1] call ACEFUNC(common,doGesture);
};

[{_this call FUNC(displayGasMaskDur)}, [_patient], 1] call CBA_fnc_waitAndExecute;
