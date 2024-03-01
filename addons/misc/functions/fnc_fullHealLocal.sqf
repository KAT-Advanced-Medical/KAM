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
 * [player] call kat_misc_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal kat misc",_patient);

/// Clear Stamina & weapon sway
if (ACEGVAR(advanced_fatigue,enabled)) then {
    ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
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
    ["ChromAberration", 200, [ 0, 0, true ]] spawn {
        params["_name", "_priority", "_effect", "_handle"];
        while {
            _handle = ppEffectCreate[_name, _priority];
            _handle < 0
        } do {
            _priority = _priority + 1;
        };
        _handle ppEffectEnable true;
        _handle ppEffectAdjust _effect;
        _handle ppEffectCommit 0;
        [
            {
                params["_handle"];
                ppEffectCommitted _handle
            },
            {
                params["_handle"];
                _handle ppEffectEnable false;
                ppEffectDestroy _handle;
            },
        [_handle]] call CBA_fnc_waitUntilAndExecute;
    };
};

// Reenable ace fatige animationspeed override

if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
    _index = ACEGVAR(advanced_fatigue,setAnimExclusions) find "PervitinOverride";
    if (_index != -1) then {
        ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt _index;
    };
};
