/*
 * Author: Katalam
 * Handles remove clothes function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_treatmentAdvanced_clothes;
 *
 * Public: No
 */

params ["_player", "_target"];

_objects = nearestObjects [_target, ["Helicopter", "Plane", "Tank", "Car", "ReammoBox_F"], 15, true];
_object_1 = _objects select 0;
_object_2 = _objects select 1;

//_weight = loadUniform _target; // weight from the uniform

_items = uniformItems _target;
{
  if (_object canAdd _x) then {
    _object_1 addItemCargoGlobal [_x, 1];
  } else {
    _object_2 addItemCargoGlobal [_x, 1];
  };
} forEach _items;
// performance is a problem, a uniform container don't contain many items in most cases. If i check it for each item it will be freaking bad and not a good coding.
// solution is to get the weight of all and then check the vehicle cargo. Maybe it works but there is no function for that.
// maybe in his vest

if (local _target) then {
  ["treatmentClothes", [_player, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentClothes", [_player, _target], _target] call CBA_fnc_targetEvent;
};
