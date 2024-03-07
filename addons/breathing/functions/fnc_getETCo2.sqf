#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's ETCo2 level based on status of their vitals.
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

private _bloodVolume = GET_BLOOD_VOLUME(_patient);
private _lostBlood = 6.0 - _bloodVolume; // amount of blood missing from the body

private _ptxTarget = _patient getVariable [QGVAR(pneumothorax), 0]; // more deteriorated closer to 4, at 4 likely to become advanced
private _hasHtx = _patient getVariable [QGVAR(hemopneumothorax), false];
private _hasTptx = _patient getVariable [QGVAR(tensopneumothorax), false];

private _airwayObstructed = _patient getVariable [QEGVAR(airway,obstruction), false] && !(_patient getVariable [QEGVAR(airway,overstretch), false]);
private _airwayOccluded = _patient getVariable [QEGVAR(airway,occluded), false];

private _randomOffset = floor (random 5) - 2; // random number from -2 to 2
private _newEtco2 = 0;
switch (true) do {
    //cpr being performed
    case (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull]): {
        _newEtco2 = 10;
        private _cardiacType = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0]; // DIGBHJNEIUOTYGH MAKE THIS QEGVAR
        private _offset = (_cardiacType) * 2;
        _newEtco2 = _newEtco2 + _offset;
        _newEtco2 + _randomOffset;
    };

    //cardiac arrest without cpr being performed
    case (IN_CRDC_ARRST(_patient)): {0};

    //airways blocked
    case (_airwayObstructed || _airwayOccluded): {60+_randomOffset};

    //lost a lot of blood
    case (_lostBlood >= 1): {
        _newEtco2 = 37;
        _newEtco2 = _newEtco2 - ((floor (_lostBlood / 0.5)) * 4);
        (14 max _newEtco2 min 99) + _randomOffset; //subtract 4mmhg of ETCo2 for each 500ml lost, clamped at minimum 14
    };

    //tptx/hpx
    case (_hasHtx || _hasTptx): {22  + _randomOffset};

    // base ptx. ETCo2 decreases as ptx deteriorates
    case (_ptxTarget > 0): {
        _newEtco2 = 37 - (_ptxTarget * 3);
        _newEtco2 + _randomOffset;
    };

    //final checks for blood loss, if no other problems
    default {40  + _randomOffset};
};