#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Checks whether a unit has full CBRN protection (gas mask AND a uniform on
 * the configured CBRN whitelist).
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player] call kat_chemical_fnc_hasCBRNProtection;
 *
 * Public: No
 */

params ["_target"];

if !([_target] call FUNC(hasGasMaskON)) exitWith {false};

private _list = missionNamespace getVariable [QGVAR(availCBRNUniformList), []];
if (_list isEqualTo []) exitWith {false};

uniform _target in _list
