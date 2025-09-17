#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * Enables the SCBA to give free air to the player.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_chemical_enableSCBA
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(SCBAEnabled), true, true];
private _SCBA_maxOxygenTime = missionNamespace getVariable [QGVAR(SCBA_maxOxygenTime), 1800];
private _infectionTime = missionNamespace getVariable [QGVAR(infectionTime), 60];

private _backpack = backpackContainer _unit;
if (isNull (uiNamespace getVariable [QGVAR(SCBA_o2), objNull])) then {
    private _display = findDisplay 46;
    if !(isNull _display) then {
        private _air = _backpack getVariable [QGVAR(SCBA_oxygen), _SCBA_maxOxygenTime];
        private _color = "ffffff";
        if (_air <= 300) then {
            _color = "ffa500";
            if (_air <= 30) then {
                _color = "ff0000";
            };
        };
        private _ctrl = _display ctrlCreate ["RscStructuredText", 856];
        _ctrl ctrlSetPosition [safeZoneX,safeZoneY + (50 * pixelH),256 * pixelW, 256 * pixelH];
        _ctrl ctrlSetBackgroundColor [0,0,0,0];
        _ctrl ctrlSetStructuredText parseText format ["<t color='#%1' align='left' valign='top' size='1.2'>O²</t>", _color];
        _ctrl ctrlSetTextColor [1,1,1,1];
        _ctrl ctrlCommit 0;
        uiNamespace setVariable [QGVAR(SCBA_o2), _ctrl];
    };
};
//set viiblity of hose segments, and filters
if (((backpack _unit == "B_SCBA_01_F") || (backpack _unit == "B_CombinationUnitRespirator_01_F")) && ((goggles _unit == "G_AirPurifyingRespirator_01_F") || (goggles _unit == "G_RegulatorMask_F"))) then {
    [_unit] call BIN_fnc_CBRNHoseInit;
};


[{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_oldBackpack", "_lastTimeUpdated"];
    private _SCBA_maxOxygenTime = missionNamespace getVariable [QGVAR(SCBA_maxOxygenTime), 1800];
    private _backpack = backpackContainer _unit;
    private _curOxygen = _backpack getVariable [QGVAR(SCBA_oxygen), _SCBA_maxOxygenTime];
    if (!alive _unit || !(_unit getVariable [QGVAR(SCBAEnabled), false]) || !(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) || !(backpack _unit in (missionNamespace getVariable [QGVAR(availBackpackList), []])) || (_curOxygen <= 0)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _backpack setVariable [QGVAR(SCBA_oxygen), _curOxygen, true];
        _unit setVariable [QGVAR(SCBAEnabled), false, true];
        ctrlDelete (uiNamespace getVariable [QGVAR(SCBA_o2), ctrlNull]);
    };

    if (_oldBackpack isNotEqualTo _backpack) then {
        [["Connected to new oxygen tank with %1%2 reaming air!", round ((_curOxygen/_SCBA_maxOxygenTime) * 100), "%"], 2, _unit] call ACEFUNC(common,displayTextStructured);
        _oldBackpack setVariable [QGVAR(SCBA_oxygen), (_oldBackpack getVariable [QGVAR(SCBA_oxygen), _SCBA_maxOxygenTime]), true];
        private _color = "ffffff";
        if (_curOxygen <= 300) then {
            _color = "ffa500";
            if (_curOxygen <= 30) then {
                _color = "ff0000";
            };
        };
        (uiNamespace getVariable [QGVAR(SCBA_o2), ctrlNull]) ctrlSetStructuredText parseText format ["<t color='#%1' align='left' valign='top' size='1.2'>O²</t>", _color];
        _args set [1, _backpack];
    };

    private _delta = CBA_missionTime - _lastTimeUpdated;
    private _reserve = (_curOxygen - _delta) max 0;
    _backpack setVariable [QGVAR(SCBA_oxygen), _reserve];

    if (!(_backpack getVariable [QGVAR(SCBA_5min_warning), false]) && {_reserve < 300 && _reserve >= 30 }) then {
        _backpack setVariable [QGVAR(SCBA_5min_warning), true];
        [QGVAR(playTone), [_unit, QGVAR(lowoxwarning_short)], _unit] call CBA_fnc_targetEvent;
        (uiNamespace getVariable [QGVAR(SCBA_o2), ctrlNull]) ctrlSetStructuredText parseText "<t color='#ffa500' align='left' valign='top' size='1.2'>O²</t>";
    };
    if (!(_backpack getVariable [QGVAR(1min_warning), false]) && {_reserve < 30}) then {
        _backpack setVariable [QGVAR(1min_warning), true];
       [QGVAR(playTone), [_unit, QGVAR(lowoxwarning)], _unit] call CBA_fnc_targetEvent;
        (uiNamespace getVariable [QGVAR(SCBA_o2), ctrlNull]) ctrlSetStructuredText parseText "<t color='#ff0000' align='left' valign='top' size='1.2'>O²</t>";
    };

    _args set [2, CBA_missionTime];
}, 1, [_unit, _backpack, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
