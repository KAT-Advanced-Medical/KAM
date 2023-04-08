#include "script_component.hpp"
/*
 * Author: Blue
 * Handles BVM usage.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_useBVM;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient"];
    if !(_patient getVariable [QGVAR(BVMInUse), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (_patient getVariable [QGVAR(portableOxygenTankConnected), false]) then {
        if !(isNull (_patient getVariable QGVAR(oxygenTankProvider))) then {
            private _oxygenProvider = _patient getVariable QGVAR(oxygenTankProvider);

            private _carriedTanks = [];

            {
                if(_x select 0 in ["kat_oxygenTank_150","kat_oxygenTank_300"]) then {
                    _carriedTanks pushBack _x;
                };
            } forEach magazinesAmmo _oxygenProvider;

            if(count _carriedTanks > 0) then {
                private _tank = _carriedTanks select (count _carriedTanks - 1);
                private _tankClassName = (_tank select 0);
                private _oxygenLeft = (_tank select 1) - 1;
                if(_oxygenLeft > 0) then {
                _oxygenProvider removeMagazine _tankClassName;
                _oxygenProvider addMagazine [_tankClassName, _oxygenLeft];
                } else {
                    _oxygenProvider addItem [_tankClassName,"Empty"] joinString "_";
                };
            } else {
                _patient setVariable [QGVAR(portableOxygenTankConnected), false, false];
            };

        } else {
            _patient setVariable [QGVAR(portableOxygenTankConnected), false, false];
        };
    };

    /*if(_patient getVariable [QGVAR(pocketBVM), false]) then {
        playsound3D [QPATHTOF_SOUND(sounds\squeeze_pocketBVM.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
    } else {
        if(_patient getVariable [QGVAR(BVM), false] && _patient getVariable [QGVAR(portableOxygenTankConnected), false]) then {
            playsound3D [QPATHTOF_SOUND(sounds\squeeze_BVMOxygen.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
        } else {
            playsound3D [QPATHTOF_SOUND(sounds\squeeze_BVM.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
        };
    };*/
}, 3, [_medic,_patient]] call CBA_fnc_addPerFrameHandler;