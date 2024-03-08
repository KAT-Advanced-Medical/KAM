#include "..\script_component.hpp"
/*
 * Author: Blue
 * Begin CPR
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_CPRStart;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QACEGVAR(medical,CPR_provider), _medic, true];
_medic setVariable [QGVAR(isPerformingCPR), true, true];

GVAR(CPRTarget) = _patient;

GVAR(CPRCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(CPRCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

private _CPRStartTime = CBA_missionTime + 2.5;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening

if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;
loopCPR = false;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    loopCPR = true;
};

[{
    params ["_medic", "_patient", "_notInVehicle", "_CPRStartTime"];
    
    [LLSTRING(StopCPR), "", ""] call ACEFUNC(interaction,showMouseHint);
    [LLSTRING(StartCPR), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_notInVehicle", "_CPRStartTime"];

        private _patientCondition = (!(IS_UNCONSCIOUS(_patient)) && alive _patient || _patient isEqualTo objNull);
        private _medicCondition = (!(alive _medic) || IS_UNCONSCIOUS(_medic) || _medic isEqualTo objNull);
        private _vehicleCondition = !(objectParent _medic isEqualTo objectParent _patient);
        private _distanceCondition = (_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance));

        if (_patientCondition || _medicCondition || (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull || !(_medic getVariable [QGVAR(isPerformingCPR), false]) || dialog || {(!_notInVehicle && _vehicleCondition) || {(_notInVehicle && _distanceCondition)}}) exitWith { // Stop CPR
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            _medic setVariable [QGVAR(isPerformingCPR), false, true];

            if !(_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {
                _patient setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
            };

            [] call ACEFUNC(interaction,hideMouseHint);
            [GVAR(CPRCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(CPRCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            if (_notInVehicle) then {
                [_medic, "AinvPknlMstpSnonWnonDnon_medicEnd", 2] call ACEFUNC(common,doAnimation);
            };

            // Format time to minutes:seconds
            private _CPRTime = CBA_missionTime - _CPRStartTime;
            private _time = format ["%1:%2",(["", "0"] select (floor _CPRTime / 3600 - floor _CPRTime / 3600 * 60 < 10)) + str (floor(((_CPRTime/3600) - floor(_CPRTime/3600)) * 60)), (["", "0"] select (floor _CPRTime / 60 - floor _CPRTime / 60 * 60 < 10)) + str (floor(((_CPRTime/60) - floor(_CPRTime/60)) * 60))];

            [_patient, "activity", LSTRING(Activity_CPR), [[_medic, false, true] call ACEFUNC(common,getName), _time]] call ACEFUNC(medical_treatment,addToLog);

            if (CPRStartTime <= CBA_missionTime - 18) then {
                _patient setVariable [QGVAR(OxygenationPeriod), CBA_missionTime, true];
            };

            closeDialog 0;

            [LLSTRING(CancelCPR), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if (loopCPR) then {
            [QACEGVAR(common,switchMove), [_medic, "kat_CPR"]] call CBA_fnc_globalEvent;
            loopCPR = false;

            [{
                params ["_medic"];

                !(_medic getVariable [QGVAR(isPerformingCPR), false]);
            }, {}, [_medic], 9, {
                loopCPR = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _notInVehicle, _CPRStartTime]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient, _notInVehicle, _CPRStartTime], 2.1] call CBA_fnc_waitAndExecute;


[{
    params ["_medic", "_patient"];
    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient"];

        if ((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        [_medic, _patient] call FUNC(cprSuccess);
    }, GVAR(CPR_ChanceInterval), [_medic, _patient]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient], GVAR(CPR_ChanceInterval) + 2.5] call CBA_fnc_waitAndExecute;

if (_patient getVariable [QGVAR(RhythmAnalyzed), false]) then {
    [{
        params ["_medic", "_patient"];

        if(!((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) && _patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && !(_patient getVariable [QGVAR(DefibrillatorInUse), false])) then {
            private _provider = _patient getVariable QGVAR(Defibrillator_Provider);
            private _source = _medic;

            switch (_provider select 1) do {
                case 1: {
                    _source = _provider select 0;
                };
                case 2: {
                    _source = _patient;
                };
                default {};
            };

            playSound3D [QPATHTOF_SOUND(sounds\checkpulse_nopulsepushanalyze.wav), _source, false, getPosASL _source, 6, 1, 15];
        };
    }, [_medic, _patient], 122.5] call CBA_fnc_waitAndExecute;
};
