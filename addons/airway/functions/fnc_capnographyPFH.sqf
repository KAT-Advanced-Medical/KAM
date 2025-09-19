#include "..\script_component.hpp"
/*
 * Author: Katalam, edited by MiszczuZPolski, Miss Heda & apo_tle
 * Airway Management for collapsing local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 * 3: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus", "kat_larynx"] call kat_airway_fnc_treatmentAdvanced_airwayLocal;
 *
 * Public: No
 */
params ["_unit"];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    
    private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
    private _alive = alive _unit;
    private _airways = ["Larynxtubus", "IGEL", "ETT"];
    private _monitor  = _unit getVariable [QEGVAR(breathing,etco2Monitor), []];
    private _hasCapno = (_airways findIf { _x in _monitor }) != -1;
    private _color = LLSTRING(capnographyGreen);
    private _rgb = [0,1,1,1];
    if !(_alive || _isUnconscious || _hasCapno) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _etco2 = GET_ETCO2(_unit);
    private _airway = HAS_AIRWAY(_unit);
    if !(_airway) then {
        _etco2 = 0;
    };
    switch (true) do {
    case (_etco2 == 0): {
        _color = LLSTRING(capnographyWhite);
        _rgb = [1,1,1,1];
    };
    case (_etco2 > 40): {
        _color = LLSTRING(capnographyYellow);
        _rgb = [1,1,0,1];
    };
    case (_etco2 > 50): {
        _color = LLSTRING(capnographyOrange);
        _rgb = [1,0.647,0,1];
    };
    case (_etco2 > 60): {
        _color = LLSTRING(capnographyRed);
        _rgb = [1,0,0,1];
    };
    default {
        _color = LLSTRING(capnographyGreen);
        _rgb = [0,1,0,1];
    };
    };
    private _entry = format [LLSTRING(capnographyStatus), _color];
    _unit setVariable [QGVAR(capnoStatus), _entry, true];
    _unit setVariable [QGVAR(capnoColor), _rgb, true];
    private _breathrate = GET_BREATHING_RATE(_patient);
    private _delay = 60/_breathrate;
    [_idPFH, _delay] call CBA_fnc_setPerFrameHandlerDelay;
}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;

