#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];

[_unit] call FUNC(fullHealLocal);

if (GVAR(kidneyAction)) then {
    
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        if (!alive _unit) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        /* =========================
           CORE STATE
        ========================= */
        private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];
        _externalPh = (_externalPh max 0) min 300;
        private _lactate    = _unit getVariable [QGVAR(lactate), 1.2];
        private _bv         = GET_BODY_FLUID_ECB(_unit);
        private _hr         = GET_HEART_RATE(_unit);

        private _damage        = _unit getVariable [QGVAR(kidneyDamage), 0];
        private _kidneyFail    = _unit getVariable [QGVAR(kidneyFail), false];
        private _kidneyArrest  = _unit getVariable [QGVAR(kidneyArrest), false];
        private _kidneyPressure= _unit getVariable [QGVAR(kidneyPressure), false];
        private _bicarb = [_unit, "Bicarbonate"] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _serumCa = GET_CA(_unit);
        private _ionizedShift =
            linearConversion [7.45, 7.10, GET_PH(_unit), -0.05, 0.15, true];
        if (_lactate > 4) then {
            _ionizedShift = _ionizedShift +
                linearConversion [4, 10, _lactate, 0.01, 0.05, true];
        };

        /* Bicarb reverses ionized Ca */
        if (_bicarb > 0) then {
            _ionizedShift = _ionizedShift -
                linearConversion [0, 6, _bicarb, 0.00, 0.08, true];
        };
        private _effectiveCa = _serumCa + _ionizedShift;
        _unit setVariable [QGVAR(effectiveCa), _effectiveCa, true];

        /* =========================
           SHOCK MODEL
        ========================= */
        private _bvFrac = (_bv / 2700) max 0.3 min 1;
        private _shockIndex = (_hr / (_bvFrac * 100)) max 0.5 min 3;

        private _shockAcidLoad = linearConversion [1, 2, _shockIndex, 0, 0.6, true];
        private _bvAcidLoad    = linearConversion [0.6, 1.0, _bvFrac, 0.4, 0, true];

        private _totalShockAcid = (_shockAcidLoad + _bvAcidLoad) * 0.25;
        private _bufferFrac = linearConversion [0, 300, _externalPh, 1, 0.15, true];
        _totalShockAcid = _totalShockAcid * _bufferFrac;
        if (_bvFrac > 0.9 && _hr < 110) then { _totalShockAcid = 0 };

        /* =========================
           LACTATE
        ========================= */
        private _lactateGen = linearConversion [1, 2, _shockIndex, 0.01, 0.08, true];
        _lactateGen = _lactateGen * linearConversion [0.6, 1.0, _bvFrac, 1.6, 1.0, true];
        /* Hypocalcemia worsens perfusion → ↑ lactate */
        if (_effectiveCa < 2.1) then {
            _lactateGen = _lactateGen *
                linearConversion [2.1, 1.6, _effectiveCa, 1.0, 1.6, true];
        };
        /* Severe hypercalcemia causes renal vasoconstriction */
        if (_effectiveCa > 3.0) then {
            _lactateGen = _lactateGen *
                linearConversion [3.0, 3.6, _effectiveCa, 1.0, 1.4, true];
        };
        _lactate = (_lactate + _lactateGen) min 15;

        /* Lactate-guided resuscitation target */
        private _lactateTarget = 2.0;

        /* Hypocalcemia or hypercalcemia raises the target */
        if (_effectiveCa < 2.1) then { _lactateTarget = 2.8 };
        if (_effectiveCa > 3.0) then { _lactateTarget = 3.0 };

        /* Kidney + perfusion dependent clearance */
        private _lactateClear =
            linearConversion [_lactateTarget, 6, _lactate, 0.03, 0.0, true] *
            (1 - _damage);

        if (_bvFrac > 0.9 && _hr < 110) then {
            _lactateClear = _lactateClear * 1.5;
        };

        _lactate = (_lactate - _lactateClear) max 0.8;
        _unit setVariable [QGVAR(lactate), _lactate, true];

        /* =========================
           ACID LOAD
        ========================= */
        if (!_kidneyFail) then {
            _externalPh = _externalPh + _totalShockAcid;
        };

        _externalPh = _externalPh + ((_lactate * 0.015) * _bufferFrac);

        /* =========================
           BICARBONATE
        ========================= */


        if (_bicarb > 0) then {
        
            /* Buffer acid */
            _externalPh = (_externalPh - (0.6 * _bicarb)) max 0;

            /* Poor perfusion → CO2 + lactate paradox */
            if (_bvFrac < 0.7) then {
                _externalPh = _externalPh + (0.3 * _bicarb);
                _lactate = _lactate + (0.2 * _bicarb);
            };

            /* Alkalosis binds calcium */
            private _caBind =
                linearConversion [0, 6, _bicarb, 0.00, 0.08, true];

            _unit setVariable [
                QGVAR(externalCa),
                (_unit getVariable [QGVAR(externalCa), 0]) + _caBind,
                true
            ];
        };
        /* =========================
           RENAL CLEARANCE
        ========================= */
        if (!_kidneyFail && _externalPh > 0) then {
            private _clearance =
                6 *
                linearConversion [7.4, 7.1, GET_PH(_unit), 1, 2.2, true] *
                (1 - _damage);

            _externalPh = (_externalPh - _clearance) max 0;
        };
        _externalPh = (_externalPh max 0) min 300;
        _unit setVariable [QEGVAR(pharma,externalPh), _externalPh, true];
        
        private _bloodPH = GET_PH(_unit);

        if (_bloodPH < 7.25) then {
            _damage = (
                _damage +
                linearConversion [7.25, 6.9, _bloodPH, 0.0008, 0.01, true]
            ) min 1;
        };
        if (_effectiveCa > 3.2) then {
            _damage = (_damage +
                linearConversion [3.2, 3.8, _effectiveCa, 0.0005, 0.004, true]
            ) min 1;
        };

        if (_damage >= 0.7 && !_kidneyFail) then {
            _unit setVariable [QGVAR(kidneyFail), true, true];
        };

        if (_bloodPH < 6.9 && !_kidneyArrest) then {
            if (random 1 < 0.35) then {
                [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
                _unit setVariable [QGVAR(kidneyArrest), true, true];
            };
        };

        _unit setVariable [QGVAR(kidneyDamage), _damage, true];
    }, 20, [_unit]] call CBA_fnc_addPerFrameHandler;
};


if (GVAR(kidneyAction)) then {

    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        if (!alive _unit) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _ca = GET_CA(_unit);
        private _damage = _unit getVariable [QGVAR(calciumDamage), 0];
        private _ph = GET_PH(_unit);
        private _bv = GET_BODY_FLUID_ECB(_unit);
        private _hr = GET_HEART_RATE(_unit);
        private _lactate = _unit getVariable [QGVAR(lactate), 1.2];
        private _bvFrac = (_bv / 2700) max 0.3 min 1;
        private _shockIndex = (_hr / (_bvFrac * 100)) max 0.5 min 3;
        private _liverDamage = _unit getVariable [QGVAR(liverDamage), 0];
        private _liverFail   = _unit getVariable [QGVAR(liverFail), false];
        private _bicarb = [_unit, "Bicarbonate"] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _externalPh = _unit getVariable [QGVAR(externalPh), 0];
        private _caCl2 = [_unit, "CalciumChloride"] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _caGlu = [_unit, "CalciumGluconate"] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _txa = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount) select 1;
        private _effectiveCa = _unit getVariable [QGVAR(effectiveCa), GET_CA(_unit)];
        private _bufferFrac = linearConversion [0, 300, _externalPh, 1, 0.15, true];
        if (_txa > 0 && {_bvFrac < 0.8}) then {
            _effectiveCa = _effectiveCa +
                linearConversion [0, 3, _txa, 0.03, 0.12, true];
        };
        /* hepatic injury from shock + acidosis */
        if (_shockIndex > 1.5 || {_ph < 7.15}) then {
            private _injury =
                linearConversion [1.5, 2.5, _shockIndex, 0.0003, 0.002, true];

            if (_ph < 7.1) then {
                _injury = _injury * 1.5;
            };

            _liverDamage = (_liverDamage + _injury) min 1;
        };
        if (_liverDamage > 0.7 && {!_liverFail}) then {
            _unit setVariable [QGVAR(liverFail), true, true];
            _liverFail = true;
        };
        if (_shockIndex < 1.0 && {_ph > 7.3}) then {
            _liverDamage = (_liverDamage - 0.0005) max 0;
            if (_liverDamage < 0.6 && {_liverFail}) then {
                _unit setVariable [QGVAR(liverFail), false, true];
                _liverFail = false;
            };
        };
        private _hepaticFrac = 1 - _liverDamage;
        /* shock-dependent hypoperfusion */
        private _shockFrac =
            linearConversion [0.9, 2.0, _shockIndex, 1.0, 0.25, true];

        _hepaticFrac = (_hepaticFrac * _shockFrac) max 0.05;
        /* Calcium extremes impair hepatic perfusion */
        if (_effectiveCa < 2.0 || {_effectiveCa > 3.3}) then {
            _hepaticFrac = _hepaticFrac *
                linearConversion [1.6, 3.6, abs (_effectiveCa - 2.4), 1.0, 0.75, true];
        };

        private _kidneyFail = _unit getVariable [QGVAR(kidneyFail), false];

        private _citrate = _unit getVariable [QGVAR(externalCa), 0];
        if (_citrate > 0) then {    
            private _boundCa = (_citrate * 0.15) min 0.3;
            _ca = (_ca - _boundCa) max 1.6;

            private _kidneyFrac = 1 - (_unit getVariable [QGVAR(kidneyDamage), 0]);
            _kidneyFrac = _kidneyFrac max 0.2;

            private _clearanceRate = 0.05 * _kidneyFrac * _hepaticFrac;
            if (_liverFail) then {
                _clearanceRate = _clearanceRate * 0.25;
            };

            _citrate = (_citrate - _clearanceRate) max 0;
            _unit setVariable [QGVAR(externalCa), _citrate, true];
             if (_hepaticFrac > 0.8 && {_citrate < 5}) then {
                _ca = _ca + 0.01;
            };
        };
        if (_caCl2 > 0) then {
            private _delta = (_caCl2 min 0.25);
            _ca = _ca + _delta;
            _caCl2 = (_caCl2 - _delta) max 0;
        };

        /* Ca-gluconate: slow release */
        if (_caGlu > 0) then {
            private _delta =
                linearConversion [0, 1, _hepaticFrac, 0.005, 0.02, true];
            _ca = _ca + (_delta min _caGlu);
            _caGlu = (_caGlu - _delta) max 0;
        };
        if (_caCl2 > 0 && {_bvFrac < 0.6}) then {
            if (random 1 < 0.2) then {
                _unit setVariable [
                    QGVAR(calciumDamage),
                    (_damage + 0.05) min 1,
                    true
                ];
            };
        };
        private _ionizedShift =
            linearConversion [7.45, 7.10, _ph, -0.05, 0.15, true];

        if (_lactate > 4) then {
            _ionizedShift = _ionizedShift +
                linearConversion [4, 10, _lactate, 0.01, 0.05, true];
        };

        if (_bicarb > 0) then {
            _ionizedShift = _ionizedShift -
                linearConversion [0, 6, _bicarb, 0.00, 0.08, true];
        };

        _effectiveCa = _ca + _ionizedShift;
        /*
            RENAL EXCRETION
        */
        if (!_kidneyFail && {_effectiveCa > 2.4}) then {
            private _renalClearance =
                linearConversion [2.4, 3.2, _effectiveCa, 0.01, 0.05, true];
            _ca = (_ca - _renalClearance) max 1.5;
        };

        /*
            BONE BUFFERING (slow, bidirectional)
        */
        if (_effectiveCa < 2.2) then {
            _ca = _ca + 0.01; // release from bone
        };

        if (_effectiveCa > 2.7) then {
            _ca = _ca - 0.01; // deposition into bone
        };

        /*
            TOXICITY FROM PROLONGED HYPERCALCEMIA
        */
        if (_effectiveCa > 3.0) then {
            _damage = (_damage + 0.001) min 1;
        };
        /*
            CARDIAC CONTRACTILITY EFFECTS
        */
        if (_effectiveCa < 2.1) then {
            private _contractility = linearConversion [2.1, 1.6, _effectiveCa, -0.02, -0.12, true];
            [_unit, "CALCIUM", 10, 600, 0, 0, 0, 0, 0, 0, 0, 0, 0, _contractility] call EFUNC(vitals,addMedicationAdjustment);
        };

        /* Hypocalcemia worsens acidosis via poor perfusion */
        /* Hypocalcemia worsens perfusion → acidosis */
        if (_effectiveCa < 1.8) then {
            _unit setVariable [
                QGVAR(externalPh),
                (_externalPh + linearConversion [1.8, 1.5, _effectiveCa, 0.1, 0.4, true]),
                true
            ];
        };

        /* Severe hypercalcemia → renal vasoconstriction */
        if (_effectiveCa > 3.2) then {
            _unit setVariable [
                QGVAR(externalPh),
                (_externalPh + (0.15 * (1 - _bufferFrac))),
                true
            ];
        };
        if (_effectiveCa > 3.0) then {
            private _contractility = linearConversion [3.0, 3.5, _effectiveCa, 0.05, 0.2, true];
            if (_effectiveCa > 3.6) then {
                _contractility = _contractility - 0.05;
            };
            if (_caCl2 > 0) then {
                _contractility = _contractility * 1.4;
            };
            [_unit, "CALCIUM", 10, 600, 0, 0, 0, 0, 0, 0, 0, 0, 0, _contractility] call EFUNC(vitals,addMedicationAdjustment);
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
        diag_log str _arrProb;
        private _lastArr = _unit getVariable [QGVAR(lastArrhythmia), -1000];
        if (_lastArr > 0 && {CBA_missionTime - _lastArr < 60}) exitWith {};
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
                        _arrestType = 4; // VT
                    };
                };
            };

            _unit setVariable [
                QEGVAR(circulation,cardiacArrestType),
                _arrestType,
                true
            ];

            [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
        };
        _unit setVariable [QGVAR(serumCalcium), _ca, true];
        _unit setVariable [QGVAR(effectiveCa), _effectiveCa, true];
        _unit setVariable [QGVAR(calciumDamage), _damage, true];
        _unit setVariable [QGVAR(liverDamage), _liverDamage, true];

    }, 30, [_unit]] call CBA_fnc_addPerFrameHandler;
};
