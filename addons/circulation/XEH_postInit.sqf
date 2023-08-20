#include "script_component.hpp"

["ace_cardiacArrest", LINKFUNC(handleCardiacArrest)] call CBA_fnc_addEventHandler;

GVAR(AEDX_MonitorTarget) = objNull;

[QGVAR(setPreferredBloodType), {
    params ["_unit"];
    _unit setVariable [QGVAR(bloodTypePlayer), (profileNamespace getVariable [QGVAR(preferredBloodType), "O_N"]), true];
}] call CBA_fnc_addEventHandler;