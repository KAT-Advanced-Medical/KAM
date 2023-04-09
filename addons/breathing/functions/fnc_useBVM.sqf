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
 * 4: Oxygen is carred by medic <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, true, false] call kat_breathing_fnc_useBVM;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_pocket",false], ["_useOxygen",false], ["_carriedOxygen",false]];

[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient","_pocket","_useOxygen","_carriedOxygen"];
    if !(_patient getVariable [QGVAR(BVMInUse), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if (_useOxygen && _carriedOxygen && !_pocket) then {
        private _carriedTanks = [];

        {
            if(_x select 0 in ["kat_oxygenTank_150","kat_oxygenTank_300"]) then {
                _carriedTanks pushBack _x;
            };
        } forEach magazinesAmmo _medic;

        if (count _carriedTanks > 0) then {
            _patient setVariable [QGVAR(oxygenTankConnected), true, true];

            private _tank = _carriedTanks select (count _carriedTanks - 1);
            private _tankClassName = (_tank select 0);
            private _oxygenLeft = (_tank select 1) - 1;

            if(_oxygenLeft > 0) then {
                _medic removeMagazine _tankClassName;
                _medic addMagazine [_tankClassName, _oxygenLeft];
            } else {
                _medic addItem [_tankClassName,"Empty"] joinString "_";
            };
        } else {
            _patient setVariable [QGVAR(oxygenTankConnected), false, true];
        };
    };

    /*if(_pocket) then {
        playsound3D [QPATHTOF_SOUND(sounds\squeeze_pocketBVM.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
    } else {
        if(_patient getVariable [QGVAR(BVMInUse), false] && _patient getVariable [QGVAR(oxygenTankConnected), false]) then {
            playsound3D [QPATHTOF_SOUND(sounds\squeeze_BVMOxygen.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
        } else {
            playsound3D [QPATHTOF_SOUND(sounds\squeeze_BVM.ogg), _patient, false, getPosASL _patient, 5, 1, 8];
        };
    };*/
}, 3, [_medic,_patient,_pocket,_useOxygen,_carriedOxygen]] call CBA_fnc_addPerFrameHandler;