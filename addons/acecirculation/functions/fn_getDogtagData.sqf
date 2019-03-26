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
private _dogTagData = _target getVariable "ace_dogtags_dogtagData";
if (!isNil "_dogTagData") exitWith {_dogTagData};

// Create dog tag data once for the unit: nickname, code (eg. 135-13-900) and blood type
private _targetName = [_target, false, true] call ace_common_fnc_getName;

private _dogTagData = [
    _targetName,
    _target call kat_aceCirculation_fnc_groupID, //EDIT changed called function, old: ace_dogtags_fnc_ssn
    _target call kat_aceCirculation_fnc_bloodType //EDIT by Katalam switch name to target objective //EDIT 2 changed called function, old: ace_dogtags_fnc_bloodType
];
// Store it
_target setVariable ["ace_dogtags_dogtagData", _dogTagData, true];
_dogTagData
