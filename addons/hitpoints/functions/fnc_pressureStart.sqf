#include "..\script_component.hpp"
/*
 * Author: Blue/ Modified for use by Cplhardcore
 * Begin CPR
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Bodypart
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "leftleg"] call kat_hitpoints_fnc_PressureStart;
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodypart"];
TRACE_3("Pressure0",_medic,_patient,_bodypart);
_patient setVariable [QGVAR(applyingPressure), _medic, true];
_medic setVariable [QGVAR(isApplyingPressure), true, true];

GVAR(PressureTarget) = _patient;
GVAR(PressureProvider) = _medic;

GVAR(PressureCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(PressureTarget) setVariable [QGVAR(applyingPressure), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(PressureCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(PressureTarget) setVariable [QGVAR(applyingPressure), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening

if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;
loopPressure = false;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    loopPressure = true;
};

[{
    params ["_medic", "_patient", "_bodypart", "_notInVehicle"];

    [LLSTRING(StopPressure), "", ""] call ACEFUNC(interaction,showMouseHint);
    [LLSTRING(StartPressure), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_bodypart", "_notInVehicle"];

        private _patientCondition = (!(alive _patient) || _patient isEqualTo objNull);
        private _medicCondition = (!(alive _medic) || IS_UNCONSCIOUS(_medic) || _medic isEqualTo objNull);
        private _vehicleCondition = (objectParent _medic isNotEqualTo objectParent _patient);
        private _distanceCondition = (_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance));
        TRACE_4("conditionsforPressure",_patientCondition,_medicCondition,_vehicleCondition,_distanceCondition);

        if (_patientCondition || _medicCondition || (_patient getVariable [QGVAR(applyingPressure), objNull]) isEqualTo objNull || !(_medic getVariable [QGVAR(isApplyingPressure), false]) || dialog || {(!_notInVehicle && _vehicleCondition) || {(_notInVehicle && _distanceCondition)}}) exitWith { // Stop Pressure
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            _medic setVariable [QGVAR(isApplyingPressure), false, true];

            if (_patient getVariable [QGVAR(applyingPressure), objNull] isNotEqualTo objNull) then {
                _patient setVariable [QGVAR(applyingPressure), objNull, true];
            };

            [] call ACEFUNC(interaction,hideMouseHint);
            [GVAR(PressureCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(PressureCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            if (_notInVehicle) then {
                [_medic, "AinvPknlMstpSnonWnonDnon_medicEnd", 2] call ACEFUNC(common,doAnimation);
            };

            closeDialog 0;
            private _part = ALL_BODY_PARTS find toLower _bodyPart;
            private _appliedPressure = GET_APPLIEDPRESSURE(_patient);
            _appliedPressure set [_part, 0];
            _patient setVariable [VAR_APPLIEDPRESSURE, _appliedPressure, true];
            TRACE_1("Pressure1",_appliedPressure);
            [LLSTRING(CancelPressure), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if (loopPressure) then {
            loopPressure = false;

            [{
                params ["_medic"];

                !(_medic getVariable [QGVAR(isApplyingPressure), false]);
            }, {}, [_medic], 9, {
                loopPressure = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _bodypart, _notInVehicle]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient, _bodypart, _notInVehicle], 0.2] call CBA_fnc_waitAndExecute;


[{
    params ["_medic", "_patient", "_bodypart"];
    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_bodypart"];

        if ((_patient getVariable [QGVAR(applyingPressure), objNull]) isEqualTo objNull) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _part = ALL_BODY_PARTS find toLower _bodyPart;
        private _appliedPressure = GET_APPLIEDPRESSURE(_patient);
        private _randomPressureAmmount = selectRandom [0.3, 0.4, 0.5, 0.6, 0.7];
        _appliedPressure set [_part, _randomPressureAmmount];
        _patient setVariable [VAR_APPLIEDPRESSURE, _appliedPressure, true];
        TRACE_2("Pressure3",_appliedPressure,_randomPressureAmmount);
    }, 0.5, [_medic, _patient, _bodypart]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient, _bodypart], 0.2] call CBA_fnc_waitAndExecute;
