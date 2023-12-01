#include "script_component.hpp"

["ace_cardiacArrest", LINKFUNC(handleCardiacArrest)] call CBA_fnc_addEventHandler;

GVAR(AEDX_MonitorTarget) = objNull;

[QGVAR(setPreferredBloodType), {
    params ["_unit"];
    _unit setVariable [QGVAR(bloodTypePlayer), (profileNamespace getVariable [QGVAR(preferredBloodType), "O_N"]), true];
}] call CBA_fnc_addEventHandler;

["isNotPerformingCPR", {!((_this select 0) getVariable [QGVAR(isPerformingCPR), false])}] call ACEFUNC(common,addCanInteractWithCondition);

[QGVAR(handleNearToAED), {
    params ["_unit", "_patient"];

    if (ACEGVAR(medical_gui,target) isEqualTo _patient) then {
        [_unit, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(incorrectAEDUsage), {
    params ["_unit"];

    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    _unit setVariable [QGVAR(cardiacArrestType), 1, true];
}] call CBA_fnc_addEventHandler;