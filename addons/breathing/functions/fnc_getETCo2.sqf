#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's ETCo2 level based on status of their vitals. ETCo2 is not its own vital as it does not need to be,
 * rather I've implemented it as more like a diagnostic tool.
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

if !(alive _patient) exitWith {0};

private _pr = GET_HEART_RATE(_patient);
private _bloodVolume = GET_BLOOD_VOLUME(_patient);
_lostBlood = 6.0 - _bloodVolume; // amount of blood missing from the body

_ptxTarget = _patient getVariable [QGVAR(pneumothorax), 0]; // more deteriorated closer to 4, at 4 likely to become advanced
_hasHtx = _patient getVariable [QGVAR(hemopneumothorax), false];
_hasTptx = _patient getVariable [QGVAR(tensopneumothorax), false];

_airwayObstructed = (_patient getVariable [QEGVAR(airway,obstruction), false]);
_airwayOccluded = (_patient getVariable [QEGVAR(airway,occluded), false]);

//cardiac arrest
if (_pr == 0) exitWith {0};

//cpr being performed
if !(_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) exitWith {
    private _baseValue = 10;
    private _cardiacType = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0]; // DIGBHJNEIUOTYGH MAKE THIS QEGVAR
    private _offset = (_cardiacType) * 2;
    _baseValue = _baseValue + _offset;
    _baseValue;
};

//airways blocked
if (_airwayObstructed || _airwayOccluded) exitWith {60};

//tptx/hpx
if (_hasHtx || _hasTptx) exitWith {22};

// base ptx. ETCo2 decreases as ptx deteriorates
if (_ptxTarget > 0) exitWith {
    private _baseValue = 37 - (_ptxTarget * 3);
    _baseValue;
};

//final checks for blood loss, if no other problems
_baseValue = 40;
_baseValue = _baseValue - ((floor (_lostBlood / 0.5)) * 4);
(14 max _baseValue min 99); //subtract 4mmhg of ETCo2 for each 500ml lost, clamped at minimum 14