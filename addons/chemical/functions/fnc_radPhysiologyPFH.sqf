#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Owner-local per-unit radiation-physiology tick. Drives the dose-dependent
 * sub-syndromes by current sickness tier (hematopoietic anemia, GI dehydration
 * and acidosis, neurovascular hypotension and seizures, systemic fever and the
 * visual feedback) and handles slow spontaneous recovery below the lethal tier.
 *
 * Each layer is gated on its host KAT subsystem's enable setting so radiation
 * never depends on a disabled system; the cross-addon read hooks default to a
 * no-op value, so this is inert when the layer is off.
 *
 * Arguments:
 * 0: [_unit] <ARRAY>
 * 1: PFH handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_args", "_pfhHandle"];
_args params ["_unit"];

if (isNull _unit || {!alive _unit}) exitWith {
    if (!isNull _unit) then {
        _unit setVariable [QGVAR(radPhysiologyPFHActive), false, true];
        _unit setVariable [QGVAR(radFever), 0, true];
        _unit setVariable [QGVAR(radBPDrop), 0, true];
        if (_unit == ACE_player) then { [false, 0] call EFUNC(feedback,effectRadiation); };
    };
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};

private _interval = 5;
private _tier = _unit getVariable [QGVAR(radSicknessTier), 0];
private _marrow = _unit getVariable [QGVAR(radMarrowFactor), 1];

if (_tier >= 2) then {
    private _vol = (1 - _marrow) * GVAR(rad_marrowAnemiaRate) * _interval;
    if (_vol > 0) then { REDUCE_TOTAL_BLOOD_VOLUME(_unit,_vol); };
};

if (_tier >= 3) then {
    REDUCE_TOTAL_BLOOD_VOLUME(_unit,GVAR(rad_giFluidLossRate) * _interval);

    if (missionNamespace getVariable [QEGVAR(breathing,enable), false]) then {
        private _bloodGas = GET_BLOOD_GAS(_unit);
        private _drop = GVAR(rad_giAcidosisRate) * _interval;
        _bloodGas set [3, ((_bloodGas select 3) - _drop) max 0];
        _bloodGas set [4, ((_bloodGas select 4) - (_drop * 0.02)) max 6.8];
        _unit setVariable [VAR_BLOOD_GAS, _bloodGas, true];
    };

    if (random 1 < 0.4) then {
        playSound3D [QPATHTOEF_SOUND(airway,sounds\puking1.wav), _unit, false, getPosASL _unit, 5, 1, 15];
        _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + 0.05) min 1, true];
    };
};

if (_tier >= 4) then {
    if (missionNamespace getVariable [QEGVAR(circulation,enable), false]) then {
        private _bpMax = GVAR(rad_cnsHypotension);
        private _bp = (_unit getVariable [QGVAR(radBPDrop), 0]) + (_bpMax * 0.1 * _interval);
        _unit setVariable [QGVAR(radBPDrop), _bp min _bpMax, true];
    };
    _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + 0.1) min 1, true];
    if (_unit == ACE_player && {random 1 < 0.3}) then { addCamShake [6, 2, 15]; };
};

if (_tier >= 1 && {missionNamespace getVariable [QEGVAR(hypothermia,hypothermiaActive), false]}) then {
    private _fever = ([0, 0.5, 1, 1.5, 2] select _tier) min GVAR(rad_feverMax);
    _unit setVariable [QGVAR(radFever), _fever, true];
};

if (_unit == ACE_player) then {
    if (GVAR(rad_visualEffect)) then {
        private _doseRate = _unit getVariable [QGVAR(radDoseRate), 0];
        private _intensity = ((_tier / 4) max ((_doseRate / 50) min 1)) min 1;
        [true, _intensity] call EFUNC(feedback,effectRadiation);
    } else {
        [false, 0] call EFUNC(feedback,effectRadiation);
    };
};

private _doseRate = _unit getVariable [QGVAR(radDoseRate), 0];
private _burden = _unit getVariable [QGVAR(radInternalBurden), 0];
if (_tier < 4 && {_doseRate < 0.01} && {_burden < 0.001}) then {
    private _severity = (_unit getVariable [QGVAR(radSeverity), 0]) - (GVAR(rad_recoveryRate) * _interval);
    _unit setVariable [QGVAR(radSeverity), _severity max 0, true];
    _unit setVariable [QGVAR(radFever), ((_unit getVariable [QGVAR(radFever), 0]) - (0.1 * _interval)) max 0, true];
    _unit setVariable [QGVAR(radBPDrop), ((_unit getVariable [QGVAR(radBPDrop), 0]) - (2 * _interval)) max 0, true];
};

[_unit] call FUNC(evaluateRadDose);

_tier = _unit getVariable [QGVAR(radSicknessTier), 0];
if (_tier == 0 && {(_unit getVariable [QGVAR(radFever), 0]) <= 0} && {(_unit getVariable [QGVAR(radBPDrop), 0]) <= 0}) exitWith {
    _unit setVariable [QGVAR(radPhysiologyPFHActive), false, true];
    if (_unit == ACE_player) then { [false, 0] call EFUNC(feedback,effectRadiation); };
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};
