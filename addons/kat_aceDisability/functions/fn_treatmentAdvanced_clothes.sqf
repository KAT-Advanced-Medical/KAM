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

_a = getMagazineCargo uniformContainer _target; // gets uniform cargo
_d = getItemCargo uniformContainer _target; // different between items and magazines

_a params ["_itemsMagazine", "_countsMagazine"];
_d params ["_itemsItem", "_countsItem"];

_items = _itemsMagazine + _itemsItem; // adds both arrays
_counts = _countsMagazine + _countsItem;

_groundHolder = createVehicle ["WeaponHolderSimulated", _target, [], 0.5, "CAN_COLLIDE"];

{
  _b = _items select _forEachIndex;
  _c = _counts select _forEachIndex;
  _groundHolder addItemCargoGlobal [_b, _c];
} forEach _items;

_target setVariable ["kat_aceDisability_checked", true];

if (local _target) then {
  ["treatmentClothes", [_player, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentClothes", [_player, _target], _target] call CBA_fnc_targetEvent;
};
