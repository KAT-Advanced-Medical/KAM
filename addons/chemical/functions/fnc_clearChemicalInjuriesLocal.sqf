#include "..\script_component.hpp"
/*
* Author: YetheSamartaka
* Clears Chemical injuries for target unit
*
* Arguments:
* 0: Target <OBJECT>
*
* Return Value:
* NONE
*
* Example:
* [_unit] call kat_chemical_fnc_clearChemicalInjuriesLocal;
*
* Public: Yes
*/

params ["_unit"];

if (!local _unit) exitWith {};

_unit setVariable [QEGVAR(chemical,enteredPoison), false, true];
_unit setVariable [QEGVAR(chemical,airPoisoning), false, true];
_unit setVariable [QEGVAR(chemical,isTreated), true, true];
_unit setVariable [QEGVAR(chemical,CS), false, true];
_unit setVariable [QEGVAR(chemical,timeleft), missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60], true];

if (_unit getVariable [QEGVAR(chemical,painEffect), 0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};
