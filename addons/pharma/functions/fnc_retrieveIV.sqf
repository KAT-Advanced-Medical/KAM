#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Retrieves the IV/IO from a patient and returns additional fluids to the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftArm"] call kat_pharma_fnc_retrieveIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

if(GVAR(IVreuse)) then {
    switch (_IVactual) do {
        case 1: {_patient addItem "kat_IO_FAST"};
        case 2: {_patient addItem "kat_IV_16"};
        case 3: {_patient addItem "kat_IV_14"};
        case 4: {_patient addItem "kat_IV_20"};
        case 13: {_patient addItem "kat_EZ_IO"};
        default {};
        };
};

_IVarray set [_partIndex, 0];
_patient setVariable [QGVAR(IV), _IVarray, true];

private _ivFlow = _patient getVariable [QGVAR(IVFlow), [0,0,0,0,0,0,0,0,0,0,0,0]];

private _pairs = [[4,5], [6,7], [8,9], [10,11]];
private _affectedPair = _pairs findIf { _partIndex in _x };

if (_affectedPair != -1) then {
    {
        _ivFlow set [_x, 0];
    } forEach (_pairs select _affectedPair);
} else {
    _ivFlow set [_partIndex, 0];
};

_patient setVariable [QGVAR(IVFlow), _ivFlow, true];

private _ivBags = _patient getVariable [QACEGVAR(medical,ivBags), []];

private _remainingBags = [];
private _removedBags = [];

{
    _x params ["_volumeRemaining", "_ivType", "_ivPartIndex"];

    if (_ivPartIndex == _partIndex) then {
        _removedBags pushBack _x;
    } else {
        _remainingBags pushBack _x;
    };
} forEach _ivBags;

_patient setVariable [QACEGVAR(medical,ivBags), _remainingBags, true];

private _saline = 0;
private _blood = 0;
private _plasma = 0;
private _ringersLactate = 0;
private _packedRBC = 0;
private _hextend = 0;
private _hyperSaline = 0;
private _fbtk = 0;
private _totalIvVolume = 0;

// Remove matching bags and collect volumes

{
    _x params ["_volumeRemaining", "_ivType", "_ivPartIndex"];

    _totalIvVolume = _totalIvVolume + _volumeRemaining;

    switch (_ivType) do {
        case "Saline": { _saline = _saline + _volumeRemaining; };
        case "Blood": { _blood = _blood + _volumeRemaining; };
        case "Plasma": { _plasma = _plasma + _volumeRemaining; };
        case "Ringers Lactate": { _ringersLactate = _ringersLactate + _volumeRemaining; };
        case "PackedRBC": { _packedRBC = _packedRBC + _volumeRemaining; };
        case "Hextend": { _hextend = _hextend + _volumeRemaining; };
        case "Hypertonic Saline": { _hyperSaline = _hyperSaline + _volumeRemaining; };
        case "FBTK_500": { _fbtk = _fbtk + _volumeRemaining; };
        case "FBTK_250": { _fbtk = _fbtk + _volumeRemaining; };
        default {};
    };
} forEach _removedBags;

if (_totalIvVolume >= 1) then {
    private _refundIV = {
        params ["_volume", "_items"];

        switch (true) do {
            case (_volume >= 3000): { {_medic addItem _x} forEach [_items#0, _items#0, _items#0];};
            case (_volume >= 2750): { {_medic addItem _x} forEach [_items#0, _items#0, _items#1, _items#2];};
            case (_volume >= 2500): { {_medic addItem _x} forEach [_items#0, _items#0, _items#1];};
            case (_volume >= 2250): { {_medic addItem _x} forEach [_items#0, _items#0, _items#2];};
            case (_volume >= 2000): { {_medic addItem _x} forEach [_items#0, _items#0];};
            case (_volume >= 1750): { {_medic addItem _x} forEach [_items#0, _items#1, _items#2];};
            case (_volume >= 1500): { {_medic addItem _x} forEach [_items#0, _items#1];};
            case (_volume >= 1250): { {_medic addItem _x} forEach [_items#0, _items#2];};
            case (_volume >= 1000): { _medic addItem _items#0;};
            case (_volume >= 750): { {_medic addItem _x} forEach [_items#1, _items#2];};
            case (_volume >= 500): { _medic addItem _items#1;};
            case (_volume >= 250): { _medic addItem _items#2;};
        };
    };
    if (_saline > 250) then {
        [_saline, ["ACE_salineIV", "ACE_salineIV_500", "ACE_salineIV_250"]] call _refundIV;
    };
    if (_blood > 250) then {
        [_blood, ["ACE_bloodIV", "ACE_bloodIV_500", "ACE_bloodIV_250"]] call _refundIV;
    };
    if (_plasma > 250) then {
        [_plasma, ["ACE_plasmaIV", "ACE_plasmaIV_500", "ACE_plasmaIV_250"]] call _refundIV;
    };
    if (_ringersLactate > 250) then {
        [_ringersLactate, ["kat_RingersLactateIV", "kat_RingersLactateIV_500", "kat_RingersLactateIV_250"]] call _refundIV;
    };
    if (_hextend > 250) then {
        [_hextend, ["kat_HextendIV", "kat_HextendIV_500", "kat_HextendIV_250"]] call _refundIV;
    };
    if (_packedRBC > 250) then {
        switch (true) do {
            case (_packedRBC >= 3000): { for "_i" from 1 to 6 do { _medic addItem "kat_PackedRBCIV_500"; };};
            case (_packedRBC >= 2750): { for "_i" from 1 to 5 do { _medic addItem "kat_PackedRBCIV_500"; }; _medic addItem "kat_PackedRBCIV_250";};
            case (_packedRBC >= 2500): { for "_i" from 1 to 5 do { _medic addItem "kat_PackedRBCIV_500"; };};
            case (_packedRBC >= 2250): { for "_i" from 1 to 4 do { _medic addItem "kat_PackedRBCIV_500"; }; _medic addItem "kat_PackedRBCIV_250";};
            case (_packedRBC >= 2000): { for "_i" from 1 to 4 do { _medic addItem "kat_PackedRBCIV_500"; };};
            case (_packedRBC >= 1750): { for "_i" from 1 to 3 do { _medic addItem "kat_PackedRBCIV_500"; }; _medic addItem "kat_PackedRBCIV_250";};
            case (_packedRBC >= 1500): { for "_i" from 1 to 3 do { _medic addItem "kat_PackedRBCIV_500"; };};
            case (_packedRBC >= 1250): { for "_i" from 1 to 2 do { _medic addItem "kat_PackedRBCIV_500"; }; _medic addItem "kat_PackedRBCIV_250";};
            case (_packedRBC >= 1000): { for "_i" from 1 to 2 do { _medic addItem "kat_PackedRBCIV_500"; }; };
            case (_packedRBC >= 750): { _medic addItem "kat_PackedRBCIV_500"; _medic addItem "kat_PackedRBCIV_250"; };
            case (_packedRBC >= 500): { _medic addItem "kat_PackedRBCIV_500"; };
            case (_packedRBC >= 250): { _medic addItem "kat_PackedRBCIV_250"; };
        };
    };
    if (_hyperSaline > 250) then {
        switch (true) do {
            case (_hyperSaline >= 3000): { for "_i" from 1 to 6 do { _medic addItem "kat_HypertonicSalineIV_500"; };};
            case (_hyperSaline >= 2750): { for "_i" from 1 to 5 do { _medic addItem "kat_HypertonicSalineIV_500"; }; _medic addItem "kat_HypertonicSalineIV_250";};
            case (_hyperSaline >= 2500): { for "_i" from 1 to 5 do { _medic addItem "kat_HypertonicSalineIV_500"; };};
            case (_hyperSaline >= 2250): { for "_i" from 1 to 4 do { _medic addItem "kat_HypertonicSalineIV_500"; }; _medic addItem "kat_HypertonicSalineIV_250";};
            case (_hyperSaline >= 2000): { for "_i" from 1 to 4 do { _medic addItem "kat_HypertonicSalineIV_500"; };};
            case (_hyperSaline >= 1750): { for "_i" from 1 to 3 do { _medic addItem "kat_HypertonicSalineIV_500"; }; _medic addItem "kat_HypertonicSalineIV_250";};
            case (_hyperSaline >= 1500): { for "_i" from 1 to 3 do { _medic addItem "kat_HypertonicSalineIV_500"; };};
            case (_hyperSaline >= 1250): { for "_i" from 1 to 2 do { _medic addItem "kat_HypertonicSalineIV_500"; }; _medic addItem "kat_HypertonicSalineIV_250";};
            case (_hyperSaline >= 1000): { for "_i" from 1 to 2 do { _medic addItem "kat_HypertonicSalineIV_500"; }; };
            case (_hyperSaline >= 750): { _medic addItem "kat_HypertonicSalineIV_500"; _medic addItem "kat_HypertonicSalineIV_250"; };
            case (_hyperSaline >= 500): { _medic addItem "kat_HypertonicSalineIV_500"; };
            case (_hyperSaline >= 250): { _medic addItem "kat_HypertonicSalineIV_250"; };
        };
    };
    if (_fbtk > 240) then {

    private _blood = [_patient] call EFUNC(circulation,bloodType);
    private _item = "";
    switch (true) do {
        case (_fbtk >= 490): {
            _item = "kat_FBTKbloodIV_" + _blood + "_500";
        };
        case (_fbtk >= 240): {
            _item = "kat_FBTKbloodIV_" + _blood + "_250";
        };
        default {
            _item = "";
        };
    };
    if (_item != "") then {
        _medic addItem _item;
        };
    };
};

_patient setVariable [QACEGVAR(medical,ivBags), _remainingBags, true];
