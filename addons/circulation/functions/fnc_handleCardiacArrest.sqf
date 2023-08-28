#include "script_component.hpp"
/*
 * Author: Blue
 * Assign cardiac arrest type for unit entering cardiac arrest
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Active <BOOL>
 * 2: Initial cardiac arrest <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_handleCardiacArrest;
 *
 * Public: No
 */

params ["_unit", "_active", ["_initial",true]];

/* type 
0 normal
1 asystole, no pulse, no shock
2 pulseless electrical activity, AEDX fake pulse, no shock
3 ventricular fibrillation, no pulse, shock
4 ventricular tachycardia, fast pulse, shock
*/

private _cardiacArrestType = 0;

if !(alive _unit) exitWith {};

if (_initial) then {
    if !(_active) exitWith {};

    if (_unit getVariable [QACEGVAR(medical,bloodVolume), 6.0] < GVAR(AdvRhythm_asystoleBloodlossThreshold)) then {
        if (floor (random 100) < GVAR(AdvRhythm_PEAChance)) then {
            _cardiacArrestType = 2;
        } else {
            _cardiacArrestType = 1;
        };
    } else {
        if (floor (random 100) < GVAR(AdvRhythm_VTChance)) then {
            _cardiacArrestType = 4;
        } else {
            _cardiacArrestType = 3;
        };
    };

    _unit setVariable [QGVAR(cardiacArrestType), _cardiacArrestType, true];
} else {
    _cardiacArrestType = _unit getVariable [QGVAR(cardiacArrestType), 0];
};

if (GVAR(AdvRhythm_canDeteriorate)) then {
    private _timeToDeteriorate = 0;

    if (GVAR(AdvRhythm_deteriorateTimeWeight) < GVAR(AdvRhythm_deteriorateTimeWeight)) then {
        _timeToDeteriorate = random [20, GVAR(AdvRhythm_deteriorateTimeWeight), GVAR(AdvRhythm_deteriorateTimeWeight)];
    } else {
        _timeToDeteriorate = random [20, GVAR(AdvRhythm_deteriorateTimeWeight) / 2, GVAR(AdvRhythm_deteriorateTimeWeight)];
    };

    switch (_cardiacArrestType) do {
        case 4: {
            [{
                _unit getVariable [QACEGVAR(medical,bloodVolume), 6.0] < GVAR(AdvRhythm_asystoleBloodlossThreshold) && _unit getVariable [QGVAR(cardiacArrestType), 0] > 2
            },
            {
                private _targetType = 1;
                if (floor (random 100) < GVAR(AdvRhythm_PEAChance)) then {
                    _targetType = 2;
                } else {
                    _targetType = 1;
                };
                _unit setVariable [QGVAR(cardiacArrestType), _targetType, true];
            },
            [_unit], _timeToDeteriorate,
            {
                if (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then { // Don't deteriorate during CPR
                    // chance to deteriorate straight into asystole (PEA)
                    if (GVAR(AdvRhythm_Hardcore_Enable) && {floor (random 100) < GVAR(AdvRhythm_hardcoreDeteriorationChance) && {_unit getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 4}}) then {
                        _unit setVariable [QGVAR(cardiacArrestType), 2, true];
                        [_unit, nil, false] call FUNC(handleCardiacArrest);
                    };

                    if (_unit getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 4) then {
                        _unit setVariable [QGVAR(cardiacArrestType), 3, true];
                        [_unit, nil, false] call FUNC(handleCardiacArrest);
                    };
                } else {
                    [_unit, nil, false] call FUNC(handleCardiacArrest);
                };
            }] call CBA_fnc_waitUntilAndExecute;
        };
        case 3: {
            [{
                _unit getVariable [QACEGVAR(medical,bloodVolume), 6.0] < GVAR(AdvRhythm_asystoleBloodlossThreshold) && _unit getVariable [QGVAR(cardiacArrestType), 0] > 2
            },
            { // If past asystole bloodloss threshold
                private _targetType = 1;
                if (floor (random 100) < GVAR(AdvRhythm_PEAChance)) then {
                    _targetType = 2;
                } else {
                    _targetType = 1;
                };
                _unit setVariable [QGVAR(cardiacArrestType), _targetType, true];
            },
            [_unit], _timeToDeteriorate,
            {
                if (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then { // Don't deteriorate during CPR
                    if (_unit getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 3) then {// if VF skip PEA
                        _unit setVariable [QGVAR(cardiacArrestType), 1, true];
                        [_unit, nil, false] call FUNC(handleCardiacArrest);
                    };
                } else {
                    [_unit, nil, false] call FUNC(handleCardiacArrest);
                };
            }] call CBA_fnc_waitUntilAndExecute;
        };
        case 2: {
            [{
                if (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then { // Don't deteriorate during CPR
                    if (_unit getVariable [QGVAR(cardiacArrestType), 0] isEqualTo 2) then {
                        _unit setVariable [QGVAR(cardiacArrestType), 1, true];
                    };
                } else {
                    [_unit, nil, false] call FUNC(handleCardiacArrest);
                };
            }, [_unit], _timeToDeteriorate] call CBA_fnc_waitAndExecute;
        };
        default {};
    };
};