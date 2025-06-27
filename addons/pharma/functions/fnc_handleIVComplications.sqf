#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles advanced IV complications
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: flowDifference (difference in fluid between the cap and the actual)<Number>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1] call kat_pharma_fnc_handleIVComplications
 *
 * Public: No
 */
 params ["_patient", "_flowDifference"];

_trali = _patient getVariable [QEGVAR(breathing,TRALI), 0];
_trali = _trali + 1;
if (_trali > 20) then {
    private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
    if ((_ht findIf {_x isEqualTo "TRALI"}) == -1) then {
    _ht pushBack "TRALI";
    if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
        [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
    };
    _patient setVariable [QEGVAR(breathing,TRALI), _trali, true];
    }
};
private _surface = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]);
if (_surface > 100) then {
    private _surfaceArea = _surface - 5;
    _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
};
