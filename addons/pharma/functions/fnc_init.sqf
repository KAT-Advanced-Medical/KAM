#include "..\script_component.hpp"
/*
 * Author: Katalam, Miss Heda
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);

if (GVAR(kidneyAction)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        if (!alive _unit) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _maxDeltaPH = 1;
        private _maxDeltaLact = 0.05;
        private _maxDeltaDmg = 0.00125;
        private _prev = _unit getVariable [QGVAR(prevRenalPhysio), [
            0,
            1.2,
            2.4,
            0
        ]];

        _prev params [
            "_prevExtPH",
            "_prevLact",
            "_prevCa",
            "_prevDmg"
        ];
        private _rateLimit = {
            params ["_new", "_old", "_max"];
            (_new max (_old - _max)) min (_old + _max)
        };
        private _externalPh = _unit getVariable [QGVAR(externalPh), 0];
        private _ph         = GET_PH(_unit);
        _externalPh = (_externalPh max -300) min 300;
        private _lactate    = _unit getVariable [QGVAR(lactate), 1.2];
        private _sign = if (_externalPh == 0) then {1} else {_externalPh / abs _externalPh};
        private _bv         = GET_BODY_FLUID_ECB(_unit);
        private _hr         = GET_HEART_RATE(_unit);
        private _damage        = _unit getVariable [QGVAR(kidneyDamage), 0];
        private _kidneyFail    = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest  = _unit getVariable [QGVAR(kidneyArrest), false];
        private _bicarb = [_unit, "Bicarbonate", false] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _effectiveCa = _unit getVariable [QGVAR(effectiveCa), 2.4];
        private _bvFrac = (_bv / 2700) max 0.3 min 1;
        private _shockIndex = (_hr / (_bvFrac * 100)) max 0.5 min 3;
        private _kidneyFailTimer = _unit getVariable [QGVAR(kidneyFailTimer), 0];
        private _shockAcidLoad = linearConversion [1, 2, _shockIndex, 0, 0.4, true];
        private _bvAcidLoad    = linearConversion [0.6, 1.0, _bvFrac, 0.3, 0, true];
        private _kidneyFrac = 1 - _damage;
        _kidneyFrac = _kidneyFrac max 0.15;
        if (_kidneyFail) then {
            _kidneyFrac = _kidneyFrac * 0.35;
        };
        private _totalShockAcid = (_shockAcidLoad + _bvAcidLoad) * 0.25;
        private _bufferFrac = linearConversion [0, 300, (abs _externalPh), 1, 0.15, true];
        _bufferFrac = _bufferFrac * linearConversion [1.0, 0.5, _bvFrac, 1.0, 0.7, true];
        _totalShockAcid = _totalShockAcid * _bufferFrac;
        if (_bvFrac > 0.9 && _hr < 110) then { _totalShockAcid = 0 };
        private _lactateGen =
        linearConversion [1, 2.2, _shockIndex, 0.01, 0.035, true] *
        linearConversion [2, 6, _lactate, 1.0, 0.4, true];
        _lactateGen = _lactateGen * linearConversion [0.4, 1.0, _bvFrac, 1.8, 1.0, true];
        if (_effectiveCa < 2.1) then {
            _lactateGen = _lactateGen *
                linearConversion [2.1, 1.6, _effectiveCa, 1.0, 1.6, true];
        };
        if (_effectiveCa > 3.0) then {
            _lactateGen = _lactateGen *
                linearConversion [3.0, 3.6, _effectiveCa, 1.0, 1.4, true];
        };
        _lactate = (_lactate + _lactateGen) min 15;
        private _lactateTarget = 2.0;
        if (_effectiveCa < 2.1) then { _lactateTarget = 2.8 };
        if (_effectiveCa > 3.0) then { _lactateTarget = 3.0 };
        private _lactateClear =
            linearConversion [_lactateTarget, 6, _lactate, 0.015, 0.0, true] *
            linearConversion [0, 0.8, _damage, 1.0, 0.4, true] *
            _kidneyFrac;
        if (_bvFrac > 0.9 && _hr < 110) then {
            _lactateClear = _lactateClear * 1.5;
        };
        _lactate = _lactate - _lactateClear;
        _lactate = [_lactate, _prevLact, _maxDeltaLact] call _rateLimit;
        _lactate = _lactate max 0.8;
        _unit setVariable [QGVAR(lactate), _lactate, true];
        if (!_kidneyFail) then {
            _externalPh = _externalPh + _totalShockAcid;
        };

        _externalPh = _externalPh + ((_lactate * 0.0075) * _bufferFrac);
        private _rr    = _unit getVariable [QEGVAR(breathing,breathRate), 0];
        private _depth = _unit getVariable [VAR_RESPIRATORY_DEPTH, 0];
        private _normRR    = 14;
        private _normDepth = DEFAULT_RESPIRATORY_DEPTH;
        private _acidRepo = _unit getVariable [QGVAR(acidRepo), 1.0];
        private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_unit);
        private _anerobicPressure = (DEFAULT_ANEROBIC_EXCHANGE * (6 / (_bloodVolume max 6))) min 1.2;
        private _ventRatio = ((_rr max 0) * (_depth max 0)) / (_normRR * _normDepth);
        if (_ph < 7.3) then {
            if (_ventRatio > 1.1) then {
        
            private _cnsSupp =
                (_unit getVariable [QEGVAR(surgery,sedated), 0])
                max (_unit getVariable [QEGVAR(pharma,opioidDepression), 0]);

            private _ventEff =
                linearConversion [1.1, 3.5, _ventRatio, 0.0, 1.0, true]
                * linearConversion [0, 1, _cnsSupp, 1.0, 0.4, true];

            private _bufferLimit =
                linearConversion [0, 300, abs _externalPh, 0.15, 1.0, true];
            private _respOffgas =
                0.35
                * _ventEff
                * _bufferLimit;
            _respOffgas = _respOffgas * linearConversion [2, 6, _lactate, 1.0, 0.3, true];
            private _repoDrain =
                linearConversion [1.0, 2.5, _ventRatio, 0.0, 0.0125, true]
                * linearConversion [1.0, 1.2, _anerobicPressure, 0.6, 1.0, true];
            if (_kidneyFail) then {
                _repoDrain = _repoDrain * 1.4;
            };
            _acidRepo = (_acidRepo - _repoDrain) max 0;
            _respOffgas = _respOffgas * _acidRepo;
            _externalPh = _externalPh - (_respOffgas * _sign);
            private _lactRespClear =
                0.02 * _ventEff * linearConversion [7.35, 7.55, _ph, 1.0, 0.6, true];
            _lactate = (_lactate - _lactRespClear) max 0.8;

            TRACE_4(
                "RESP_OFFGASS",
                _ventRatio,
                _ventEff,
                _respOffgas,
                _externalPh
                );
            };
        };
        if (_ventRatio < 1.1 && _anerobicPressure < 1.05) then {
            _acidRepo = (_acidRepo + 0.015) min 1.0;
        };
        
        _unit setVariable [QGVAR(acidRepo), _acidRepo, true];
        if (_bicarb > 0) then {
            private _bicarbMult = linearConversion [0, 300, abs _externalPh, 0.2, 1.0, true];
            _externalPh = _externalPh - (0.6 * (_bicarb * _bicarbMult));
            if (_bvFrac < 0.7) then {
                _externalPh = _externalPh + (0.3 * (_bicarb * _bicarbMult));
                _lactate = _lactate + (0.2 * (_bicarb * _bicarbMult));
            };
            private _caBind = linearConversion [0, 6, _bicarb, 0.00, 0.04, true];
            _unit setVariable [
                QGVAR(externalCa),
                (_unit getVariable [QGVAR(externalCa), 0]) + _caBind,
                true
            ];
        };
        if (_externalPh != 0) then {
            private _clearance =
                0.125 *
                _kidneyFrac *
                linearConversion [0, 250, abs _externalPh, 0.8, 1.8, true] *
                linearConversion [0, 0.8, _damage, 1.0, 0.4, true]
                * linearConversion [1.0, 0.5, _bvFrac, 1.0, 0.4, true];
            
            _externalPh = _externalPh - (_clearance * _sign);
        };
        if (_effectiveCa < 1.8) then {
            _externalPh = _externalPh + linearConversion [1.8, 1.5, _effectiveCa, 0.01, 0.06, true];
        };
        if (_effectiveCa > 3.2) then {
             _externalPh = _externalPh + (0.025 * (1 - _bufferFrac));
        };
        _externalPh = [_externalPh, _prevExtPH, _maxDeltaPH] call _rateLimit;
        _externalPh = (_externalPh max -300) min 300;
        _unit setVariable [QGVAR(externalPh), _externalPh, true];

        if (_ph < 7.25) then {
            _damage = (
                _damage +
                linearConversion [7.25, 6.9, _ph, 0.0004, 0.005, true]
            ) min 1;
        };

        if (_ph > 7.55) then {
            _damage = (
                _damage +
                linearConversion [7.55, 7.75, _ph, 0.00025, 0.004, true]
            ) min 1;
        };

        if (_effectiveCa > 3.2) then {
            private _d = (_damage + linearConversion [3.2, 3.8, _effectiveCa, 0.00025, 0.004, true]) min 1;
            _damage = [_d, _prevDmg, _maxDeltaDmg] call _rateLimit;

        };
        if (_effectiveCa < 1.6) then {
            private _d = (_damage + linearConversion [1.6, 1.1, _effectiveCa, 0.00025, 0.004, true]) min 1;
            _damage = [_d, _prevDmg, _maxDeltaDmg] call _rateLimit;
        };

        if (_damage >= 0.7) then {
        _kidneyFailTimer = _kidneyFailTimer + 5;
        } else {
            _kidneyFailTimer = (_kidneyFailTimer - 2) max 0;
        };

        if (_kidneyFailTimer > 600 && !_kidneyFail) then {
            _unit setVariable [QGVAR(kidneyFail), true, true];
        };

        _unit setVariable [QGVAR(kidneyFailTimer), _kidneyFailTimer, true];

        if (_ph < 6.9 && !_kidneyArrest) then {
            if (random 1 < 0.35) then {
                [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                _unit setVariable [QGVAR(kidneyArrest), true, true];
            };
        };

        _unit setVariable [QGVAR(kidneyDamage), _damage, true];
        _unit setVariable [QGVAR(prevRenalPhysio),
            [
                _externalPh,
                _lactate,
                _effectiveCa,
                _damage
            ]
        ];
    }, 5, [_unit]] call CBA_fnc_addPerFrameHandler;
};

if (GVAR(kidneyAction)) then {

    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        if (!alive _unit) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _maxDeltaDmg = 0.0025;
        private _prev = _unit getVariable [QGVAR(prevCalciumPhysio), [
            0,
            1.2,
            2.4,
            0
        ]];

        _prev params [
            "_prevExtPH",
            "_prevLact",
            "_prevCa",
            "_prevDmg"
        ];

        private _rateLimit = {
            params ["_new", "_old", "_max"];
            (_new max (_old - _max)) min (_old + _max)
        };
        private _ca = _unit getVariable [QGVAR(serumCalcium), 0];
        private _damage = _unit getVariable [QGVAR(calciumDamage), 0];
        private _ph = GET_PH(_unit);
        private _bv = GET_BODY_FLUID_ECB(_unit);
        private _hr = GET_HEART_RATE(_unit);
        private _lactate = _unit getVariable [QGVAR(lactate), 1.2];
        private _bvFrac = (_bv / 2700) max 0.3 min 1;
        private _shockIndex = (_hr / (_bvFrac * 100)) max 0.5 min 3;
        private _liverDamage = _unit getVariable [QGVAR(liverDamage), 0];
        private _liverFail   = _unit getVariable [QGVAR(liverFail), false];
        private _bicarb = [_unit, "Bicarbonate", false] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _externalPh = _unit getVariable [QGVAR(externalPh), 0];
        private _caCl2 = [_unit, "CalciumChloride", false] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _caGlu = [_unit, "CalciumGluconate", false] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _txa = [_unit, "TXA", false] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _effectiveCa = _unit getVariable [QGVAR(effectiveCa), GET_CA(_unit)];
        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyDamage = _unit getVariable [QGVAR(kidneyDamage), 0];
        private _externalCa = _unit getVariable [QGVAR(externalCa), 0];
        private _kidneyFrac = 1 - _kidneyDamage;
        TRACE_6(
    "Ca INPUT",
    _ca,
    _effectiveCa,
    _externalCa,
    _ph,
    _shockIndex,
    _kidneyFrac
);
        _kidneyFrac = _kidneyFrac max 0.15;
        if (_kidneyFail) then {
            _kidneyFrac = _kidneyFrac * 0.35;
        };
        if (_txa > 0) then {
            private _txaPerfusionBonus =
                linearConversion [0, 3, _txa, 1.0, 0.85, true];

            _shockIndex = _shockIndex * _txaPerfusionBonus;
        };
        if (_shockIndex > 1.5 || {_ph < 7.15}) then {
            private _injury =
                linearConversion [1.5, 2.5, _shockIndex, 0.00015, 0.001, true];

            if (_ph < 7.1) then {
                _injury = _injury * 1.5;
            };

            _liverDamage = (_liverDamage + _injury) min 1;
        };
        if (_liverDamage > 0.8 && {!_liverFail}) then {
            _unit setVariable [QGVAR(liverFail), true, true];
            _liverFail = true;
        };
        if (
            _shockIndex < 1.0 &&
            {_ph > 7.35} &&
            {_effectiveCa > 2.2} &&
            {_effectiveCa < 2.8}
        ) then {
            _liverDamage = (_liverDamage - 0.000125) max 0;

            if (_liverDamage < 0.5 && {_liverFail}) then {
                _unit setVariable [QGVAR(liverFail), false, true];
                _liverFail = false;
            };
        };
        private _hepaticFrac = 1 - _liverDamage;
        private _shockFrac =
            linearConversion [0.9, 2.0, _shockIndex, 1.0, 0.25, true];

        _hepaticFrac = (_hepaticFrac * _shockFrac) max 0.05;
        if (_effectiveCa < 2.0 || {_effectiveCa > 3.3}) then {
            _hepaticFrac = _hepaticFrac *
                linearConversion [1.6, 3.6, abs (_effectiveCa - 2.4), 1.0, 0.75, true];
        };

        
        TRACE_4(
            "Inputs",
            _ca,
            _effectiveCa,
            _ph,
            _shockIndex
        );

        TRACE_4(
            "Perfusion",
            _bvFrac,
            _hepaticFrac,
            _liverDamage,
            _kidneyFail
        );

        
        private _targetCa = 2.4 + linearConversion [-300, 300, _externalCa, -0.9, 0.9, true];
        TRACE_3(
    "Ca TARGET",
    _targetCa,
    _caError,
    _externalCa
);
        if (_externalCa != 0) then {    
                TRACE_3(
        "ExternalCa PRE",
        _externalCa,
        _kidneyFrac,
        _hepaticFrac
    );
            private _kidneyFrac = 1 - (_unit getVariable [QGVAR(kidneyDamage), 0]);
            _kidneyFrac = _kidneyFrac max 0.2;

            private _clearanceRate = 0.0025 * _kidneyFrac * _hepaticFrac;
            if (_liverFail) then {
                _clearanceRate = _clearanceRate * 0.125;
            };
            _externalCa = _externalCa - (_clearanceRate * ((_externalCa max -1) min 1));
            _externalCa = (_externalCa max -300) min 300;

            _unit setVariable [QGVAR(externalCa), _externalCa, true];
             if (_hepaticFrac > 0.8 && {_externalCa < 5} && (!_kidneyFail)) then {
                _ca = _ca + (0.002 * (_externalCa max -1 min 1));
            };
                TRACE_3(
        "ExternalCa CLR",
        _clearanceRate,
        _externalCa,
        _liverFail
    );
        };
        if (_caCl2 > 0) then {
            private _amp = _caCl2 min 3;
            private _cancel = (_amp * 4);
            _externalCa = _externalCa + _cancel;
        };
        if (_caGlu > 0) then {
            private _amp = _caGlu min 2;
            private _cancel = (_amp * 0.2);
            _externalCa = _externalCa + _cancel;
        };
        if (_caCl2 > 0 && {_bvFrac < 0.6}) then {
            if (random 1 < 0.2) then {
                _unit setVariable [
                    QGVAR(calciumDamage),
                    (_damage + 0.02) min 1,
                    true
                ];
            };
        };
        private _caError = _targetCa - _ca;
        private _caGain = 0.05;
        private _caRate =
            _caError *
            _caGain *
            _kidneyFrac *
            _hepaticFrac *
            _bvFrac;
        _caRate = _caRate max -0.0005 min 0.0005;

        _ca = _ca + _caRate;

        TRACE_3(
            "Ca HOMEOSTASIS",
            _caError,
            _caRate,
            _ca
        );
        private _ionizedShift = 0;
        if (_ph < 7.35) then {
            _ionizedShift = _ionizedShift +
                linearConversion [7.35, 7.10, _ph, 0.00, 0.12, true];
        };
        if (_lactate > 4) then {
            _ionizedShift = _ionizedShift +
                linearConversion [4, 10, _lactate, 0.00, 0.08, true];
        };
        if (_bicarb > 0) then {
            _ionizedShift = _ionizedShift -
                linearConversion [0, 6, _bicarb, 0.00, 0.10, true];
        };

        _ionizedShift = _ionizedShift max -0.25 min 0.25;
        _effectiveCa = (_ca + _ionizedShift) max 0;

        TRACE_4(
            "IONIZED",
            _ionizedShift,
            _ca,
            _effectiveCa,
            _ph
        );
        private _deltaCa = _effectiveCa - _prevCa;
        _deltaCa = [_deltaCa, 0, 0.03] call _rateLimit;
        _effectiveCa = _prevCa + _deltaCa;
        if (_effectiveCa > 2.4) then {
            private _renalPerf =
                linearConversion [1, 1.8, _shockIndex, 1.0, 0.1, true];

            private _renalClearance =
                _renalPerf *
                _kidneyFrac *
                linearConversion [2.35, 2.9, _effectiveCa, 0.0005, 0.004, true];
            _ca = (_ca - _renalClearance) max 1.5;
        TRACE_4(
            "Renal Ca excretion",
            _renalPerf,
            _renalClearance,
            _effectiveCa,
            _ca
        );
        };
        private _boneFlux = linearConversion [2.2, 2.6, _effectiveCa, 0.0015, -0.0015, true];
        _ca = _ca + _boneFlux;

        if (!_kidneyFail && {_effectiveCa < 2.4}) then {
            _ca = _ca + linearConversion [2.45, 2.25, _effectiveCa, 0.000, 0.0005, true]
        };
        if (_effectiveCa > 3.0) then {
            private _d = (_damage + 0) min 1;
            _damage = [_d, _prevDmg, _maxDeltaDmg] call _rateLimit;

        };
        if (_effectiveCa < 2.1) then {
            private _medCount = [_unit, "CALCIUMCONTRACTILITY"] call ACEFUNC(medical_status,getMedicationCount) select 1;
            private _contractility = linearConversion [2.1, 1.6, _effectiveCa, -0.02, -0.12, true];
            if (_medCount < 0.2) then {
                [_unit, "CALCIUMCONTRACTILITY", 5, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, _contractility, 0, "false", "false", "true"] call EFUNC(vitals,addMedicationAdjustment);
            };
        };
        if (_effectiveCa > 3.0) then {
            private _contractility = linearConversion [3.0, 3.5, _effectiveCa, 0.05, 0.2, true];
            if (_effectiveCa > 3.6) then {
                _contractility = _contractility - 0.05;
            };
            if (_caCl2 > 0) then {
                _contractility = _contractility * 1.4;
            };
            private _medCount = [_unit, "CALCIUMCONTRACTILITY"] call ACEFUNC(medical_status,getMedicationCount) select 1;
            if (_medCount < 0.2) then {
                [_unit, "CALCIUMCONTRACTILITY", 5, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, _contractility, 0, "false", "false", "true"] call EFUNC(vitals,addMedicationAdjustment);
            };
        };
        private _arrProb = 0;
        if (_effectiveCa < 2.0) then {
            _arrProb =
                linearConversion [2.0, 1.6, _effectiveCa, 0.01, 0.08, true];
        };

        if (_effectiveCa > 3.0) then {
            _arrProb =
                _arrProb max
                linearConversion [3.0, 3.6, _effectiveCa, 0.01, 0.1, true];
        };
        private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
        if ((_ca < 2.1) && ((_ht findIf {_x isEqualTo "hypocalcemia"}) == -1)) then {
            _ht pushBack "hypocalcemia";
        };
        if ((_ca > 3.0) && ((_ht findIf {_x isEqualTo "hypercalcemia"}) == -1)) then {
            _ht pushBack "hypercalcemia";
        };
        if ((_ca > 2.1) && ((_ht findIf {_x isEqualTo "hypocalcemia"}) > -1)) then {
            _ht deleteAt (_ht find "hypocalcemia");
        };
        if ((_ca < 3.0) && ((_ht findIf {_x isEqualTo "hypercalcemia"}) > -1)) then {
            _ht deleteAt (_ht find "hypercalcemia");
        };
        _unit setVariable [QEGVAR(circulation,ht), _ht, true];
        private _lastArr = _unit getVariable [QGVAR(lastArrhythmia), -1000];
        if (_lastArr > 0) then {
            private _refrac =
                linearConversion [0, 60, CBA_missionTime - _lastArr, 0.2, 1.0, true];
            _arrProb = _arrProb * _refrac;
        };
        if (_caCl2 > 0) then {
            _arrProb = _arrProb +
                linearConversion [0, 1, _caCl2, 0.02, 0.06, true];
        };
        if (random 1 < _arrProb) then {
        
            _unit setVariable [QGVAR(lastArrhythmia), CBA_missionTime, true];
            if (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] != 0) exitWith {};
            private _arrestType = 0;
            if (_ca < 1.7) then {
                _arrestType = [3, 2, 1] selectRandomWeighted [0.5, 0.35, 0.15];
            } else {
                if (_ca < 1.9) then {
                    _arrestType = [4, 2] selectRandomWeighted [0.6, 0.4];
                } else {
                    if (_ca < 2.1) then {
                        _arrestType = 4; // VT
                    };
                };
            };
            if (_ca > 3.6) then {
                _arrestType = [3, 1] selectRandomWeighted [0.7, 0.3];
            } else {
                if (_ca > 3.3) then {
                    _arrestType = [4, 3] selectRandomWeighted [0.6, 0.4];
                } else {
                    if (_ca > 3.0) then {
                        _arrestType = 4;
                    };
                };
            };
            if ((_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] > _arrestType) || (_unit getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0)) then {
                _unit setVariable [
                QEGVAR(circulation,cardiacArrestType),
                _arrestType,
                true
                ];
                [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
            };
        };
        if (
            abs _externalCa < 80 &&
            _ph > 7.2 &&
            !_kidneyFail &&
            !_liverFail
        ) then {
            _ca = _ca max 2.05;
        };
        _unit setVariable [QGVAR(serumCalcium), _ca, true];
        _effectiveCa = _effectiveCa max 0;
        _unit setVariable [QGVAR(effectiveCa), _effectiveCa, true];
        _unit setVariable [QGVAR(calciumDamage), _damage, true];
        _unit setVariable [QGVAR(liverDamage), _liverDamage, true];
        _unit setVariable [QGVAR(prevCalciumPhysio),
            [
                _externalPh,
                _lactate,
                _effectiveCa,
                _damage
            ]
        ];

    }, 5, [_unit]] call CBA_fnc_addPerFrameHandler;
};



