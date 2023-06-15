#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes 1x Morphine after the administration of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "Morphine" || _medication isEqualTo "Fentanyl" || _medication isEqualTo "Nalbuphine") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];

// resets ChromAberration effect
resetCamShake;
["ChromAberration", 200, [ 0, 0, true ]] spawn
{
    params["_name", "_priority", "_effect", "_handle"];
    while
    {
        _handle = ppEffectCreate[_name, _priority];
        _handle < 0
    }
    do
    {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit 0;
    [
        {
            params["_handle"];
            ppEffectCommitted _handle
        },
        {
            params["_handle"];
            _handle ppEffectEnable false;
            ppEffectDestroy _handle;
        },
    [_handle]] call CBA_fnc_waitUntilAndExecute;
};