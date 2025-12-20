#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle pneumothorax deterioration
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Deterioration chance increase <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 15] call kat_breathing_fnc_handleHemothoraxDeterioration;
 *
 * Public: No
 */

params ["_unit", "_side", ["_amount", 3]];
private _fnc_createInternalBleeding = {
    private _openWounds = GET_OPEN_WOUNDS(_unit);
    private _existingWounds = _openWounds getOrDefault ["chest", [], true];
    private _bodyPartDamage = GET_BODYPART_DAMAGE(_unit);
    private _woundTypeToAdd = "InternalBleeding";
    TRACE_4("create_Evisceration1",_openWounds,_existingWounds,_bodyPartDamage,_woundTypeToAdd);
    private _woundClassIDToAdd = ACEGVAR(medical_damage,woundClassNames) find _woundTypeToAdd;
    private _injuryBleedingRate = random [0.005, 0.01, 0.02];
    private _bleedMultiplier = random [0.8, 1, 1.2];
    private _woundSize = selectRandom [0, 0, 0, 1, 1, 2];
    private _bleeding = _woundSize * _bleedMultiplier * _injuryBleedingRate;
    private _classComplex = 10 * _woundClassIDToAdd + _woundSize;
    // Create a new injury. Format [0:classComplex, 1:amountOf, 2:bleedingRate, 3:woundDamage]
    private _injury = [_classComplex, 1, _bleeding, 1];
    TRACE_1("adding new wound",_injury);
    _existingWounds pushBack _injury;
    _unit setVariable [VAR_OPEN_WOUNDS, _openWounds, true];
    _unit setVariable [VAR_BODYPART_DAMAGE, _bodyPartDamage, true];
    [_unit] call ACEFUNC(medical_status,updateWoundBloodLoss);
};

for "_i" from 0 to _amount do {
    [_unit] call _fnc_createInternalBleeding;
 };


if (((_unit getVariable [QGVAR(chestTube), [0, 0]] select 0) > 0.9) && ((_unit getVariable [QGVAR(chestTube), [0, 0]] select 1) > 0.9)) then {
    [_unit, _side] call FUNC(handleHemothoraxTreatment);
};
[{
    params ["_unit", "_side"];
    [{

        params ["_args", "_idPFH"];
        _args params ["_unit", "_side"];
        private _hemoState = _unit getVariable [QGVAR(hemopneumothorax), [0, 0]];
            if (!(alive _unit) ||
                ((INTERNAL_BLEEDING_RATE(_unit,2) == 0))) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            private _internalBleeding = (INTERNAL_BLEEDING_RATE(_unit,2) / 10);
            _hemoState set [_side, (((_hemoState select _side) + (_internalBleeding)) min 1)];
            if (((random 100) < (linearConversion [0, 1, (_hemoState select _side), 5, 75, true])) && GVAR(PneumothoraxArrest)) then {
                private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
                if !("hemo" in _ht) then {
                    _ht pushBack "hemo";
                    _unit setVariable [QEGVAR(circulation,ht), _ht, true];
                    if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                        [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                    };
                };
            };
            _unit setVariable [QGVAR(hemopneumothorax), _hemoState, true];
        }, (3 * random [0.8, 1, 1.2]), [_unit, _side]] call CBA_fnc_addPerFrameHandler;
}, [_unit, _side], (3 * random [0.8, 1, 1.2]) ] call CBA_fnc_waitAndExecute;