#include "..\script_component.hpp"
/*
 * Author: commy2
 * Modified: Blue
 * Handles attaching and setting up a carried object. Called from ace_dragging_fnc_startCarryPFH.
 *
 * Arguments:
 * 0: Unit that should do the carrying <OBJECT>
 * 1: Object to carry <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call ace_dragging_fnc_carryObject;
 *
 * Public: No
 */

params ["_unit", "_target"];
TRACE_2("params",_unit,_target);

// Get attachTo offset and direction
private _position = _target getVariable [QACEGVAR(dragging,carryPosition), [0, 0, 0]];
private _direction = _target getVariable [QACEGVAR(dragging,carryDirection), 0];

// Handle objects vs. persons
if (_target isKindOf "CAManBase") then {
    [_unit, "AcinPercMstpSnonWnonDnon", 2] call ACEFUNC(common,doAnimation);
    [_target, "AinjPfalMstpSnonWnonDf_carried_dead", 2] call ACEFUNC(common,doAnimation);

    // Attach person
    _target attachTo [_unit, _position, "LeftShoulder"];

    if !(IS_UNCONSCIOUS(_target)) then {
        [QGVAR(stopCarryingPrompt), [_target, _unit], _target] call CBA_fnc_targetEvent;
    };
} else {
    // Add height offset of model
    private _offset = ((_target modelToWorldVisual [0, 0, 0]) select 2) - ((_unit modelToWorldVisual [0, 0, 0]) select 2);

    _position = _position vectorAdd [0, 0, _offset];

    // Attach object
    _target attachTo [_unit, _position];
};

[QACEGVAR(common,setDir), [_target, _direction], _target] call CBA_fnc_targetEvent;

_unit setVariable [QACEGVAR(dragging,isCarrying), true, true];
_unit setVariable [QACEGVAR(dragging,carriedObject), _target, true];

// Add drop action
_unit setVariable [QACEGVAR(dragging,releaseActionID), [
    _unit, "DefaultAction",
    {!isNull ((_this select 0) getVariable [QACEGVAR(dragging,carriedObject), objNull])},
    {[_this select 0, (_this select 0) getVariable [QACEGVAR(dragging,carriedObject), objNull], true] call ACEFUNC(dragging,dropObject_carry)}
] call ACEFUNC(common,addActionEventHandler)];

// Add anim changed EH
[_unit, "AnimChanged", ACEFUNC(dragging,handleAnimChanged), [_unit]] call CBA_fnc_addBISEventHandler;

// Check everything
[ACEFUNC(dragging,carryObjectPFH), 0.5, [_unit, _target, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;

// Reset current dragging height
ACEGVAR(dragging,currentHeightChange) = 0;

// Prevent UAVs from firing
private _UAVCrew = _target call ACEFUNC(common,getVehicleUAVCrew);

if (_UAVCrew isNotEqualTo []) then {
    {
        _target deleteVehicleCrew _x;
    } forEach _UAVCrew;

    _target setVariable [QACEGVAR(dragging,isUAV), true, true];
};
