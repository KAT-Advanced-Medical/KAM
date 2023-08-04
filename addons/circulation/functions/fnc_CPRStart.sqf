#include "script_component.hpp"
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

GVAR(CPRCancel_MouseID) = [0xF1, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

CPRStartTime = CBA_missionTime + 2.5;

private _inVehicle = vehicle _medic isEqualTo _medic;

if (_inVehicle) then {
    _medic playMoveNow "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic";
    loopCPR = true;
} else {
    loopCPR = false; 
};

[{
    params ["_medic", "_patient", "_inVehicle"];

    ["", LLSTRING(StopCPR), ""] call ACEFUNC(interaction,showMouseHint);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_inVehicle"];
    
        if (!(alive _medic) || IS_UNCONSCIOUS(_medic) || !(IS_UNCONSCIOUS(_patient)) || (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) exitWith { // Stop CPR
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            if(_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo _medic) then {
                _patient setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
            };

            [] call ACEFUNC(interaction,hideMouseHint);
            [GVAR(CPRCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(CPRCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            if (_inVehicle) then {
                _medic switchMove "AinvPknlMstpSnonWnonDnon_medicEnd";
            };

            _medic setVariable [QGVAR(isPerformingCPR), false, true];

            // Format time to minutes:seconds
            private _CPRTime = CBA_missionTime - CPRStartTime;
            private _time = format ["%1:%2",(if ((floor(((_CPRTime/3600) - floor(_CPRTime/3600)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((_CPRTime/3600) - floor(_CPRTime/3600)) * 60)), (if ((floor(((_CPRTime/60) - floor(_CPRTime/60)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((_CPRTime/60) - floor(_CPRTime/60)) * 60))];

            [_patient, "activity", LSTRING(Activity_CPR), [[_medic, false, true] call ACEFUNC(common,getName), _time]] call ACEFUNC(medical_treatment,addToLog);

            if (CPRStartTime <= CBA_missionTime - 18) then {
                _patient setVariable [QGVAR(OxygenationPeriod), CBA_missionTime, true];
            };
        };

        if (loopCPR) then {
            _medic switchMove "kat_CPR";
            loopCPR = false;

            [{
                params ["_patient"];

                if !((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) then {
                    loopCPR = true;
                };
            }, [_patient], 9] call CBA_fnc_waitAndExecute;
        };
    }, 0, [_medic, _patient, _inVehicle]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient, _inVehicle], 2.1] call CBA_fnc_waitAndExecute;

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