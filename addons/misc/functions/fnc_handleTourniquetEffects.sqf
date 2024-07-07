#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle effects for when tourniquet is applied for prolonged time
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_misc_fnc_handleTourniquetEffects;
 *
 * Public: No
 */

params ["_unit"];

if (_unit getVariable [QGVAR(Tourniquet_PFH), -1] != -1 || !(GVAR(tourniquetEffects_Enable))) exitWith {};
_unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];

private _handleLegEffects = {
    params ["_unit", "_threshold"];

    if (_unit getVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0] != _threshold) then {
        _unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), _threshold, true];
        [_unit] call FUNC(updateDamageEffects);
    };
};

private _tourniquetPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_handleLegEffects"];
    
    private _tourniquet_ArmNecrosis = _unit getVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
    private _tourniquet_LegNecrosis = _unit getVariable [QGVAR(Tourniquet_LegNecrosis), 0];

    private _activeTourniquets = GET_TOURNIQUETS(_unit);
    private _armTourniquets = (_activeTourniquets select 2) + (_activeTourniquets select 3);
    private _legTourniquets = (_activeTourniquets select 4) + (_activeTourniquets select 5);
    
    if (_armTourniquets > 1) then {
        _tourniquet_ArmNecrosis = _tourniquet_ArmNecrosis + (0.16 * GVAR(tourniquetEffects_PositiveMultiplier));
        if (_tourniquet_ArmNecrosis >= 100) then {
            _tourniquet_ArmNecrosis = 100;
        };
    } else {
        _tourniquet_ArmNecrosis = _tourniquet_ArmNecrosis - (0.32 * GVAR(tourniquetEffects_NegativeMultiplier));

        if (_tourniquet_ArmNecrosis <= 0) then {
            _tourniquet_ArmNecrosis = 0;
        };
    };

    if (_legTourniquets > 1) then {
        _tourniquet_LegNecrosis = _tourniquet_LegNecrosis + (0.16 * GVAR(tourniquetEffects_PositiveMultiplier));

        if (_tourniquet_LegNecrosis >= 100) then {
            _tourniquet_LegNecrosis = 100;
        };
    } else {
        _tourniquet_LegNecrosis = _tourniquet_LegNecrosis - (0.32 * GVAR(tourniquetEffects_NegativeMultiplier));

        if (_tourniquet_LegNecrosis <= 0) then {
            _tourniquet_LegNecrosis = 0;
        };
    };

    switch (true) do {
        case (_tourniquet_LegNecrosis > 20 && _tourniquet_LegNecrosis < 60): {[_unit, 20] call _handleLegEffects;};
        case (_tourniquet_LegNecrosis > 60 && _tourniquet_LegNecrosis < 90): {[_unit, 60] call _handleLegEffects;};
        case (_tourniquet_LegNecrosis > 90): {[_unit, 90] call _handleLegEffects;};
        default {[_unit, 0] call _handleLegEffects;};
    };

    if ((_tourniquet_ArmNecrosis + _tourniquet_LegNecrosis <= 0 && _armTourniquets + _legTourniquets == 0) || !(alive _unit)) exitWith {
        _unit setVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
        _unit setVariable [QGVAR(Tourniquet_LegNecrosis), 0];
        _unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];
        _unit setVariable [QGVAR(Tourniquet_PFH), -1];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    _unit setVariable [QGVAR(Tourniquet_ArmNecrosis), _tourniquet_ArmNecrosis];
    _unit setVariable [QGVAR(Tourniquet_LegNecrosis), _tourniquet_LegNecrosis];
}, 1, [_unit, _handleLegEffects]] call CBA_fnc_addPerFrameHandler;

_unit setVariable [QGVAR(Tourniquet_PFH), _tourniquetPFH];