#include "script_component.hpp"
/*
 * Author: commy2
 * Carry an object.
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

// get attachTo offset and direction.

private _position = _target getVariable [QACEGVAR(dragging,carryPosition), [0, 0, 0]];
private _direction = _target getVariable [QACEGVAR(dragging,carryDirection), 0];

// handle objects vs persons
if (_target isKindOf "CAManBase") then {

    [_unit, "AcinPercMstpSnonWnonDnon", 2] call ACEFUNC(common,doAnimation);
    [_target, "AinjPfalMstpSnonWnonDf_carried_dead", 2] call ACEFUNC(common,doAnimation);

    // attach person
    _target attachTo [_unit, _position, "LeftShoulder"];

    if !(IS_UNCONSCIOUS(_target)) then {
        [QGVAR(stopCarryingPrompt), [_target, _unit], _target] call CBA_fnc_targetEvent;
    };
} else {

    // add height offset of model
    private _offset = (_target modelToWorldVisual [0, 0, 0] select 2) - (_unit modelToWorldVisual [0, 0, 0] select 2);

    _position = _position vectorAdd [0, 0, _offset];

    // attach object
    _target attachTo [_unit, _position];
};
[QACEGVAR(common,setDir), [_target, _direction], _target] call CBA_fnc_targetEvent;

_unit setVariable [QACEGVAR(dragging,isCarrying), true, true];
_unit setVariable [QACEGVAR(dragging,carriedObject), _target, true];

// add drop action
_unit setVariable [QACEGVAR(dragging,ReleaseActionID), [
    _unit, "DefaultAction",
    {!isNull ((_this select 0) getVariable [QACEGVAR(dragging,carriedObject), objNull])},
    {[_this select 0, (_this select 0) getVariable [QACEGVAR(dragging,carriedObject), objNull]] call ACEFUNC(dragging,dropObject_carry)}
] call ACEFUNC(common,addActionEventHandler)];

// add anim changed EH
[_unit, "AnimChanged", ACEFUNC(dragging,handleAnimChanged), [_unit]] call CBA_fnc_addBISEventHandler;

// show mouse hint
if (_target isKindOf "CAManBase") then {
    [localize ACELSTRING(dragging,Drop), "", ""] call ACEFUNC(interaction,showMouseHint);
} else {
    [localize ACELSTRING(dragging,Drop), "", localize ACELSTRING(dragging,RaiseLowerRotate)] call ACEFUNC(interaction,showMouseHint);
};

// check everything
[ACEFUNC(dragging,carryObjectPFH), 0.5, [_unit, _target, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;

// reset current dragging height.
ACEGVAR(dragging,currentHeightChange) = 0;

// prevent UAVs from firing
private _UAVCrew = _target call ACEFUNC(common,getVehicleUAVCrew);

if (_UAVCrew isNotEqualTo []) then {
    {_target deleteVehicleCrew _x} count _UAVCrew;
    _target setVariable [QACEGVAR(dragging,isUAV), true, true];
};
