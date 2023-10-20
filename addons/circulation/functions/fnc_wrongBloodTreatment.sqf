#include "..\script_component.hpp"
/*
 * Author: Tomcat
 * Treats wrong given Blood with Painkillers
 * And unit class.
 *
 * Arguments:
 * 0: Target/Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_wrongBloodTreatment
 *
 * Public: No
 */
params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BloodPoisoning") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };

} forEach (_medicationArray);
