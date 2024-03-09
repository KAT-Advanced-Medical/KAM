#include "..\script_component.hpp"
/*
 * Author: esteldunedain
 * Get unit dogtag data.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Dogtag Data <ARRAY>
 * 0: Name <STRING>
 * 1: SSN <STRING>
 * 2: Blood Type <STRING>
 *
 * Example:
 * _dogtagData = [cursorTarget] call ace_dogtags_fnc_getDogtagData
 *
 * Public: No
 */

params ["_target"];

// Check if the data was already created
private _dogTagData = _target getVariable QACEGVAR(dogtags,dogtagData);
if (!isNil "_dogTagData") exitWith {_dogTagData};

// Create dog tag data once for the unit: nickname, code (eg. 135-13-900) and blood type
private _targetName = [_target, false, true] call ACEFUNC(common,getName);
private _targetBlood = _target call EFUNC(circulation,bloodType);

switch (_targetBlood) do {
    case "O": {_targetBlood = "0+"};
    case "O_N": {_targetBlood = "0-"};
    case "A": {_targetBlood = "A+"};
    case "A_N": {_targetBlood = "A-"};
    case "B": {_targetBlood = "B+"};
    case "B_N": {_targetBlood = "B-"};
    case "AB": {_targetBlood = "AB+"};
    case "AB_N": {_targetBlood = "AB-"};
};

private _dogTagData = [
    _targetName,
    _targetBlood, //EDIT by Katalam switch name to target objective //EDIT 2 changed called function, old: ace_dogtags_fnc_bloodType //EDIT 3 working solution for added rhesus factor
    _target call FUNC(groupID) //EDIT changed called function, old: ace_dogtags_fnc_ssns
];
// Store it
_target setVariable [QACEGVAR(dogtags,dogtagData), _dogTagData, true];
_dogTagData
