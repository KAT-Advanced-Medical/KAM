#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Players googles (BOOL)
 *
 * Example:
 * [player] call kat_chemical_fnc_hasGasMaskOn;
 *
 * Public: No
 */

params ["_target"];

if(missionNamespace getVariable [QGVAR(availGasmaskList), []] isEqualTo []) exitWith {false};

goggles _target in (missionNamespace getVariable [QGVAR(availGasmaskList), []]);
