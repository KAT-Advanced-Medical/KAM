#include "..\script_component.hpp"
/*
 * Author: Blue
 * Updates injury list for given body part for the target.
 *
 * Arguments:
 * 0: Injury list <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part, -1 to only show overall health info <NUMBER>
 * 3: Entries <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlInjuries, _target, 0] call kat_circulation_fnc_gui_updateInjuryListPart
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN", "_entries"];
if (_target getVariable [QGVAR(activeCPR), false]) then {
    private _CPRStartTime = _target getVariable [QGVAR(CPR_time), 0];
    private _CPRTime = CBA_missionTime - _CPRStartTime;
    private _minutes = floor (_CPRTime / 60);
    private _seconds = floor (_CPRTime % 60);
    private _time = format ["%1:%2", [_minutes, 2] call CBA_fnc_formatNumber, [_seconds, 2] call CBA_fnc_formatNumber];
    _entries pushBack [format ["%1 (%2)", ACELLSTRING(medical_treatment,Actions_CPR), _time], [0.3, 0.8, 0.8, 1]];
};
if (_target getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false] || _target getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
    private _entry = _target getVariable [QGVAR(AED_X_VitalsStatus), ""];
    _entries pushBack [_entry, [1, 1, 1, 1]];
};
if ((_target getVariable [QGVAR(attachedLucasState), false] == true) && (_target getVariable [QGVAR(attachedLucas), false]) && (_selectionN isEqualTo 2)) then {
    _entries pushBack [LLSTRING(LucasActive), [0.3, 0.8, 0.8, 1]];
};

if ((_target getVariable [QGVAR(attachedLucasState), false] == false) && (_target getVariable [QGVAR(attachedLucas), false]) && (_selectionN isEqualTo 2)) then {
    _entries pushBack [LLSTRING(LucasInactive), [0.3, 0.8, 0.8, 1]];
};