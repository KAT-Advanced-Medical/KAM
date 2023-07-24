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

GVAR(CPRTarget) = _patient;

GVAR(CPRCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(CPRCancel_MouseID) = [0xF0, [false, false, false], { // 0xF1
    GVAR(CPRTarget) setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

CPRTime = -5;

private _inVehicle = vehicle _medic isEqualTo _medic;

if (_inVehicle) then {
    _medic playMoveNow "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic";
    loopCPR = true;
} else {
    loopCPR = false; 
};

[{
    params ["_medic", "_patient", "_inVehicle"];

    ["Stop CPR", "", ""] call ACEFUNC(interaction,showMouseHint);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_inVehicle"];
    
        if (!(alive _medic) || IS_UNCONSCIOUS(_medic) || (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) exitWith {
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

            // Format time to minutes:seconds
            private _time = format ["%1:%2",(if ((floor(((CPRTime/3600) - floor(CPRTime/3600)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((CPRTime/3600) - floor(CPRTime/3600)) * 60)), (if ((floor(((CPRTime/60) - floor(CPRTime/60)) * 60)) < 10) then { "0" } else { "" }) + str (floor(((CPRTime/60) - floor(CPRTime/60)) * 60))];

            [_patient, "activity", LSTRING(Activity_CPR), [[_medic, false, true] call ACEFUNC(common,getName), _time]] call ACEFUNC(medical_treatment,addToLog);
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
    params ["_args", "_idPFH"];
    _args params ["_medic", "_patient"];

    if ((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]) isEqualTo objNull) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    [_medic, _patient] call FUNC(cprSuccess);
    CPRTime = CPRTime + 5;
}, 5, [_medic, _patient]] call CBA_fnc_addPerFrameHandler;