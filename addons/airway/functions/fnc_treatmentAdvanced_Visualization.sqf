#include "..\script_component.hpp"
/*
 * Author: Blue
 * Play visualization Devices sound
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Head"] call kat_airway_fnc_treatmentAdvanced_Visualization;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart"];

_patient setVariable [QGVAR(visualizationActive), true, true];

GVAR(visualizationTarget) = _patient;

GVAR(visualizationCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(visualizationTarget) setVariable [QGVAR(visualizationActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(visualizationCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(visualizationTarget) setVariable [QGVAR(visualizationActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening

if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;

GVAR(visualization_attempts) = 0;
GVAR(loopvisualization) = false;
GVAR(continuevisualization) = true;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    GVAR(loopvisualization) = true;
};

GVAR(visualization_timeOut) = true;

[{
    params ["_medic", "_patient", "_notInVehicle"];

    [LLSTRING(visualization_stop), "", ""] call ACEFUNC(interaction,showMouseHint);
    [LLSTRING(visualization_start), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_notInVehicle"];

        private _patientCondition = (!(IS_UNCONSCIOUS(_patient)) && alive _patient || _patient isEqualTo objNull);
        private _medicCondition = (!(alive _medic) || IS_UNCONSCIOUS(_medic) || _medic isEqualTo objNull);
        private _vehicleCondition = (objectParent _medic isNotEqualTo objectParent _patient);
        private _distanceCondition = (_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance));
        

        if (_patientCondition || _medicCondition || !(_patient getVariable [QGVAR(visualizationActive), false]) || dialog || {(!_notInVehicle && _vehicleCondition) || {(_notInVehicle && _distanceCondition)}}) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            [] call ACEFUNC(interaction,hideMouseHint);

            [GVAR(visualizationCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(visualizationCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            closeDialog 0;
            [_patient, "activity", LSTRING(Activity_visualization), [[_medic, false, true] call ACEFUNC(common,getName), GVAR(visualization_attempts)]] call ACEFUNC(medical_treatment,addToLog);

            [LLSTRING(visualization_cancelled), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if !(GVAR(visualization_timeOut)) then {
            GVAR(visualization_timeOut) = true;

            [{
                params ["_patient"];

                !(_patient getVariable [QGVAR(visualizationActive), false]);
            }, {}, [_patient, _medic], GVAR(visualization_Interval),
            {
                params ["_patient", "_medic"];

                GVAR(visualization_timeOut) = false;
                GVAR(visualization_attempts) = GVAR(visualization_attempts) + 1;

                if (((_patient getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x < 1 }) != -1) then {
                    if(random 100 < (GVAR(probability_visualization) * 1/*_visualizationDifficulty*/)) then {
                        _patient setVariable [QGVAR(isVisualized), true, true];
                        private _canTreat = [_medic, _patient, "Head", "ETT"] call ACEFUNC(medical_treatment,canTreat);
                            if (_canTreat) then {
                                GVAR(PlaceETT) = [0xF1, [false, false, false], {
                                [_medic, _patient, "Head", "ETT"] call ACEFUNC(medical_treatment,treatment);
                                _patient setVariable [QGVAR(visualizationActive), false, true];
                                [GVAR(PlaceETT), "keydown"] call CBA_fnc_removeKeyHandler;
                                }, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;
                            };
                        [{_patient setVariable [QGVAR(isVisualized), false, true]; }, [_patient], 60] call CBA_fnc_waitAndExecute;
                        [LLSTRING(visualization_success), 2, _medic] call ACEFUNC(common,displayTextStructured);
                    } else {
                        [LLSTRING(visualization_info), 2, _medic] call ACEFUNC(common,displayTextStructured);
                    };
                } else {
                    [LLSTRING(visualization_failure), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                };

            }] call CBA_fnc_waitUntilAndExecute;
        };

        if (GVAR(loopvisualization)) then {
            GVAR(loopvisualization) = false;
            [{
                params ["_patient"];
                !(_patient getVariable [QGVAR(visualizationActive), false]);
            }, {}, [_patient], 7.6, {
                GVAR(loopvisualization) = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _notInVehicle]] call CBA_fnc_addPerFrameHandler;

    [{GVAR(visualization_timeOut) = false;}, [], 1] call CBA_fnc_waitAndExecute;
}, [_medic, _patient, _notInVehicle], 2] call CBA_fnc_waitAndExecute;

