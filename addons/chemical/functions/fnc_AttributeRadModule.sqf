#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Wires the radiation Zeus module attribute inputs (radius, preset, per-type
 * strengths, point source). Selecting a preset fills the four strength edits.
 * Writes ui_radius / ui_radStrengths / ui_radPointSource onto the display for
 * fnc_ui_radModule to read on confirm.
 *
 * Arguments:
 * 0: Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_control] call kat_chemical_fnc_AttributeRadModule;
 *
 * Public: No
 */

params ["_control"];

private _display = ctrlParent _control;
_control ctrlRemoveAllEventHandlers "SetFocus";

private _presetCombo = _display displayCtrl 1624;

(_display displayCtrl 1621) ctrlSetText "20";
(_display displayCtrl 1625) ctrlSetText "0";
(_display displayCtrl 1626) ctrlSetText "0";
(_display displayCtrl 1627) ctrlSetText "50";
(_display displayCtrl 1628) ctrlSetText "0";

private _presetNames = ["custom", "Cobalt60", "Reactor", "Fallout", "AlphaEmitter", "DirtyBomb"];
private _presetLabels = [LLSTRING(RadPreset_custom), LLSTRING(RadPreset_Cobalt60), LLSTRING(RadPreset_Reactor), LLSTRING(RadPreset_Fallout), LLSTRING(RadPreset_AlphaEmitter), LLSTRING(RadPreset_DirtyBomb)];
lbClear _presetCombo;
{ _presetCombo lbAdd _x } forEach _presetLabels;
_presetCombo lbSetCurSel 0;

_display setVariable [QGVAR(ui_presetNames), _presetNames];
_display setVariable [QGVAR(ui_radius), 20];
_display setVariable [QGVAR(ui_radStrengths), [0, 0, 50, 0]];
_display setVariable [QGVAR(ui_radPointSource), false];

private _fnc_onKeyUp = {
    params ["_display"];
    _display setVariable [QGVAR(ui_radius), parseNumber (ctrlText (_display displayCtrl 1621))];
    _display setVariable [QGVAR(ui_radStrengths), [
        parseNumber (ctrlText (_display displayCtrl 1625)),
        parseNumber (ctrlText (_display displayCtrl 1626)),
        parseNumber (ctrlText (_display displayCtrl 1627)),
        parseNumber (ctrlText (_display displayCtrl 1628))
    ]];
};

private _fnc_onPreset = {
    params ["_combo"];
    private _display = ctrlParent _combo;
    private _name = (_display getVariable [QGVAR(ui_presetNames), ["custom"]]) param [lbCurSel _combo, "custom"];
    if (_name isEqualTo "custom") exitWith {};
    private _s = +(GVAR(radPresets) getOrDefault [_name, [0, 0, 0, 0]]);
    (_display displayCtrl 1625) ctrlSetText str (_s select 0);
    (_display displayCtrl 1626) ctrlSetText str (_s select 1);
    (_display displayCtrl 1627) ctrlSetText str (_s select 2);
    (_display displayCtrl 1628) ctrlSetText str (_s select 3);
    _display setVariable [QGVAR(ui_radStrengths), _s];
};

private _fnc_onCheck = {
    params ["_check"];
    (ctrlParent _check) setVariable [QGVAR(ui_radPointSource), cbChecked _check];
};

_display displayAddEventHandler ["KeyUp", _fnc_onKeyUp];
_presetCombo ctrlAddEventHandler ["LBSelChanged", _fnc_onPreset];
(_display displayCtrl 1623) ctrlAddEventHandler ["CheckedChanged", _fnc_onCheck];
