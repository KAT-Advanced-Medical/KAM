#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Radiation analogue of fnc_gasManagerPFH. Walks the registered radiation
 * sources, removes any whose anchor or condition is gone, and for every unit
 * in range computes the per-type incident dose-rate (by geometry) and fires
 * the QGVAR(irradiate) target event on the unit's owner.
 *
 * Owns the geiger reading: radDoseRate (total incident, summed across sources)
 * and radDominantType, reset to 0/"" for units no longer in any field.
 *
 * Source tuple: [_logic, _radius, _strengths(=[a,b,g,n]), _falloff, _condition, _conditionArgs]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * kat_chemical_fnc_radManagerPFH call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

private _exposedNow = [];
private _accum = createHashMap;
private _types = RAD_TYPES;

{
    _y params ["_radLogic", "_radius", "_strengths", ["_falloff", "linear"], ["_condition", {true}], ["_conditionArgs", []]];

    if (isNull _radLogic) then {
        GVAR(radSources) deleteAt _x;
        continue;
    };

    if !(_conditionArgs call _condition) then {
        TRACE_2("rad condition no longer valid, deleting",_x,_y);
        detach _radLogic;
        deleteVehicle _radLogic;
        GVAR(radSources) deleteAt _x;
        continue;
    };

    {
        private _unit = _x;
        private _distance = (_unit distance _radLogic) min _radius;

        private _falloffFactor = switch (_falloff) do {
            case "inverseSquare": {
                private _d = _distance max 1;
                1 / (_d * _d)
            };
            default {
                1 - (_distance / _radius)
            };
        };

        if (_falloffFactor <= 0) then { continue };

        private _ratesByType = _strengths apply { _x * _falloffFactor };
        private _total = 0;
        { _total = _total + _x } forEach _ratesByType;
        if (_total <= 0) then { continue };

        _exposedNow pushBackUnique _unit;

        private _nid = netId _unit;
        private _entry = _accum getOrDefault [_nid, [_unit, 0, "", -1]];
        _entry set [1, (_entry select 1) + _total];

        private _maxRate = selectMax _ratesByType;
        if (_maxRate > (_entry select 3)) then {
            _entry set [2, _types select (_ratesByType find _maxRate)];
            _entry set [3, _maxRate];
        };
        _accum set [_nid, _entry];

        [QGVAR(irradiate), [_unit, _ratesByType, _radLogic], _unit] call CBA_fnc_targetEvent;
    } forEach nearestObjects [_radLogic, ["CAManBase"], _radius];
} forEach GVAR(radSources);

{
    _y params ["_unit", "_rate", "_domType"];
    if (isNull _unit) then { continue };
    _unit setVariable [QGVAR(radDoseRate), _rate, true];
    _unit setVariable [QGVAR(radDominantType), _domType, true];
} forEach _accum;

{
    if (!isNull _x && {!(_x in _exposedNow)}) then {
        _x setVariable [QGVAR(radDoseRate), 0, true];
        _x setVariable [QGVAR(radDominantType), "", true];
    };
} forEach GVAR(radExposedUnits);

GVAR(radExposedUnits) = _exposedNow;
