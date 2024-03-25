#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's ETCo2 level based on status of their vitals.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * ETCo2 level and units <STR>: "40 mmHg"
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
private _lostBlood = 6.0 - _bloodVolume;
private _pH = _patient getVariable [QEGVAR(pharma,pH),1500];
private _phDiff = 1500 - _pH;

private _ptxTarget = _patient getVariable [QGVAR(pneumothorax), 0]; // more deteriorated closer to 4, at 4 likely to become advanced
private _hasHtx = _patient getVariable [QGVAR(hemopneumothorax), false];
private _hasTptx = _patient getVariable [QGVAR(tensopneumothorax), false];

private _airwayObstructed = _patient getVariable [QEGVAR(airway,obstruction), false] && !(_patient getVariable [QEGVAR(airway,overstretch), false]);
private _airwayOccluded = _patient getVariable [QEGVAR(airway,occluded), false];

private _phOffset = [0,(floor (_phDiff / 250))] select (EGVAR(pharma,kidneyAction)); // increase etco2 by 1 per 250 points of pH lost
private _randomOffset = selectRandom [-2,-1,0,1,2];
private _newEtco2 = switch (true) do {
    //cpr being performed and patient has no pulse
    case ((_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isNotEqualTo objNull) && (_pr == 0)): {
        private _newEtco2 = 11;
        private _cardiacType = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0];
        private _offset = (_cardiacType);
        private _bloodOffset = [((floor (_lostBlood / 0.8)) * 2),0] select (_lostBlood > 2);  // reduce ETCo2 by 2mmhg for each 800ml of blood lost above 2L threshold (initial 2L incl.)
        _newEtco2 = _newEtco2 + _offset - _bloodOffset;
        _newEtco2 + _randomOffset;
    };

    //cardiac arrest without cpr being performed
    case (IN_CRDC_ARRST(_patient)): {0};

    //airways blocked
    case (_airwayObstructed || _airwayOccluded): {50+_randomOffset+_phOffset};

    //lost a lot of blood
    case (_lostBlood >= 1): {
        private _newEtco2 = 37;
        _newEtco2 = _newEtco2 - ((floor (_lostBlood / 0.5)) * 4);
        (14 max _newEtco2 min 99) + _randomOffset+_phOffset; //subtract 4mmhg of ETCo2 for each 500ml lost, clamped at minimum 14
    };

    //tptx/hpx
    case (_hasHtx || _hasTptx): {22+_randomOffset+_phOffset};

    // base ptx. ETCo2 decreases as ptx deteriorates
    case (_ptxTarget > 0): {
        private _newEtco2 = 37 - (_ptxTarget * 3);
        _newEtco2 + _randomOffset + _phOffset;
    };

    //no problems
    default {40+_randomOffset+_phOffset};
};

if (GVAR(Etco2_Units) == 0) then {
    (str _newEtco2) + "mmHg";
} else {
    ((_newEtco2/7.501) toFixed 2)+ "kPa";
};