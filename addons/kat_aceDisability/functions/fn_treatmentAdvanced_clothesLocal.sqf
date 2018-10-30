/*
 * Author: Katalam
 * Remove clothes function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_treatmentAdvanced_clothesLocal;
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

_message = "STR_kat_aceDisability_Action_Message_1_nothing";
if (_target getVariable ["kat_aceDisability_allergicalreaction", false]) then {
  _message = "STR_kat_aceDisability_Action_Message_1_bee";
};
[_target, "quick_view", localize "STR_kat_aceDisability_cut_log", [[_player] call ace_common_fnc_getName, localize _message]] call ace_medical_fnc_addToLog;

_string = "STR_kat_aceDisability_Action_Message_1_nothing";
if (_target getVariable "kat_aceDisability_allergicalreaction") then {
  _string = "STR_kat_aceDisability_Action_Message_1_bee";
};
_message = format [localize "STR_kat_aceDisability_Action_Message", localize _string];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;

if !(uniform _target isEqualTo "") then {
  removeUniform _target;
};
