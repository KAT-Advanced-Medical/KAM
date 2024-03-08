#include "..\script_component.hpp"
/*
 * Author: commy2
 * Modified: Blue
 * Handles consciousness change of a unit while dragging / carrying.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_dragging_fnc_handleUnconscious;
 *
 * Public: No
*/

params ["_unit"];

private _player = ACE_player;

if (_player getVariable [QACEGVAR(dragging,isDragging), false]) then {
    private _draggedObject = _player getVariable [QACEGVAR(dragging,draggedObject), objNull];

    // Handle falling unconscious
    if (_unit == _player) then {
        [_unit, _draggedObject] call ACEFUNC(dragging,dropObject);
    };

    // Handle waking up dragged unit
    if (_unit == _draggedObject) then {
        [_player, _draggedObject] call ACEFUNC(dragging,dropObject);
    };
};

if (_player getVariable [QACEGVAR(dragging,isCarrying), false]) then {
    private _carriedObject = _player getVariable [QACEGVAR(dragging,carriedObject), objNull];

    // Handle falling unconscious
    if (_unit == _player) then {
        [_unit, _carriedObject] call ACEFUNC(dragging,dropObject_carry);
    };

    // Handle waking up dragged unit
    if (_unit == _carriedObject) then {
        [QACEGVAR(common,switchMove), [_unit, "AinjPfalMstpSnonWnonDf_carried_dead"]] call CBA_fnc_globalEvent; // Force carried animation to avoid sliding
        [QGVAR(stopCarryingPrompt), [_carriedObject, _player], _carriedObject] call CBA_fnc_targetEvent;
    };
};
