#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Removes blood gas testing values
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_dumpBloodGas;
 *
 * Public: No
 */

params ["_target"];

 _target setVariable [QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0], true];