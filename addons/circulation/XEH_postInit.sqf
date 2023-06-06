#include "script_component.hpp"

[QGVAR(setPreferredBloodType), {
    params ["_unit"];
    _unit setVariable [QGVAR(bloodTypePlayer),(profileNamespace getVariable [QGVAR(preferredBloodType), "O_N"]), true];
}] call CBA_fnc_addEventHandler;