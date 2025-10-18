#include "..\script_component.hpp"
/*
 * Author: Blue
 * Play Suction Devices sound
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
 * [player, cursorTarget, "Head", "Accuvac", objNull, "kat_accuvac"] call kat_airway_fnc_treatmentAdvanced_AccuvacStart;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

if !(((_patient getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x != 0 }) != -1) exitWith {
    private _output = LLSTRING(Accuvac_NA);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    if (_usedItem isEqualTo "kat_suction" && GVAR(Suction_reuse)) then {
        [_medic, "kat_suction"] call ACEFUNC(common,addToInventory);
    };
};

_patient setVariable [QGVAR(suctionActive), true, true];

GVAR(suctionTarget) = _patient;

GVAR(suctionCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(suctionTarget) setVariable [QGVAR(suctionActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(suctionCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(suctionTarget) setVariable [QGVAR(suctionActive), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening

if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;

GVAR(suction_attempts) = 0;
GVAR(loopSuction) = false;
GVAR(continueSuction) = true;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    GVAR(loopSuction) = true;
};

GVAR(suction_timeOut) = true;

[{
    params ["_medic", "_patient", "_notInVehicle", "_usedItem"];

    [LLSTRING(suction_stop), "", ""] call ACEFUNC(interaction,showMouseHint);
    [LLSTRING(suction_start), 1.5, _medic] call ACEFUNC(common,displayTextStructured);

    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_notInVehicle", "_usedItem"];

        private _patientCondition = (!(IS_UNCONSCIOUS(_patient)) && alive _patient || _patient isEqualTo objNull);
        private _medicCondition = (!(alive _medic) || IS_UNCONSCIOUS(_medic) || _medic isEqualTo objNull);
        private _vehicleCondition = (objectParent _medic isNotEqualTo objectParent _patient);
        private _distanceCondition = (_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance));
        

        if (_patientCondition || _medicCondition || !(_patient getVariable [QGVAR(suctionActive), false]) || dialog || {(!_notInVehicle && _vehicleCondition) || {(_notInVehicle && _distanceCondition)}}) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            [] call ACEFUNC(interaction,hideMouseHint);

            [GVAR(suctionCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(suctionCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            closeDialog 0;
            if (_usedItem isEqualTo "kat_suction" && GVAR(Suction_reuse)) then {
                [_medic, "kat_suction"] call ACEFUNC(common,addToInventory);
            };

            [_patient, "activity", LSTRING(Activity_Suction), [[_medic, false, true] call ACEFUNC(common,getName), GVAR(suction_attempts)]] call ACEFUNC(medical_treatment,addToLog);

            [LLSTRING(Suction_cancelled), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if !(GVAR(suction_timeOut)) then {
            GVAR(suction_timeOut) = true;

            [{
                params ["_patient"];

                !(_patient getVariable [QGVAR(suctionActive), false]);
            }, {}, [_patient, _medic, _usedItem], GVAR(Suction_Interval),
            {
                params ["_patient", "_medic", "_usedItem"];

                GVAR(suction_timeOut) = false;
                GVAR(suction_attempts) = GVAR(suction_attempts) + 1;
                if (((_patient getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x > 1 }) != -1) then {
                    if(random 100 < GVAR(probability_suction)) then {
                        private _occlusionState = _patient getVariable [QGVAR(occlusion), [0, 0, 0]];
                            private _reduction = floor (selectRandom [1, 2, 3] * GVAR(SuctionEffectiveness));
                            _occlusionState set [0, (((_occlusionState select 0) - _reduction) max 0)];
                            _occlusionState set [1, (((_occlusionState select 1) - _reduction) max 0)];
                            _occlusionState set [2, (((_occlusionState select 2) - _reduction) max 0)];
                            _patient setVariable [QGVAR(occlusion), _occlusionState, true];
                        [LLSTRING(suction_info), 2, _medic] call ACEFUNC(common,displayTextStructured);
                    } else {
                        [LLSTRING(suction_info), 2, _medic] call ACEFUNC(common,displayTextStructured);
                    };
                    if (_usedItem isEqualTo "kat_suction") then {
                        _soundID = playSound3D [QPATHTOF_SOUND(sounds\manualpump_suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];
                    } else {
                        _soundID = playSound3D [QPATHTOF_SOUND(sounds\accuvac_suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];
                    };
                } else {
                    [LLSTRING(suction_success), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                    if (_usedItem isEqualTo "kat_suction") then {
                            _soundID = playSound3D [QPATHTOF_SOUND(sounds\manualpump_start.wav), _patient, false, getPosASL _patient, 6, 1, 15];
                        } else {
                            _soundID = playSound3D [QPATHTOF_SOUND(sounds\accuvac_start.wav), _patient, false, getPosASL _patient, 6, 1, 15];
                        };
                };

            }] call CBA_fnc_waitUntilAndExecute;
        };

        if (GVAR(loopSuction)) then {
            GVAR(loopSuction) = false;
            [{
                params ["_patient"];
                !(_patient getVariable [QGVAR(suctionActive), false]);
            }, {}, [_patient], 7.6, {
                GVAR(loopSuction) = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _notInVehicle, _usedItem]] call CBA_fnc_addPerFrameHandler;

    [{GVAR(suction_timeOut) = false;}, [], 1] call CBA_fnc_waitAndExecute;
}, [_medic, _patient, _notInVehicle, _usedItem], 2] call CBA_fnc_waitAndExecute;

