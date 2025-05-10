#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Sets a unit in the unconscious state.
 *
 * Arguments:
 * 0: The unit that will be put in an unconscious state <OBJECT>
 * 1: Set unconsciouns <BOOL> (default: true)
 * 2: Minimum unconscious time (set to 0 to ignore) <NUMBER><OPTIONAL> (default: 0)
 * 3: Force wakeup at given time if vitals are stable <BOOL><OPTIONAL> (default: false)
 *
 * Return Value:
 * Success? <BOOLEAN>
 *
 * Example:
 * [bob, true] call ace_medical_fnc_setUnconscious;
 * [player, true, 5, true] call ace_medical_fnc_setUnconscious;
 *
 * Public: Yes
 */

// only run this after the settings are initialized
if !(ACEGVAR(common,settingsInitFinished)) exitWith {
    ACEGVAR(common,runAtSettingsInitialized) pushBack [ACEFUNC(medical,setUnconscious), _this];
};

params [["_unit", objNull, [objNull]], ["_knockOut", true, [false]], ["_minWaitingTime", 0, [0]], ["_forcedWakup", false, [false]]];

if ((isNull _unit) || {!alive _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {
    false
};

if (!local _unit) exitWith {
    [QACEGVAR(medical,setUnconscious), _this, _unit] call CBA_fnc_targetEvent;
    true
};

if (_knockOut isEqualTo (_unit getVariable ["ACE_isUnconscious", false])) exitWith {
    false
};

if (currentWeapon _unit != primaryWeapon _unit) then {
    _unit selectWeapon primaryWeapon _unit;
};

if (_knockOut) then {
    if (_minWaitingTime > 0) then {
        if (_forcedWakup) then {
            // If unit still has stable vitals at min waiting time, then force wake up
            KAT_forceWakeup = true;
            [{
                params [["_unit", objNull]];
                if ((alive _unit) && {_unit call FUNC(hasStableVitals)}) then {
                    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
                    KAT_forceWakeup = false;
                } else {
                    KAT_forceWakeup = false;
                };
            }, [_unit], _minWaitingTime] call CBA_fnc_waitAndExecute;
        };
        if (ACEGVAR(medical,spontaneousWakeUpChance) > 0) then {
            _unit setVariable [QACEGVAR(medical,lastWakeUpCheck), CBA_missionTime + _minWaitingTime - 15];
        };
    };

    [QACEGVAR(medical,knockOut), _unit] call CBA_fnc_localEvent;
} else {
    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
};

true
