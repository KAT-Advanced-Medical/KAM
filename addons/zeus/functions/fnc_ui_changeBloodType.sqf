#include "script_component.hpp"
/*
 * Author: DiGi
 * Initalizes the "Manage Airways" Zeus module.
 *
 * Arguments:
 * 0: changeBloodType controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control] call kat_zeus_fnc_ui_changeBloodType
 *
 * Public: No
 */

params ["_control"]; 

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "setFocus";


private _unit = attachedTo _logic;

scopeName "Main";
private _fnc_error = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call FUNC(showMessage);
    breakOut "Main";
};

switch (false) do {
    case !(isNull _unit): {
        [LSTRING(NothingSelected)] call _fnc_error;
    };
    case (_unit isKindOf "CAManBase"): {
        [LSTRING(OnlyInfantry)] call _fnc_error;
    };
};

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};
    deleteVehicle _logic;
};


private _fnc_sliderMove = {
    params ["_slider","_curBloodVol"];
    private _idc = ctrlIDC _slider;
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _unit = attachedTo _logic;
    private _curVal = _unit getVariable ["ace_medical_bloodVolume", 6.0];
    _slider ctrlSetTooltip format [localize "STR_kat_zeus_sliderFormat13was23", parseNumber((sliderPosition _slider) toFixed 2), (parseNumber (_curVal toFixed 2)), "L"];
};

private _slider = _display displayCtrl 26423;
_slider sliderSetRange [0, 6];
_slider sliderSetSpeed [1,0.5];
private _curBloodVol = _unit getVariable ["ace_medical_bloodVolume", 6.0];
_slider sliderSetPosition (parseNumber (_curBloodVol toFixed 2));
_slider ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove];
[_slider,_curBloodVol] call _fnc_sliderMove;


private _playerBloodyType = _unit getVariable [QEGVAR(circulation,bloodtype), "O"];
private _select = switch (_playerBloodyType) do 
{
    case "O+":  {0};
      case "O-":  {1};
     case "A+":  {2};
      case "A-":  {3};
    case "B+":  {4};
    case "B-":  {5};
     case "AB+":  {6};
      case "AB-":  {7};
    default {0};
};
(_display displayCtrl 16107) lbSetCurSel _select;

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlparent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objnull);
    if (isNull _logic) exitWith {};

    private _unit = attachedTo _logic;
    private _bloodtypeSel = lbCurSel (_display displayCtrl 16107);
    private _bloodtype = ["O+","O-","A+","A-","B+","B-","AB+","AB-"] select _bloodtypeSel;
    _unit setVariable [QEGVAR(circulation,bloodtype), _bloodtype, true];
    private _dogtagData = _unit getVariable "ace_dogtags_dogtagData";
    if(!isNil "_dogtagData") then {
        _dogtagData set [2, _bloodtype];
    };

    private _curBloodVol = _unit getVariable ["ace_medical_bloodVolume", 6.0];
    private _sliderValue = sliderPosition (_display displayCtrl 26423);
    _unit setVariable ["ace_medical_bloodVolume", ( parseNumber (_sliderValue toFixed 2)), true];
};

_display displayAddEventHandler ["unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["buttonclick", _fnc_onConfirm];
