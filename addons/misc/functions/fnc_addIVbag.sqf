#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Adds a IV bag for the medicine IV stands.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, player] call kat_misc_fnc_addIVbag;
 *
 * Public: No
 */

params ["_target", "_player", "_newML"];

[3, [_target, _player, _newML],
    {
        params ["_args"];
        _args params ["_target", "_player", "_newML"];

        // get some paramaters
        private _className = typeOf _target;
        private _value = [];

        // exit if _target isn't a valid IV stand
        if !([_className, 0, 17] call BIS_fnc_trimString isEqualTo "Land_IntravenStand") exitWith {};

        // get some parameters
        private _newObjectClass = "";
        if (_className isEqualTo "Land_IntravenStand_01_empty_F") then {
            _newObjectClass = "Land_IntravenStand_01_1bag_F";
        } else {
            _newObjectClass = "Land_IntravenStand_01_2bags_F";
            _value = _target getVariable [QGVAR(stand), []];
        };

        // creates new object at [0,0,0]
        private _newObject = createVehicle [_newObjectClass, [0,0,0], [], 0, "CAN_COLLIDE"];

        _value pushBack _newML;
        _newObject setVariable [QGVAR(stand), _value, true];

        // replace the old with the new object
        private _oldPos = getPos _target;
        private _oldDir = getDir _target;
        _target setPos [1,1,1];
        _newObject setPos _oldPos;
        _newObject setDir _oldDir;
        deleteVehicle _target;

        private "_classNameItem";
        switch (_newML) do {
            case 1000: {
                _classNameItem = "ACE_salineIV";
            };
            case 500: {
                _classNameItem = "ACE_salineIV_500";
            };
            case 250: {
                _classNameItem = "ACE_salineIV_250";
            };
        };

        // use item
        [_player, _player, [_classNameItem]] call ACEFUNC(medical_treatment,useItem);
    }, {}, LLSTRING(Action_add_IV)] call ACEFUNC(common,progressBar);
