#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Attaches vehicle oxygen to player
 * Main function
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_attachVehicleOxygen;
 *
 * Public: No
 */

params ["_patient"];

if (_patient getVariable [QGVAR(oxygenMaskActive), false]) exitWith {
    [LSTRING(PersonalOxygen_Affirm), 1.5, _patient] call ACEFUNC(common,displayTextStructured);
};

_patient setVariable [QGVAR(oxygenMaskActive), true, true];

[QGVAR(playRespiratorTone), [_patient], _patient] call CBA_fnc_targetEvent;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_patient"];

    if !(alive _patient) exitWith {
        _patient setVariable [QGVAR(oxygenMaskActive), false, true];
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if (isNull objectParent _patient) exitWith {
        _patient setVariable [QGVAR(oxygenMaskActive), false, true];
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !((_patient call EFUNC(airway,checkMask))) exitWith {
        _patient setVariable [QGVAR(oxygenMaskActive), false, true];
        _pfhID call CBA_fnc_removePerFrameHandler;
    };
}, 10, [
    _patient
]] call CBA_fnc_addPerFrameHandler;