#include "..\script_component.hpp"
/*
 * Author: DiGii, MiszczuZPolski
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Intensity <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_gasDetector;
 *
 * Public: No
*/
params ["_unit", "_intensity"];

"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
private _ui = GETUVAR(RscWeaponChemicalDetector,displayNull);
private _obj = _ui displayCtrl 101;

_obj ctrlAnimateModel ["Threat_Level_Source", _intensity, true];

private _lastSoundTime = _unit getVariable QGVAR(lastSoundTime);

if (isNil "_lastSoundTime") then {
    TRACE_1("undefined lastSoundTime: setting to current time",_lastSoundTime);
    _unit setVariable [QGVAR(lastSoundTime), CBA_missionTime];
};

if (CBA_missionTime - _lastSoundTime > 6) exitWith {
    systemchat "Playing sound";
    playSound3D [QPATHTOF(audio\chemDetector.ogg), _unit, false, getPosASL _unit, 4, 1, 10];
    _unit setVariable [QGVAR(lastSoundTime), CBA_missionTime];
};
