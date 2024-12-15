#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_breathing_fnc_init
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

[_unit] call FUNC(fullHealLocal);

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(PulseOximeter_Volume), true, true];
_unit setVariable [QGVAR(PulseOximeter_VolumePatient), false, true];

_unit setVariable [QGVAR(oxygenMaskActive), false, true];
_unit setVariable [QGVAR(oxygenMaskStatus), [0,0], true];

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    private _alive = alive _unit;

    if (!_alive) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

	private _spo2 = GET_KAT_SPO2(_unit);

	if(GVAR(staminaLossAtLowSPO2)) then {
		if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_spo2 <= GVAR(lowSPO2Level)}) then {
			if (ACEGVAR(advanced_fatigue,enabled)) then {
				["kat_LSDF", 1.5] call ACEFUNC(advanced_fatigue,addDutyFactor);
			} else {
				_unit setStamina(getStamina _unit - 3);
			};
		} else {
			["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
		};
	};

	if ((_unit getVariable [QGVAR(pneumothorax), 0] > 0) || _unit getVariable [QGVAR(hemopneumothorax), false] || _unit getVariable [QGVAR(tensionpneumothorax), false] || _unit getVariable [QEGVAR(chemical,airPoisoning), false]) then {
		if (!(_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) && !(_unit getVariable [QGVAR(PneumoBreathCooldownOn), false])) then {
			_unit setVariable [QGVAR(PneumoBreathCooldownOn), true, true];

			private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

			if !(_soundTargets isEqualTo []) then {
				[QGVAR(playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
			};

			[{
				params["_unit"];
				_unit setVariable [QGVAR(PneumoBreathCooldownOn), false, true];
			},
			[_unit], 20] call CBA_fnc_waitAndExecute;
		};
	};
}, 10, [_unit]] call CBA_fnc_addPerFrameHandler;
