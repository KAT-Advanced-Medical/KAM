#include "..\script_component.hpp"
/*
 * Author: DiGii
 * CS / tear gas effect. Lifted from the original fnc_poison.sqf:40-45 branch.
 * Sets the CSGas deadline and rolls for the random weapon-drop.
 *
 * Runs local to the unit's owner via QGVAR(poison) target event.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Infected source <OBJECT>
 * 2: Gas data <HASHMAP>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_infectedObject", "_gasData"];

_unit setVariable [QGVAR(CSGas), CBA_missionTime + GVAR(csDuration), true];

if (random 1 <= GVAR(tearGasDropChance)) then {
    [QACEGVAR(hitreactions,dropWeapon), _unit, _unit] call CBA_fnc_targetEvent;
};
