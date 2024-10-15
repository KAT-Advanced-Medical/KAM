#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

/*
* 0 = No IV
* 1 = IO
* 2 = IV
* 3 = IV w/ Block
* 4 = IV w/ Flush
*/

GVAR(cardiacArrestBleedRate) = ACEGVAR(medical,const_minCardiacOutput) * EGVAR(circulation,cardiacArrestBleedRate);
_patient setVariable [QGVAR(alphaAction), 1, true];

_patient setVariable [QGVAR(IV), [0,0,0,0,0,0], true];

if (GVAR(RequireInsIV) && GVAR(IVflowControl)) then {
    _patient setVariable [QGVAR(IVflow), [0,0,0,0,0,0], true];
} else {
    _patient setVariable [QGVAR(IVflow), [1,1,1,1,1,1], true];
};

_patient setVariable [QGVAR(IVpfh), [0,0,0,0,0,0], true];
_patient setVariable [QGVAR(active), false, true];
_patient setVariable [QGVAR(IVPharma_PFH), nil, true];

_patient setVariable [QGVAR(IVmenuActive), false, true];

_patient setVariable [QGVAR(externalPh), 0, true];
_patient setVariable [QGVAR(pH), 0, true];

_patient setVariable [QGVAR(opioidFactor), 0, true];

_patient setVariable [QGVAR(kidneyFail), false, true];
_patient setVariable [QGVAR(kidneyArrest), false, true];
_patient setVariable [QGVAR(kidneyPressure), false, true];

_patient setVariable [QGVAR(coagulationFactor), missionNamespace getVariable [QGVAR(coagulation_factor_count), 30], true];

/// Clear Stamina & weapon sway
if (ACEGVAR(advanced_fatigue,enabled)) then {
    ["kat_PDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    ["kat_EDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    // ACEGVAR(advanced_fatigue,swayFactor) = EGVAR(pharma,originalSwayFactor); // TODO REWORK OR REMOVE
} else {
    _patient setAnimSpeedCoef 1;
    _patient setCustomAimCoef 1;
    if (GVAR(staminaMedication)) then {
        _patient enableStamina true;
    };
};

/// Clear chroma effect & camera shake
if (hasInterface) then {
    resetCamShake;
};

// Reenable ace fatige animationspeed override

if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
    _index = ACEGVAR(advanced_fatigue,setAnimExclusions) find "PervitinOverride";
    if (_index != -1) then {
        ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt _index;
    };
};
