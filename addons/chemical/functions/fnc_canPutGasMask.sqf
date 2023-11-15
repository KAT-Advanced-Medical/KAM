#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_canPutGasMask;
 *
 * Public: No
*/

params ["_medic", "_patient"];

if(missionNamespace getVariable [QGVAR(availGasmaskList), []] isEqualTo []) exitWith {false};

!(_patient call ACE_common_fnc_isAwake) && ([_medic,_patient] call FUNC(hasGasmask)) && !((goggles _patient) in (missionNamespace getVariable [QGVAR(availGasmaskList), []]))
