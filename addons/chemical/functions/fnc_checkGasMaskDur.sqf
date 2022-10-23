#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_checkGasMaskDur;
 *
 * Public: No
*/

params ["_target","_medic"];


if (_medic isEqualTo _target) then {
    [_medic, "Gear", 1] call ace_common_fnc_doGesture;
};
 
[{_this call FUNC(displayGasMaskDur)}, [_target], 1] call CBA_fnc_waitAndExecute;
