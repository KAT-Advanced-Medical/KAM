#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_displayGasMaskDur;
 *
 * Public: No
*/

params ["_target"];

private _durability = _target getVariable [QGVAR(gasmask_durability), 10];
private _durabilityStructuredText = if (_durability >= 0) then {

    private _color = [((2 * (1 - _durability / 10)) min 1), ((2 * _durability / 10) min 1), 0];

    private _string = "";
    for "_a" from 1 to _durability do {
        _string = _string + "|";
    };
    private _text = [_string, _color] call ACEFUNC(common,stringToColoredText);

    _string = "";
    for "_a" from (_durability + 1) to (10) do {
        _string = _string + "|";
    };

    composeText [_text, [_string, "#808080"] call ACEFUNC(common,stringToColoredText)];

};
private _picture = QPATHTOF(ui\Gasmask_icon.paa);
[_durabilityStructuredText, _picture] call ACEFUNC(common,displayTextPicture);
