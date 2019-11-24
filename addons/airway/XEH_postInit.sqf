#include "script_component.hpp"

if !(GVAR(enable)) exitWith {};

[QGVAR(treatmentAirwayLocal), LINKFUNC(treatmentAirway)] call CBA_fnc_addEventHandler;
[QGVAR(removeAirwayLocal), LINKFUNC(removeAirway)] call CBA_fnc_addEventHandler;
[QGVAR(treatmentSuctionLocal), LINKFUNC(treatmentSuction)] call CBA_fnc_addEventHandler;

["ace_medical_injured", LINKFUNC(handleAirway)] call CBA_fnc_addEventHandler;

//["ace_medical_woundReceived", LINKFUNC(handleStateInjured)] call CBA_fnc_addEventHandler;

["ace_medical_treatment_fullHealLocal", {
    params ["_target"];
    _target call FUNC(init);
    _target setVariable [QEGVAR(circulation,IV_counts), 0, true];
}] call CBA_fnc_addEventHandler;
