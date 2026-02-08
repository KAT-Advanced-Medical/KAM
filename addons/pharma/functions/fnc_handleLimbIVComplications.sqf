#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles advanced IV complications
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: The Bodypart <number>
 * 2: flowDifference (difference in fluid between the cap and the actual)<Number>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftLeg", 2] call kat_pharma_fnc_handleLimbIVComplications
 *
 * Public: No
 */

 params ["_patient", "_partIndex", "_incomingFlowDifference"];

 private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
 private _bodyPart = ALL_BODY_PARTS select _partIndex;
 if (_bodypart == "Chest") then {
    [_patient, 0.7] call ACEFUNC(medical_status,adjustPainLevel);
 } else {
    switch (true) do
    {
        case (_incomingFlowDifference < 2): {
            if (random(100) < 10) then {
                [_patient, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
                [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);
            };
        };
        case ((_incomingFlowDifference < 4) && (_incomingFlowDifference >= 2)): {
            if (random(100) < 35) then {
                [_patient, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
                [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);
            };

            if (random(100) < 10) then {
                _IVarray set [_partIndex, 15];
                _patient setVariable [QGVAR(IV), _IVarray, true];
                [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);

                [{
                    params ["_patient", "_IVarray", "_partIndex"];
                    _IVarray set [_partIndex, 0]; _patient setVariable [QGVAR(IV), _IVarray, true];
                }, [_patient, _IVarray, _partIndex], 180] call CBA_fnc_waitAndExecute;
            };
        };
        case ((_incomingFlowDifference < 7) && (_incomingFlowDifference >= 4)): {
            if (random(100) < 60) then {
                [_patient, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
                [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);
            };

            if (random(100) < 30) then {
                _IVarray set [_partIndex, 15];
                _patient setVariable [QGVAR(IV), _IVarray, true];
                [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);

                [{
                    params ["_patient", "_IVarray", "_partIndex"];
                    _IVarray set [_partIndex, 0]; _patient setVariable [QGVAR(IV), _IVarray, true];
                }, [_patient, _IVarray, _partIndex], 180] call CBA_fnc_waitAndExecute;
            };
        };
        case (_incomingFlowDifference >= 7): {
            [_patient, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
            [objNull, _patient, _bodypart] call EFUNC(pharma,retrieveIV);

            _IVarray set [_partIndex, 15];
            _patient setVariable [QGVAR(IV), _IVarray, true];

            [{
                params ["_patient", "_IVarray", "_partIndex"];
                _IVarray set [_partIndex, 0]; _patient setVariable [QGVAR(IV), _IVarray, true];
            }, [_patient, _IVarray, _partIndex], 180] call CBA_fnc_waitAndExecute;
        };
    };
};