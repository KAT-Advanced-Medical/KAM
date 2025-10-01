#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * handels airway degredation
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *    0: Engine damage <NUMBER>
 *    1: Body part <STRING>
 *    2: Real damage <NUMBER>
 * 2: Damage type (unused) <STRING>
 * 3: Ammo (unused) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Body", 2], "bullet", "B_556x45_Ball"] call kat_hitpoints_fnc_woundsHandlerPelvicHit
 *
 * Public: No
 */

params ["_unit"];
private _airwayStatus = _unit getVariable [QGVAR(airwayStatus), [0, 0, 0]];
private _occlusionArray   = +(_unit getVariable [QGVAR(occlusion), [0, 0, 0]]);
private _obstructionArray = +(_unit getVariable [QGVAR(obstruction), [0, 0, 0]]);
private _catastrophicState = _unit getVariable [QGVAR(catastrophicAirway), [false, false]];
private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));
for "_i" from 0 to 2 do {
    if ((_airwayStatus select _i) > 0) then {
        _obstructionArray set [_i, 0];
    };
    if ((_airwayStatus select _i) > 1) then {
        _occlusionArray set [_i, 0];
    };
};
if ((_unit getVariable [QEGVAR(airway,airway_item), ""]) isEqualTo "NPA") then {
    _occlusionArray = _occlusionArray select [1,2];
    _obstructionArray = _obstructionArray select [1,2];
    _hasCatastrophicAirway = _catastrophicState select 1;
};
private _occlusion = (_occlusionArray findIf { _x > 4 }) != -1;
private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;
private _airway = true;
private _airwayItem = _unit getVariable [QEGVAR(airway,airway_item), ""];
private _noETT = (_airwayItem isNotEqualTo "ETT");
private _noSurgicalAirway = (_airwayItem isNotEqualTo "Surgical_Airway");
private _noOverstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
private _noRecovery = _unit getVariable [QEGVAR(airway,recovery), false];
if ((_obstruction && !_noOverstretch && !_noRecovery) && _noSurgicalAirway && _noETT) then {
    _airway = false;
};
if ((_occlusion && _noETT) && _noSurgicalAirway) then {
    _airway = false;
};
if (_hasCatastrophicAirway && _noSurgicalAirway) then {
    _airway = false;
};
_airway