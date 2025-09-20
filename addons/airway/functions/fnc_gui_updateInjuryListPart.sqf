#include "..\script_component.hpp"
/*
 * Author: AtrixZockt
 * Updates injury list for given body part for the target.
 *
 * Arguments:
 * 0: Injury list <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part, -1 to only show overall health info <NUMBER>
 * 3: Entries <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlInjuries, _target, 0] call kat_airway_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];

if (_target getVariable [QGVAR(overstretch), false] && _selectionN isEqualTo 0) then {
    _entries pushBack [LLSTRING(Hyperextended), [0.1, 1, 1, 1]];
};

if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 0) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if !(_a in ["", "Surgical_Airway"]) then {
        private _text = format [LSTRING(%1_Display), _a];
        _entries pushBack [localize _text, [0.1, 1, 1, 1]];
    };
};

if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 1) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if (_a in ["Surgical_Airway"]) then {
        private _text = format [LSTRING(%1_Display), _a];
        _entries pushBack [localize _text, [0.1, 1, 1, 1]];
    };
};
private _airways = ["Larynxtubus", "IGEL", "ETT"];
private _monitor  = _target getVariable [QEGVAR(breathing,etco2Monitor), []];
private _hasCapno = (_airways findIf { _x in _monitor }) != -1;
if (_hasCapno && _selectionN isEqualTo 0 && GVAR(capnographEnable)) then {
    private _entry = _target getVariable [QGVAR(capnoStatus), ""];
    private _color = _target getVariable [QGVAR(capnoColor), [1,1,1,1]];
    _entries pushBack [_entry, _color];
};
    

if (((_target getVariable [QGVAR(catastrophicAirway), [false, false]] select 1) || (_target getVariable [QGVAR(catastrophicAirway), [false, false]] select 1)) && (_selectionN isEqualTo 0)) then {
    private _text = LSTRING(Catastrophic_Display);
    _entries pushBack [localize _text, [0.1, 1, 1, 1]];
};
if ((((_target getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x != 0 }) != -1) && (_selectionN isEqualTo 0) && (_target getVariable [QGVAR(hasPuked), false])) then{
    private _text = LSTRING(BloodVomitAirway_Display);
    _entries pushBack [localize _text, [0.1, 1, 1, 1]];
} else {
    if ((((_target getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x != 0 }) != -1) && (_selectionN isEqualTo 0)) then {
    private _text = LSTRING(BloodAirway_Display);
    _entries pushBack [localize _text, [0.1, 1, 1, 1]];
    };
};
if ((((_target getVariable [QGVAR(obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1) && (_selectionN isEqualTo 0)) then{
    private _text = LSTRING(TraumaticObstruction_Display);
    _entries pushBack [localize _text, [0.1, 1, 1, 1]];
};
if (_target getVariable [QGVAR(hasExternallyPuked), true]) then{
    private _text = LSTRING(HasExternallyPuked);
    _entries pushBack [localize _text, [0.1, 1, 1, 1]];
};

if ((_target getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false] || _target getVariable [QGVAR(DefibrillatorPads_Connected), false]) && !(GVAR(hardcoreAED))) then {
    private _entry = _target getVariable [QGVAR(AED_X_VitalsStatus), ""];
    if (_target getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
        _entries pushBack [_entry, [1, 0, 0, 1]];
    } else {
        _entries pushBack [_entry, [1, 1, 1, 1]];
    };   
};



