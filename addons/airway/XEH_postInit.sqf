#include "script_component.hpp"

if !(GVAR(enable)) exitWith {};

[QGVAR(treatmentAirwayLocal), FUNC(treatmentAirwayLocal)] call CBA_fnc_addEventHandler;
[QGVAR(treatmentSuctionLocal), FUNC(treatmentSuctionLocal)] call CBA_fnc_addEventHandler;

["ace_medical_woundReceived", LINKFUNC(handleStateInjured)] call CBA_fnc_addEventHandler;

["ace_medical_treatment_treatmentFullHealLocal",{
    params ["", "_target", "", "_className"];
    if (toUpper _className isEqualTo "PERSONALAIDKIT" && local _target) exitWith {
        _target call FUNC(init);
        _target setVariable [QEGVAR(circulation,IV_counts), 0, true];
    };
 }] call CBA_fnc_addEventHandler;
