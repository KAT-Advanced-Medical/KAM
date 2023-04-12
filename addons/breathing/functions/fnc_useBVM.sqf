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
 * 4: Medic provides oxygen <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, true, false, false] call kat_breathing_fnc_useBVM;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_pocket",false], ["_useOxygen",false], ["_carriedOxygen",false]];

timeOut = false;
[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient","_pocket","_useOxygen","_carriedOxygen"];
    if !(_patient getVariable [QGVAR(BVMInUse), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    if !(timeOut) then {
        timeOut = true;

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
                    _medic removeMagazine _tankClassName;
                    _medic addItem ([_tankClassName,"Empty"] joinString "_");
                    [/*LLSTRING(X_already)*/"Oxygen tank disconnected (empty)", 1.5, _medic] call ACEFUNC(common,displayTextStructured);
                };
            } else {
                _patient setVariable [QGVAR(oxygenTankConnected), false, true];
            };
        };

        playsound3D [QPATHTOF_SOUND(audio\squeeze_BVM.ogg), _patient, false, getPosASL _patient, 12, 1, 6];
        
        [{
            params ["_patient"];
            !(_patient getVariable [QGVAR(BVMInUse), false]);
        }, {}, [_patient], 5, 
        {
            timeOut = false; 
        }] call CBA_fnc_waitUntilAndExecute;
    };
    

}, 0.1, [_medic,_patient,_pocket,_useOxygen,_carriedOxygen]] call CBA_fnc_addPerFrameHandler;