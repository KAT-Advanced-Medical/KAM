/*
 * Author: Katalam
 * Module Handler for allergical reaction.
 *
 * Arguments:
 * Logic <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call kat_aceDisability_fnc_moduleAllergical;
 *
 * Public: No
 */

params ["_logic"];

if !(local _logic) exitWith {};

private _unit = attachedTo _logic;

if (isPlayer _unit && alive _unit) then {
    [_unit, "HoneyBee", true] call kat_aceDisability_fnc_allergicalReaction;
} else {
    [objNull, "Place on player"] call bis_fnc_showCuratorFeedbackMessage;
};

deleteVehicle _logic;
