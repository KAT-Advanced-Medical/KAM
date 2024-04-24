#include "..\script_component.hpp"
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

if (ACE_Player != _patient) exitWith {};
_defaultAnimSpeed = getAnimSpeedCoef _patient;

/// ACE Fatigue
if (ACEGVAR(advanced_fatigue,enabled)) then {

    [{
        params ["_patient", "_defaultAnimSpeed"];

        if !(alive _patient) exitWith {};
        ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 3000;
        ["kat_PDF", 0] call ACEFUNC(advanced_fatigue,addDutyFactor);
        [LLSTRING(Pervitin_start), 2, _patient] call ACEFUNC(common,displayTextStructured);

        if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
            ACEGVAR(advanced_fatigue,setAnimExclusions) pushBack "PervitinOverride";
        };
        _patient setAnimSpeedCoef (_defaultAnimSpeed * (GVAR(pervitinSpeed)));
    },
    [_patient, _defaultAnimSpeed], 10] call CBA_fnc_waitAndExecute;


    [{
        params ["_patient", "_defaultAnimSpeed"];

        if !(alive _patient) exitWith {};
        ["kat_PDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
        [LLSTRING(Pervitin_mid), 2, _patient] call ACEFUNC(common,displayTextStructured);

        _patient setAnimSpeedCoef _defaultAnimSpeed;
        if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
            _index = ACEGVAR(advanced_fatigue,setAnimExclusions) find "PervitinOverride";
            if (_index != -1) then {
                ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt _index;
            };
        };
    },
    [_patient, _defaultAnimSpeed], 180] call CBA_fnc_waitAndExecute; /// 3m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 3000;
        ["kat_PDF", 0.4] call ACEFUNC(advanced_fatigue,addDutyFactor);
        [LLSTRING(Pervitin_mid2), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 3000;
        ["kat_PDF", 0.6] call ACEFUNC(advanced_fatigue,addDutyFactor);
        [LLSTRING(Pervitin_mid3), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 360] call CBA_fnc_waitAndExecute; /// 6m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        ["kat_PDF", 2] call ACEFUNC(advanced_fatigue,addDutyFactor);
        [LLSTRING(Pervitin_mid4), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 510] call CBA_fnc_waitAndExecute; /// 8:30m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        ["kat_PDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
        [LLSTRING(Pervitin_end), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 600] call CBA_fnc_waitAndExecute; /// 10m


    /// ACE Fatigue Weapon Sway

    /*if (GVAR(weapon_sway_pervitin)) then { // TODO REWORK OR REMOVE

        if (isNil GVAR(originalSwayFactor)) then {
            GVAR(originalSwayFactor) = ACEGVAR(advanced_fatigue,swayFactor);
        };

        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = GVAR(originalSwayFactor) * 0.3;
        },
        [_patient], 15] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = GVAR(originalSwayFactor) * 0.5 ;
        },
        [_patient], 60] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = GVAR(originalSwayFactor) * 1;
        },
        [_patient], 90] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.3) min 2;
        },
        [_patient], 120] call CBA_fnc_waitAndExecute; /// 2m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.5) min 2;
        },
        [_patient], 150] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.7) min 2;
        },
        [_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 2) min 2;
        },
        [_patient], 210] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.7) min 2;
        },
        [_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.4) min 2;
        },
        [_patient], 300] call CBA_fnc_waitAndExecute; /// 5m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = (GVAR(originalSwayFactor) * 1.2) min 2;
        },
        [_patient], 420] call CBA_fnc_waitAndExecute; /// 7m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,swayFactor) = GVAR(originalSwayFactor);
        },
        [_patient], 540] call CBA_fnc_waitAndExecute; /// 9m
    };*/

} else {
    /// Normal Stamina & Weapon Sway

    [{
        params ["_patient", "_defaultAnimSpeed"];

        if !(alive _patient) exitWith {};
        _patient setAnimSpeedCoef (_defaultAnimSpeed * (GVAR(pervitinSpeed)));
        _patient enableStamina false;
        [LLSTRING(Pervitin_start), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient, _defaultAnimSpeed], 10] call CBA_fnc_waitAndExecute;


    [{
        params ["_patient", "_defaultAnimSpeed"];

        if !(alive _patient) exitWith {};
        _patient enableStamina true;
        _patient setAnimSpeedCoef _defaultAnimSpeed;
        [LLSTRING(Pervitin_mid), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient, _defaultAnimSpeed], 180] call CBA_fnc_waitAndExecute; /// 3m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        _patient setStamina(getStamina _patient + 300);
        [LLSTRING(Pervitin_mid2), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        _patient setStamina(getStamina _patient + 300);
        [LLSTRING(Pervitin_mid3), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 360] call CBA_fnc_waitAndExecute; /// 6m

    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        _patient setStamina(getStamina _patient - 60);
        [LLSTRING(Pervitin_mid4), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 510] call CBA_fnc_waitAndExecute; /// 8:30m


    [{
        params ["_patient"];

        if !(alive _patient) exitWith {};
        [LLSTRING(Pervitin_end), 2, _patient] call ACEFUNC(common,displayTextStructured);
    },
    [_patient], 600] call CBA_fnc_waitAndExecute; /// 10m

    ///Weapon sway normal arma

    if (GVAR(weapon_sway_pervitin)) then {

        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef 1;
            _patient setCustomAimCoef(getCustomAimCoef _patient) - 0.7;
        },
        [_patient], 15] call CBA_fnc_waitAndExecute;

        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.2;
        },
        [_patient], 60] call CBA_fnc_waitAndExecute;

        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.5;
        },
        [_patient], 90] call CBA_fnc_waitAndExecute;

        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.3;
        },
        [_patient], 120] call CBA_fnc_waitAndExecute; /// 2m


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.5;
        },
        [_patient], 150] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];
            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.2;
        },
        [_patient], 180] call CBA_fnc_waitAndExecute; /// 3m


        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) + 0.3;

        },
        [_patient], 210] call CBA_fnc_waitAndExecute;


        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) - 0.3;

        },
        [_patient], 240] call CBA_fnc_waitAndExecute; /// 4m


        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) - 0.3;

        },
        [_patient], 300] call CBA_fnc_waitAndExecute; /// 5m


        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef(getCustomAimCoef _patient) - 0.2;

        },
        [_patient], 420] call CBA_fnc_waitAndExecute; /// 7m


        [{
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setCustomAimCoef 1;

        },
        [_patient], 540] call CBA_fnc_waitAndExecute; /// 9m
    };
};

/// ChromAberration & CamShake effect

[QGVAR(pervitinPP), [_patient], _patient] call CBA_fnc_targetEvent;
