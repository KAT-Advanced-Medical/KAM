#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Retrieves the IV/IO from a patient and returns additional fluids to the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_pharma_fnc_retrieveIV;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _site = _patient getVariable [QGVAR(IVsite), 0];

if (GVAR(IVreuse)) then {
    if (_site isEqualTo 1) then {
        _medic addItem "kat_IO_FAST";
    } else {
        _medic addItem "kat_IV_16";
    };
};

_patient setVariable [QGVAR(IVplaced), false, true];
_patient setVariable [QGVAR(IVsite), 0, true];

private _totalIvVolume = 0;
private _saline = 0;
private _blood = 0;
private _plasma = 0;

{
    _x params ["_volumeRemaining", "_type"];
    switch (_type) do {
        case ("Saline"): {
            _saline = _saline + _volumeRemaining;
        };
        case ("Blood"): {
            _blood = _blood + _volumeRemaining;
        };
        case ("Plasma"): {
            _plasma = _plasma + _volumeRemaining;
        };
    };
    _totalIvVolume = _totalIvVolume + _volumeRemaining;
} forEach (_patient getVariable ["ace_medical_ivBags", []]);

if (_totalIvVolume >= 1) then {
    if (_saline > 1) then {
        switch (true) do {
            case (_saline > 1200): {
                _medic addItem "ACE_salineIV";
                _medic addItem "ACE_salineIV_500";
            };
            case (_saline > 800): {
                _medic addItem "ACE_salineIV";
            };
            case (_saline > 600): {
                _medic addItem "ACE_salineIV_500";
                _medic addItem "ACE_salineIV_250";
            };
            case (_saline > 400): {
                _medic addItem "ACE_salineIV_500";
            };
            case (_saline > 150): {
                _medic addItem "ACE_salineIV_250";
            };
        };
    };
    if (_blood > 1) then {
        switch (true) do {
            case (_blood > 1200): {
                _medic addItem "ACE_bloodIV";
                _medic addItem "ACE_bloodIV_500";
            };
            case (_blood > 800): {
                _medic addItem "ACE_bloodIV";
            };
            case (_blood > 600): {
                _medic addItem "ACE_bloodIV_500";
                _medic addItem "ACE_bloodIV_250";
            };
            case (_blood > 400): {
                _medic addItem "ACE_bloodIV_500";
            };
            case (_blood > 150): {
                _medic addItem "ACE_bloodIV_250";
            };
        };
    };
    if (_plasma > 1) then {
        switch (true) do {
            case (_plasma > 1200): {
                _medic addItem "ACE_plasmaIV";
                _medic addItem "ACE_plasmaIV_500";
            };
            case (_plasma > 800): {
                _medic addItem "ACE_plasmaIV";
            };
            case (_plasma > 600): {
                _medic addItem "ACE_plasmaIV_500";
                _medic addItem "ACE_plasmaIV_250";
            };
            case (_plasma > 400): {
                _medic addItem "ACE_plasmaIV_500";
            };
            case (_plasma > 150): {
                _medic addItem "ACE_plasmaIV_250";
            };
        };
    };
};

_patient setVariable ["ace_medical_ivBags", nil, true];