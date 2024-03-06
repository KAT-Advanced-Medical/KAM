#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's ETCo2 level based on status of their vitals
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * ETCo2 level <INT>
 *
 * Example:
 * [player] call kat_breathing_fnc_getETCo2;
 *
 * Public: No
 */

 params ["_patient"];

_baseValue = 40;

_pr = _patient getVariable [QACEGVAR(medical,heartRate), 0];
_sp02 = 0;
_bloodloss = 0;


_hasPtx = false;
_ptxFactor = 0;

_airwayObstructed = (_unit getVariable [QEGVAR(airway,obstruction), false]);
_airwayOccluded = (_unit getVariable [QEGVAR(airway,occluded), false]);

_airwayBlocked = (_airwayObstructed || _airwayOccluded); // TODO replace vars with functions to get states


//cardiac arrest
if (_pr == 0) exitWith {0};

//cpr being performed
if !(_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) exitWith {
    _baseValue = 10;
    private _cardiacType = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0]; // DIGBHJNEIUOTYGH MAKE THIS QEGVAR
    private _offset = (_cardiacType) * 2;
    _baseValue = _baseValue + _offset;
    _baseValue;
};

_baseValue;