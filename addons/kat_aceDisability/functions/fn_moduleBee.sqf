/*
 * Author: Katalam
 * Module Handler for bee creating
 *
 * Arguments:
 * Logic <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_moduleBee;
 *
 * Public: No
 */

params ["_logic"];

if !(local _logic) exitWith {};

private _unit = attachedTo _logic;

if (isPlayer _unit && alive _unit) then {
	/*
	* Arguments:
  * 0: Spawn position <OBJECT, STRING, POSITION>
  * 1: Radius <NUMBER>
  * 2: Number of animals <NUMBER>
  * 3: Spawn height <NUMBER>
  * 4: Animal Classname <STRING>, optional
	*/
	// TO-DO here
	[_unit, 2, 25, 45, "HoneyBee"] call kat_aceDisability_fnc_createBee;
} else {
	[objNull, "Place on player"] call bis_fnc_showCuratorFeedbackMessage;
};

deleteVehicle _logic;
