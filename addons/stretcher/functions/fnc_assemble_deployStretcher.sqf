#include "..\script_component.hpp"
/*
 * Author: tcvm
 * Deploys the stretcher
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call kat_stretcher_fnc_assemble_deployTripod
 *
 * Public: No
 */

[{
    params ["_player"];
    TRACE_1("assemble_deployTripod",_player);

    // Save magazines and attachments (handle loaded launchers which can become csw like CUP Metis)
    private _secondaryWeaponInfo = (getUnitLoadout _player) select 1;
    private _secondaryWeaponClassname = _secondaryWeaponInfo deleteAt 0;


    // Remove empty entries
    _secondaryWeaponInfo = _secondaryWeaponInfo select {_x isNotEqualTo "" && {_x isNotEqualTo []}};

    // Remove the tripod from the launcher slot
    _player removeWeaponGlobal _secondaryWeaponClassname;

    private _onFinish = {
        params ["_args"];
        _args params ["_player", "_secondaryWeaponClassname", "_secondaryWeaponInfo"];
        TRACE_3("deployTripod finish",_player,_secondaryWeaponClassname,_secondaryWeaponInfo);

        private _tripodClassname = getText (configFile >> "CfgWeapons" >> _secondaryWeaponClassname >> QUOTE(ADDON) >> "deploy");

        // Create a tripod
        private _cswTripod = createVehicle [_tripodClassname, [0, 0, 0], [], 0, "NONE"];

        private _posATL = _player getRelPos [2, 0];
        _posATL set [2, ((getPosATL _player) select 2) + 0.5];

        _cswTripod setDir (direction _player);
        _cswTripod setPosATL _posATL;
        _cswTripod setVectorUp (surfaceNormal _posATL);

        [_player, "PutDown"] call EFUNC(common,doGesture);

        // drag after deploying
        if ((missionNamespace getVariable [QACEGVAR(csw,dragAfterDeploy), false]) && {["ace_dragging"] call EFUNC(common,isModLoaded)}) then {
            if ([_player, _cswTripod] call ACEFUNC(dragging,canCarry)) then {
                TRACE_1("starting carry",_cswTripod);
                [_player, _cswTripod] call ACEFUNC(dragging,startCarry);
            } else {
                TRACE_1("cannot carry",_cswTripod);
            };
        };
    };

    private _onFailure = {
        params ["_args"];
        _args params ["_player", "_secondaryWeaponClassname", "_secondaryWeaponInfo"];
        TRACE_3("deployTripod failure",_player,_secondaryWeaponClassname,_secondaryWeaponInfo);

        // Add tripod back
        [_player, _secondaryWeaponClassname] call CBA_fnc_addWeaponWithoutItems;
    };

    private _deployTime = getNumber (configFile >> "CfgWeapons" >> _secondaryWeaponClassname >> QUOTE(ADDON) >> "deployTime");
    [TIME_PROGRESSBAR(_deployTime), [_player, _secondaryWeaponClassname, _secondaryWeaponInfo], _onFinish, _onFailure, localize ACELSTRING(csw,PlaceTripod_progressBar)] call ACEFUNC(common,progressBar);
}, _this] call CBA_fnc_execNextFrame;
