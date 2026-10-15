#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Owner-local per-unit radiation-physiology tick. Drives the dose-dependent
 * sub-syndromes by current sickness tier (hematopoietic anemia, GI dehydration
 * and acidosis, neurovascular hypotension and seizures, systemic fever and the
 * visual feedback), runs the immune/infection model (sepsis-capable), and
 * handles slow spontaneous recovery below the lethal tier.
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

    if (random 1 < 0.4 && {CBA_missionTime >= (_unit getVariable [QGVAR(radAntiemeticWindow), 0])}) then {
        playSound3D [QPATHTOEF_SOUND(airway,sounds\puking1.wav), _unit, false, getPosASL _unit, 5, 1, 15];
        _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + 0.05) min 1, true];
    };
};

private _curable = GVAR(rad_lethalCurable);
private _severity = _unit getVariable [QGVAR(radSeverity), 0];
private _critical = _unit getVariable [QGVAR(radCritical), false];

if (_curable) then {
    if (_tier >= 4 && {!_critical}) then {
        _critical = true;
        _unit setVariable [QGVAR(radCritical), true, true];
        _unit setVariable [QGVAR(radCollapseTimer), GVAR(rad_lethalCollapseTime), true];
    };
    if (_critical && {_severity < GVAR(rad_doseThreshold_moderate)}) then {
        _critical = false;
        _unit setVariable [QGVAR(radCritical), false, true];
        _unit setVariable [QGVAR(radCollapseTimer), -1, true];
    };
};

if (!_curable && {_tier >= 4}) then {
    if (missionNamespace getVariable [QEGVAR(circulation,enable), false]) then {
        private _bp = (_unit getVariable [QGVAR(radBPDrop), 0]) + (GVAR(rad_cnsHypotension) * 0.1 * _interval);
        _unit setVariable [QGVAR(radBPDrop), _bp min GVAR(rad_cnsHypotension), true];
    };
    _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + 0.1) min 1, true];
    if (_unit == ACE_player && {random 1 < 0.3}) then { addCamShake [6, 2, 15]; };
};

if (_critical) then {
    private _inArrest = _unit getVariable [QACEGVAR(medical,inCardiacArrest), false];
    private _fragility = (((_severity - GVAR(rad_doseThreshold_moderate)) / ((GVAR(rad_doseThreshold_lethal) - GVAR(rad_doseThreshold_moderate)) max 0.1)) max 0) min 1;
    private _support = (count (_unit getVariable [QACEGVAR(medical,ivBags), []]) > 0)
        || {(([_unit, "Epinephrine", false] call ACEFUNC(medical_status,getMedicationCount)) select 1) > 0}
        || {(([_unit, "Norepinephrine", false] call ACEFUNC(medical_status,getMedicationCount)) select 1) > 0};

    if (_inArrest) then {
        _unit setVariable [QGVAR(radCollapseTimer), GVAR(rad_lethalCollapseTime), true];
    } else {
        if (missionNamespace getVariable [QEGVAR(circulation,enable), false]) then {
            private _bp = _unit getVariable [QGVAR(radBPDrop), 0];
            if (_support) then {
                _bp = (_bp - (GVAR(rad_cnsHypotension) * 0.15 * _interval)) max 0;
            } else {
                _bp = (_bp + (GVAR(rad_cnsHypotension) * 0.1 * _interval)) min GVAR(rad_cnsHypotension);
            };
            _unit setVariable [QGVAR(radBPDrop), _bp, true];
        };

        if (_tier >= 4) then {
            _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + 0.1) min 1, true];
            if (_unit == ACE_player && {random 1 < 0.3}) then { addCamShake [6, 2, 15]; };
        };

        private _timer = _unit getVariable [QGVAR(radCollapseTimer), GVAR(rad_lethalCollapseTime)];
        if (_support) then {
            _timer = (_timer + _interval) min GVAR(rad_lethalCollapseTime);
        } else {
            _timer = _timer - _interval;
        };
        _unit setVariable [QGVAR(radCollapseTimer), _timer, true];

        private _triggerArrest = (_timer <= 0);
        if (!_triggerArrest) then {
            private _chance = GVAR(rad_recrashChance) * _fragility;
            if (_support) then { _chance = _chance * 0.5; };
            if (random 1 < _chance) then { _triggerArrest = true; };
        };

        if (_triggerArrest) then {
            _unit setVariable [QGVAR(radCollapseTimer), GVAR(rad_lethalCollapseTime), true];
            [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
            if ((missionNamespace getVariable [QEGVAR(circulation,AdvRhythm), false]) && {random 1 < (GVAR(rad_shockableChance) * _fragility)}) then {
                [{
                    params ["_unit"];
                    if (_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) then {
                        _unit setVariable [QEGVAR(circulation,cardiacArrestType), selectRandom [3, 4], true];
                    };
                }, [_unit], 0.5] call CBA_fnc_waitAndExecute;
            };
        } else {
            private _stem = CBA_missionTime < (_unit getVariable [QGVAR(radMarrowRescueWindow), 0]);
            private _filg = CBA_missionTime < (_unit getVariable [QGVAR(radFilgrastimWindow), 0]);
            private _abx = CBA_missionTime < (_unit getVariable [QGVAR(radAntibioticWindow), 0]);
            private _sourceGone = ((_unit getVariable [QGVAR(radDoseRate), 0]) < 0.01) && {(_unit getVariable [QGVAR(radInternalBurden), 0]) < 0.001};
            if (_support && _stem && _filg && _abx && _sourceGone) then {
                private _newSev = ((_unit getVariable [QGVAR(radSeverity), 0]) - (GVAR(rad_criticalRecoveryRate) * _interval)) max 0;
                _unit setVariable [QGVAR(radSeverity), _newSev, true];
            };
        };
    };
};

private _infLevel = _unit getVariable [QGVAR(radInfectionLevel), 0];
if (GVAR(rad_infectionEnable)) then {
    private _immune = _unit getVariable [QGVAR(radImmuneFactor), 1];
    private _antibiotic = CBA_missionTime < (_unit getVariable [QGVAR(radAntibioticWindow), 0]);

    if (_infLevel <= 0) then {
        private _hasWounds = ((count (_unit getVariable [VAR_OPEN_WOUNDS, []])) + (count (_unit getVariable [VAR_BANDAGED_WOUNDS, []]))) > 0;
        if (_immune < 0.9 && {_hasWounds} && {!_antibiotic} && {random 1 < ((1 - _immune) * GVAR(rad_infectionChance) * _interval)}) then {
            _infLevel = 0.05;
            _unit setVariable [QGVAR(radInfection), true, true];
        };
    } else {
        if (_antibiotic || {_immune > 0.95}) then {
            _infLevel = (_infLevel - (0.05 * _interval)) max 0;
        } else {
            _infLevel = (_infLevel + ((1 - _immune) * GVAR(rad_infectionSeverityRate) * _interval)) min 1;
        };

        _unit setVariable [VAR_PAIN, ((_unit getVariable [VAR_PAIN, 0]) + (0.05 * _infLevel)) min 1, true];
        REDUCE_TOTAL_BLOOD_VOLUME(_unit,(_infLevel * _infLevel) * GVAR(rad_infectionDamageRate) * _interval);

        if (_infLevel <= 0) then { _unit setVariable [QGVAR(radInfection), false, true]; };
    };

    _unit setVariable [QGVAR(radInfectionLevel), _infLevel, true];
};

if (missionNamespace getVariable [QEGVAR(hypothermia,hypothermiaActive), false]) then {
    private _tierFever = ([0, 0.5, 1, 1.5, 2] select _tier) min GVAR(rad_feverMax);
    private _targetFever = _tierFever max (_infLevel * GVAR(rad_feverMax));
    private _cur = _unit getVariable [QGVAR(radFever), 0];
    _unit setVariable [QGVAR(radFever), (_cur + ((_targetFever - _cur) * 0.4)), true];
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
if (!_critical && {_tier < 4} && {_doseRate < 0.01} && {_burden < 0.001}) then {
    private _recovery = GVAR(rad_recoveryRate);
    if (CBA_missionTime < (_unit getVariable [QGVAR(radFilgrastimWindow), 0])) then {
        _recovery = _recovery * GVAR(rad_filgrastimFactor);
    };
    private _severity = (_unit getVariable [QGVAR(radSeverity), 0]) - (_recovery * _interval);
    _unit setVariable [QGVAR(radSeverity), _severity max 0, true];
    _unit setVariable [QGVAR(radBPDrop), ((_unit getVariable [QGVAR(radBPDrop), 0]) - (2 * _interval)) max 0, true];
};

[_unit] call FUNC(evaluateRadDose);

_tier = _unit getVariable [QGVAR(radSicknessTier), 0];
if (_tier == 0 && {!(_unit getVariable [QGVAR(radCritical), false])} && {(_unit getVariable [QGVAR(radFever), 0]) <= 0.05} && {(_unit getVariable [QGVAR(radBPDrop), 0]) <= 0} && {!(_unit getVariable [QGVAR(radInfection), false])}) exitWith {
    _unit setVariable [QGVAR(radFever), 0, true];
    _unit setVariable [QGVAR(radPhysiologyPFHActive), false, true];
    if (_unit == ACE_player) then { [false, 0] call EFUNC(feedback,effectRadiation); };
    _pfhHandle call CBA_fnc_removePerFrameHandler;
};
