#include "..\script_component.hpp"
/*
 * Author: Blue
 * Begin head turning
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_startHeadTurning;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(headTurningActive), true, true];

GVAR(headTurnTarget) = _patient;

GVAR(HeadTurnCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(headTurnTarget) setVariable [QGVAR(headTurningActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(HeadTurnCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(headTurnTarget) setVariable [QGVAR(headTurningActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening

if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;

GVAR(headTurning_attempts) = 0;
GVAR(loopHeadturning) = false;
GVAR(continueHeadturning) = true;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    GVAR(loopHeadturning) = true;
};

GVAR(headTurn_timeOut) = true;

[{
    params ["_medic", "_patient", "_notInVehicle"];

    [LLSTRING(headTurning_stop), "", ""] call ACEFUNC(interaction,showMouseHint);
    [LLSTRING(headTurning_start), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_notInVehicle"];

        private _patientCondition = (!(IS_UNCONSCIOUS(_patient)) && alive _patient || _patient isEqualTo objNull);
        private _medicCondition = (!(alive _medic) || IS_UNCONSCIOUS(_medic) || _medic isEqualTo objNull);
        private _vehicleCondition = !(objectParent _medic isEqualTo objectParent _patient);
        private _distanceCondition = (_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance));

        if (_patientCondition || _medicCondition || !(_patient getVariable [QGVAR(headTurningActive), false]) || dialog || {(!_notInVehicle && _vehicleCondition) || {(_notInVehicle && _distanceCondition)}}) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            [] call ACEFUNC(interaction,hideMouseHint);

            [GVAR(HeadTurnCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(HeadTurnCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            if (_notInVehicle) then {
                [QACEGVAR(common,switchMove), [_medic, "AinvPknlMstpSnonWnonDnon_medicEnd"]] call CBA_fnc_globalEvent;
            };

            closeDialog 0;

            [_patient, "activity", LSTRING(Activity_HeadTurning), [[_medic, false, true] call ACEFUNC(common,getName), GVAR(headTurning_attempts)]] call ACEFUNC(medical_treatment,addToLog);

            [LLSTRING(headTurning_cancelled), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if !(GVAR(headTurn_timeOut)) then {
            GVAR(headTurn_timeOut) = true;

            [{
                params ["_patient"];

                !(_patient getVariable [QGVAR(headTurningActive), false]);
            }, {}, [_patient, _medic], GVAR(HeadTurn_Interval),
            {
                params ["_patient", "_medic"];

                GVAR(headTurn_timeOut) = false;
                GVAR(headTurning_attempts) = GVAR(headTurning_attempts) + 1;

                if (_patient getVariable [QGVAR(occluded), false]) then {
                    if(random 100 < GVAR(probability_headturning)) then {
                        _patient setVariable [QGVAR(occluded), false, true];
                        if (GVAR(occlusion_cooldownPeriod) > 0) then {
                            _patient setVariable [QGVAR(clearedTime), CBA_missionTime, true];
                        };
                        [LLSTRING(headTurning_success), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                    } else {
                        [LLSTRING(headTurning_info), 2, _medic] call ACEFUNC(common,displayTextStructured);
                    };
                } else {
                    [LLSTRING(headTurning_success), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                };

            }] call CBA_fnc_waitUntilAndExecute;
        };

        if (GVAR(loopHeadturning)) then {
            [QACEGVAR(common,switchMove), [_medic, "kat_headTurn"]] call CBA_fnc_globalEvent;
            GVAR(loopHeadturning) = false;

            [{
                params ["_patient"];
                !(_patient getVariable [QGVAR(headTurningActive), false]);
            }, {}, [_patient], 7.6, {
                GVAR(loopHeadturning) = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _notInVehicle]] call CBA_fnc_addPerFrameHandler;

    [{GVAR(headTurn_timeOut) = false;}, [], 1] call CBA_fnc_waitAndExecute;
}, [_medic, _patient, _notInVehicle], 2] call CBA_fnc_waitAndExecute;
