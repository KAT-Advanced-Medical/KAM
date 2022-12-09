#include "script_component.hpp"
/*
 * Author: Miss Heda, 
 * Contributers: YonV, MiszczuZPolski
 * 
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_PervitinLocal;
 *
 * Public: No
 */

params ["_patient"];


/// ACE Fatigue 
if (ACEGVAR(advanced_fatigue,enabled)) then {
	
	[{
		params ["_patient"];

		ace_advanced_fatigue_anReserve = ace_advanced_fatigue_anReserve + 3000;
		["PDF", 0] call ace_advanced_fatigue_fnc_addDutyFactor;
		[LLSTRING(Pervitin_start), 2, _patient] call ACEFUNC(common,displayTextStructured); 
	},
	[_patient], 10] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];

		["PDF"] call ace_advanced_fatigue_fnc_removeDutyFactor;
		[LLSTRING(Pervitin_mid), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


	[{
		params ["_patient"];

		ace_advanced_fatigue_anReserve = ace_advanced_fatigue_anReserve + 3000;
		["PDF", 0.4] call ace_advanced_fatigue_fnc_addDutyFactor;
		[LLSTRING(Pervitin_mid2), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


	[{
		params ["_patient"];

		ace_advanced_fatigue_anReserve = ace_advanced_fatigue_anReserve + 3000;
		["PDF", 0.6] call ace_advanced_fatigue_fnc_addDutyFactor;
		[LLSTRING(Pervitin_mid3), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 360] call CBA_fnc_waitAndExecute; /// 6m


	[{
		params ["_patient"];

		["PDF", 2] call ace_advanced_fatigue_fnc_addDutyFactor;
		[LLSTRING(Pervitin_mid4), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 510] call CBA_fnc_waitAndExecute; /// 8:30m


	[{
		params ["_patient"];

		["PDF"] call ace_advanced_fatigue_fnc_removeDutyFactor;
		[LLSTRING(Pervitin_end), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 600] call CBA_fnc_waitAndExecute; /// 10m


	/// ACE Fatigue Weapon Sway

	if (isNil GVAR(originalSwayFactor)) then {
		GVAR(originalSwayFactor) = ace_advanced_fatigue_swayFactor;
	};

	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = GVAR(originalSwayFactor) * 0.3;
	},
	[_patient], 15] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = GVAR(originalSwayFactor) * 0.5 ;
	},
	[_patient], 60] call CBA_fnc_waitAndExecute;

	
	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = GVAR(originalSwayFactor) * 1;
	},
	[_patient], 90] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.3) min 2;
	},
	[_patient], 120] call CBA_fnc_waitAndExecute; /// 2m


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.5) min 2;
	},
	[_patient], 150] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.7) min 2;
	},
	[_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 2) min 2;
	},
	[_patient], 210] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.7) min 2;
	},
	[_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.4) min 2;
	},
	[_patient], 300] call CBA_fnc_waitAndExecute; /// 5m


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = (GVAR(originalSwayFactor) * 1.2) min 2;
	},
	[_patient], 420] call CBA_fnc_waitAndExecute; /// 7m


	[{
		params ["_patient"];
		ace_advanced_fatigue_swayFactor = GVAR(originalSwayFactor);
	},
	[_patient], 540] call CBA_fnc_waitAndExecute; /// 9m

} else {
	/// Normal Stamina & Weapon Sway

	[{
		params ["_patient"];

		_patient setAnimSpeedCoef 1.2;
		_patient enableStamina false;
		[LLSTRING(Pervitin_start), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 10] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];

		_patient enableStamina true;
		_patient setAnimSpeedCoef 1;
		[LLSTRING(Pervitin_mid), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 120] call CBA_fnc_waitAndExecute; /// 2m


	[{
		params ["_patient"];

		_patient setStamina(getStamina _patient + 300);
		[LLSTRING(Pervitin_mid2), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


	[{
		params ["_patient"];

		_patient setStamina(getStamina _patient + 150);
		[LLSTRING(Pervitin_mid3), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 360] call CBA_fnc_waitAndExecute; /// 6m


	[{
		params ["_patient"];

		_patient setStamina(getStamina _patient - 60);
		[LLSTRING(Pervitin_end), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 510] call CBA_fnc_waitAndExecute;

	///Weapon sway normal arma

	[{
		params ["_patient"];

		_patient setCustomAimCoef 1;
		_patient setCustomAimCoef(getCustomAimCoef _patient) - 0.7;
		[LLSTRING(Pervitin_WeaponSway), 2, _patient] call ACEFUNC(common,displayTextStructured);
	},
	[_patient], 15] call CBA_fnc_waitAndExecute;

	[{
		params ["_patient"];
		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.2;
	},
	[_patient], 60] call CBA_fnc_waitAndExecute;

	[{
		params ["_patient"];
		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.5;
	},
	[_patient], 90] call CBA_fnc_waitAndExecute;

	[{
		params ["_patient"];
		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.3;
	},
	[_patient], 120] call CBA_fnc_waitAndExecute; /// 2m


	[{
		params ["_patient"];
		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.5;
	},
	[_patient], 150] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];
		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.2;
	},
	[_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


	[{
		params ["_patient"];

		_patient setCustomAimCoef(getCustomAimCoef _patient) + 0.3;
		[LLSTRING(Pervitin_WeaponSway2), 2, _patient] call ACEFUNC(common,displayTextStructured);

	},
	[_patient], 210] call CBA_fnc_waitAndExecute;


	[{
		params ["_patient"];

		_patient setCustomAimCoef(getCustomAimCoef _patient) - 0.3;

	},
	[_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


	[{
		params ["_patient"];

		_patient setCustomAimCoef(getCustomAimCoef _patient) - 0.3;

	},
	[_patient], 300] call CBA_fnc_waitAndExecute; /// 5m


	[{
		params ["_patient"];

		_patient setCustomAimCoef(getCustomAimCoef _patient) - 0.2;

	},
	[_patient], 420] call CBA_fnc_waitAndExecute; /// 7m


	[{
		params ["_patient"];

		_patient setCustomAimCoef 1;
		[LLSTRING(Pervitin_WeaponSway3), 2, _patient] call ACEFUNC(common,displayTextStructured);

	},
	[_patient], 540] call CBA_fnc_waitAndExecute; /// 9m
};


/// ChromAberration effect
[
    { 
        params ["_patient"];

        ["ChromAberration", 200, [ 0.03, 0.03, true ], _patient] spawn {

            params["_name", "_priority", "_effect", "_patient"];
            private "_handle";
            while {
                _handle = ppEffectCreate[_name, _priority];
                _handle < 0
            } do {
                _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 515; /// Wearoff after 9m
            [LLSTRING(Pervitin_chrom), 2, _patient] call ACEFUNC(common,displayTextStructured);
            
            [
                {
                    params["_name", "_priority", "_effect", "_handle","_patient"];

                    [LLSTRING(Pervitin_chrom2), 2, _patient] call ACEFUNC(common,displayTextStructured);
                    addCamShake[0.7, 240, 2]; /// Wearoff after 9m
					[
						{ 	params ["_handle"];
							ppEffectCommitted _handle;
							
						},
						{	params ["_handle", "_patient"];
							[LLSTRING(Pervitin_chrom3), 2, _patient] call ACEFUNC(common,displayTextStructured);
							_handle ppEffectEnable false;
							ppEffectDestroy _handle;
						},
						[_handle, _patient]
                    ] call CBA_fnc_waitUntilAndExecute;
                },
                [_name, _priority, _effect, _handle, _patient],
                275 /// Trigger after 5m
            ] call CBA_fnc_waitAndExecute;
        };

    },
    [_patient],
    25 ///chroma start
] call CBA_fnc_waitAndExecute;