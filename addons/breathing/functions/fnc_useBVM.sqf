#include "script_component.hpp"
/*
 * Author: Blue
 * Handles BVM usage.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Is pocket BVM <BOOL>
 * 3: Use oxygen <BOOL>
 * 4: Oxygen origin <INT>
 *   0: Medical vehicle/facility
 *   1: Medic carried
 *   2: Vehicle stored
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, true, false, false] call kat_breathing_fnc_useBVM;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_pocket", false], ["_useOxygen", false], ["_oxygenOrigin", 0]];

_patient setVariable [QGVAR(BVMInUse), true, true];

GVAR(BVMTarget) = _patient;

GVAR(CPRCancel_EscapeID) = [0x01, [false, false, false], {
    GVAR(BVMTarget) setVariable [QGVAR(BVMInUse), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

GVAR(CPRCancel_MouseID) = [0xF0, [false, false, false], {
    GVAR(BVMTarget) setVariable [QGVAR(BVMInUse), false, true];
}, "keydown", "", false, 0] call CBA_fnc_addKeyHandler;

ACEGVAR(medical_gui,pendingReopen) = false; // Prevent medical menu from reopening
 
if (dialog) then { // If another dialog is open (medical menu) close it
    closeDialog 0;
};

private _notInVehicle = isNull objectParent _medic;
totalProvided = 1;
loopBVM = false;

if (_notInVehicle) then {
    [_medic, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic", 1] call ACEFUNC(common,doAnimation);
    loopBVM = true;
};

timeOut = true;

[{
    params ["_medic", "_patient", "_pocket", "_useOxygen", "_oxygenOrigin", "_notInVehicle"];

    [LLSTRING(UseBVM_PutAway), "", ""] call ACEFUNC(interaction,showMouseHint);
    [{
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_pocket", "_useOxygen", "_oxygenOrigin", "_notInVehicle"];

        if (!(alive _medic) || IS_UNCONSCIOUS(_medic) || !(IS_UNCONSCIOUS(_patient)) || !(_patient getVariable [QGVAR(BVMInUse), false]) || dialog || {!(objectParent _medic isEqualTo objectParent _patient) || {_patient distance2D _medic > ACEGVAR(medical_gui,maxDistance)}}) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;

            _patient setVariable [QGVAR(BVMInUse), false, true];
            _patient setVariable [QGVAR(oxygenTankConnected), false, true];

            [] call ACEFUNC(interaction,hideMouseHint);

            [GVAR(CPRCancel_EscapeID), "keydown"] call CBA_fnc_removeKeyHandler;
            [GVAR(CPRCancel_MouseID), "keydown"] call CBA_fnc_removeKeyHandler;

            if (_notInVehicle) then {
                [_medic, "AinvPknlMstpSnonWnonDnon_medicEnd", 2] call ACEFUNC(common,doAnimation);
            };

            closeDialog 0;

            private _bvmType = "";

            if (_pocket) then {
                _bvmType = LLSTRING(PocketBVM_Display);
            } else {
                _bvmType = LLSTRING(BVM_Display);
            };

            if (_useOxygen) then {
                _bvmType = format [LLSTRING(Activity_BVM_Oxygenated), _bvmType];
            };

            [_patient, "activity", LSTRING(Activity_BVM), [[_medic, false, true] call ACEFUNC(common,getName), _bvmType, totalProvided]] call ACEFUNC(medical_treatment,addToLog);
            [LLSTRING(UseBVM_Cancelled), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        };

        if !(timeOut) then {
            timeOut = true;
            
            if (_useOxygen && !_pocket) then {
                switch (_oxygenOrigin) do {
                    case 1: { // Medic provided oxygen with carried oxygen tank
                        private _carriedTanks = [];
                        private _heldPreferredTanks = [];
                        private _medicPreferredTank = _medic getVariable [QGVAR(oxygenTankPreferred), ""];

                        if(_medicPreferredTank != "") then { // Handle preferred medic oxygen tank
                            {
                                if(_x select 0 == _medicPreferredTank) then {
                                    _heldPreferredTanks pushBack _x;
                                };
                            } forEach magazinesAmmo _medic;

                            if (count _heldPreferredTanks > 0) then {
                                _carriedTanks = _heldPreferredTanks;
                            };
                        } else {
                            {
                                if(_x select 0 in ["kat_oxygenTank_150","kat_oxygenTank_300"]) then {
                                    _carriedTanks pushBack _x;
                                };
                            } forEach magazinesAmmo _medic;
                        };

                        if (count _carriedTanks > 0) then {
                            _patient setVariable [QGVAR(oxygenTankConnected), true, true];

                            private _tank = _carriedTanks select (count _carriedTanks - 1);
                            _tank params ["_tankClassName", "_oxygenLeft"];

                            if(_oxygenLeft > 1) then {
                                _medic removeMagazine _tankClassName;
                                _medic addMagazine [_tankClassName, _oxygenLeft - 1];
                            } else {
                                _medic removeMagazine _tankClassName;
                                _medic addItem ([_tankClassName,"Empty"] joinString "_");
                                [LLSTRING(PortableOxygenTankDisconnected_Empty), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                            };
                        } else {
                            _patient setVariable [QGVAR(oxygenTankConnected), false, true];
                        };
                    };
                    case 2: { // Vehicle provided with stored oxygen tank
                        private _vehicle = objectParent _patient;

                        private _oxygenTanks = [];

                        {
                            if((_x select 0) in ["kat_oxygenTank_150","kat_oxygenTank_300"]) then {
                                _oxygenTanks append [_x];
                            };
                        } forEach (magazinesAmmoCargo _vehicle);

                        if (count _oxygenTanks > 0) then {
                            _patient setVariable [QGVAR(oxygenTankConnected), true, true];

                            private _tank = _oxygenTanks select (count _oxygenTanks - 1);
                            _tank params ["_tankClassName", "_oxygenLeft"];

                            if (_oxygenLeft > 1) then {
                                [_vehicle, _tankClassName, true] call EFUNC(misc,removeItemFromVehicle);
                            } else {
                                _vehicle addItemCargoGlobal [[_tankClassName,"Empty"] joinString "_", 1];
                                [LLSTRING(PortableOxygenTankDisconnected_Empty), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                            };
                        } else {
                            _patient setVariable [QGVAR(oxygenTankConnected), false, true];
                        };
                    };
                    default { // Medical vehicle/facility provided
                        _patient setVariable [QGVAR(oxygenTankConnected), true, true];
                    };
                };
            } else {
                _patient setVariable [QGVAR(oxygenTankConnected), false, true];
            };

            playsound3D [QPATHTOF_SOUND(audio\squeeze_BVM.ogg), _patient, false, getPosASL _patient, 8, 1, 15];

            [{ // Squeeze BVM every 5 seconds
                params ["_patient"];

                !(_patient getVariable [QGVAR(BVMInUse), false]);
            }, {}, [_patient], 5, 
            {
                timeOut = false;
                totalProvided = totalProvided + 1;
            }] call CBA_fnc_waitUntilAndExecute;
        };
        
        if (loopBVM) then {
            [QACEGVAR(common,switchMove), [_medic, "kat_BVM"]] call CBA_fnc_globalEvent;
            loopBVM = false;

            [{
                params ["_patient"];
                !(_patient getVariable [QGVAR(BVMInUse), false]);
            }, {}, [_patient], 9, {
                loopBVM = true;
            }] call CBA_fnc_waitUntilAndExecute;
        };
    }, 0, [_medic, _patient, _pocket, _useOxygen, _oxygenOrigin, _notInVehicle]] call CBA_fnc_addPerFrameHandler;

    [{timeOut = false;}, [], 1] call CBA_fnc_waitAndExecute;
}, [_medic, _patient, _pocket, _useOxygen, _oxygenOrigin, _notInVehicle], 2] call CBA_fnc_waitAndExecute;