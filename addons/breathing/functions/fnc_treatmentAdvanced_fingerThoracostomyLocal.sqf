#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Treatment for hemopneumothorax/tensionPnumo
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_fingerThoracostomyLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedicationCount);
private _medsToCheck = ["fentanyl", "ketamine", "nalbuphine", "morphine", "lidocaine"];
private _fentanylEffectiveness = 0;
private _ketamineEffectiveness = 0;
private _nalbuphineEffectiveness = 0;
private _morphineEffectiveness = 0;
private _lidocaineEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("fentanyl" in _medName) then {
        _fentanylEffectiveness = _fentanylEffectiveness max _effectiveness;
    };
    if ("ketamine" in _medName) then {
        _ketamineEffectiveness = _ketamineEffectiveness max _effectiveness;
    };
    if ("nalbuphine" in _medName) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
    if ("morphine" in _medName) then {
        _morphineEffectiveness = _morphineEffectiveness max _effectiveness;
    };
    if ("lidocaine" in _medName) then {
        _lidocaineEffectiveness = _lidocaineEffectiveness max _effectiveness;
    };
    } forEach _medStack;
    if (
        _fentanylEffectiveness <= 0.8 &&
        _ketamineEffectiveness <= 0.8 &&
        _nalbuphineEffectiveness <= 0.8 &&
        _lidocaineEffectiveness <= 0.6 &&
        _morphineEffectiveness <= 0.8
    ) then {
        [_patient, [0.7, 0.8, 0.9] select (floor random 3)] call ACEFUNC(medical_status,adjustPainLevel);
    };
if (random 100 <= 30) exitWith {};
private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
if (_activeChestSeal select _side) then {
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
    _hemopneumothorax set [_side, false];
    _patient setVariable [QGVAR(hemopneumothorax), _hemopneumothorax, true];
    private _tensionPneumothorax = _patient getVariable [QGVAR(tensionPneumothorax), [false, false]];
    _tensionPneumothorax set [_side, false];
    _patient setVariable [QGVAR(tensionPneumothorax), _tensionPneumothorax, true];
};

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
_ht deleteAt (_ht find "tension");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

private _pneumothorax = _patient getVariable [QGVAR(pneumothorax), [0, 0]];
private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];

if ((_patient getVariable [QGVAR(pneumothorax), [0, 0]] select _side > 0) &&
    !(_patient getVariable [QGVAR(hemopneumothorax), [false, false]] select _side) &&
    !((_patient getVariable [QGVAR(tensionPneumothorax), [false, false]]) select _side)) then {
    
    [_patient, 0, 0, format ["ptx_tension_%1", _side], true] call EFUNC(circulation,updateBloodPressureChange);
    
    if (GVAR(clearChestSealAfterTreatment)) then {
        _activeChestSeal set [_side, false];
        _patient setVariable [QGVAR(activeChestSeal), _activeChestSeal, true];
    };
};