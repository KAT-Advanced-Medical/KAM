#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Sets a unit in the unconscious state.
 *
 * Arguments:
 * 0: The unit that will be put in an unconscious state <OBJECT>
 * 1: Set unconscious <BOOL> (default: true)
 * 2: Minimum unconscious time (set to 0 to ignore) <NUMBER> (default: 0)
 * 3: Force wakeup at given time if vitals are stable <BOOL> (default: false)
 *
 * Return Value:
 * Success? <BOOL> or <NIL> if called before settings are initialized
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
    nil
};

params [["_unit", objNull, [objNull]], ["_knockOut", true, [false]], ["_minWaitingTime", 0, [0]], ["_forcedWakup", false, [false]]];
TRACE_4("setUnconscious",_unit,_knockOut,_minWaitingTime,_forcedWakup);

if ((isNull _unit) || {!alive _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {
    ERROR_3("Bad Unit %1 [Type: %2] [Alive: %3]",_unit,typeOf _unit,alive _unit);
    false
};

if (!local _unit) exitWith {
    [QACEGVAR(medical,setUnconscious), _this, _unit] call CBA_fnc_targetEvent;
    true
};

if (_knockOut isEqualTo IS_UNCONSCIOUS(_unit)) exitWith {
    WARNING_2("setUnconscious called with no change [Unit %1] [State [%2]",_unit,_knockOut);
    false
};

// Units without medical activity are not simulated by ACE's medical state machine until activated (newer ACE versions only)
if (!isNil QACEGVAR(medical,const_medicalActivity) && {!(_unit getVariable [QACEGVAR(medical,medicalActivity), ACEGVAR(medical,const_medicalActivity)])}) then {
    [QACEGVAR(medical,activateMedical), _unit] call CBA_fnc_localEvent;
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
                if ((alive _unit) && {_unit call EFUNC(vitals,hasStableVitals)}) then {
                    TRACE_1("Doing delay wakeup",_unit);
                    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
                    KAT_forceWakeup = false;
                } else {
                    TRACE_1("Skipping delay wakeup",_unit);
                    KAT_forceWakeup = false;
                };
            }, [_unit], _minWaitingTime] call CBA_fnc_waitAndExecute;
        };
        if (ACEGVAR(medical,spontaneousWakeUpChance) > 0) then {
            TRACE_1("setting lastWakeUpCheck",_minWaitingTime);
            _unit setVariable [QACEGVAR(medical,lastWakeUpCheck), CBA_missionTime + _minWaitingTime - SPONTANEOUS_WAKE_UP_INTERVAL];
        };
    };

    [QACEGVAR(medical,knockOut), _unit] call CBA_fnc_localEvent;
} else {
    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
};

true
