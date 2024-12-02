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
GVAR(CPRProvider) = _medic;
GVAR(CPRDisplayActive) = false;
GVAR(PulseOxDisplay) = false;

GVAR(CPRCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(CPRCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(CPRDevice_Iterate) = [0xF1, [false, false, false], {
    private _deviceCode = GVAR(CPRTarget) getVariable [QGVAR(deviceCode), 0];
    _deviceCode = [(_deviceCode + 1), 1] select (_deviceCode == 2);
    private _deviceArray = [true,(GVAR(CPRTarget) getVariable [QEGVAR(breathing,pulseoximeter), false]),((GVAR(CPRTarget) getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) || (GVAR(CPRTarget) getVariable [QGVAR(DefibrillatorPads_Connected), false]))];
        while { !(_deviceArray select _deviceCode) } do {
            _deviceCode = [0, (_deviceCode + 1)] select (_deviceCode < 2);
        };
    GVAR(CPRTarget) setVariable [QGVAR(deviceCode), _deviceCode, true];
    true
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
    params ["_args", "_idPFH"];
    _args params ["_medic", "_patient"];

    private _deviceCode = _patient getVariable [QGVAR(deviceCode), 0];

    if ((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        GVAR(CPRDisplayActive) = false;
        GVAR(PulseOxDisplay) = false;

        "CPR_MONITOR" cutText ["", "PLAIN",0,true];
        _patient setVariable [QGVAR(deviceCode), 0, true];
    };
    
    switch (true) do {
        case (_deviceCode == 2): {
            if ((_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) || (_patient getVariable [QGVAR(DefibrillatorPads_Connected), false])) then {
                if !(GVAR(CPRDisplayActive)) then {
                    "CPR_MONITOR" cutText ["", "PLAIN",0,true];
                    "CPR_MONITOR" cutRsc ["CPR_AED_X", "PLAIN", 0, true];
                    GVAR(CPRDisplayActive) = true;
                    [_medic, GVAR(CPRTarget)] call FUNC(AEDX_ViewMonitor_CPR);
                };
            } else {
                "CPR_MONITOR" cutText ["", "PLAIN",0,true];
                GVAR(CPRDisplayActive) = false;
            };
        };
        case (_deviceCode == 1): { 
            if ((_patient getVariable [QEGVAR(breathing,pulseoximeter), false])) then {
                if !(GVAR(PulseOxDisplay)) then {
                    "CPR_MONITOR" cutText ["", "PLAIN",0,true];
                    "CPR_MONITOR" cutRsc ["CPR_PulseOx", "PLAIN", 0, true]; 
                    GVAR(PulseOxDisplay) = true;
                    [_medic, GVAR(CPRTarget)] call FUNC(PulseOx_ViewMonitor);
                };
            } else {
                "CPR_MONITOR" cutText ["", "PLAIN",0,true];
                GVAR(PulseOxDisplay) = false;
            };
        };
        case (_deviceCode == 0): { "CPR_MONITOR" cutText ["", "PLAIN"]; GVAR(PulseOxDisplay) = false; GVAR(CPRDisplayActive) = false;};
    };
}, 2, [_medic, _patient]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_medic", "_patient", "_notInVehicle", "_CPRStartTime"];
    
    [LLSTRING(StopCPR), LLSTRING(ChangeCPRDevice), ""] call ACEFUNC(interaction,showMouseHint);
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
            [GVAR(CPRDevice_Iterate), "keydown"] call CBA_fnc_removeKeyHandler;

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
