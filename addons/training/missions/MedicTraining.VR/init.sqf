// 1. SERVER-SIDE (Spawn logic and management)
if (isServer) then {
    spawned = false;
    publicVariable "spawned";

    // Store function globally so remoteExec can find it
    missionNamespace setVariable ["MYMOD_fnc_createPatient", compileFinal "
        params [""_mode""];
        private _pos = getPos hspawn;
        private _group = createGroup [civilian, true];
        private _patient = _group createUnit [""B_Soldier_F"", _pos, [], 0, ""NONE""];
        
        _patient disableAI ""MOVE"";
        _patient disableAI ""FSM"";

        missionNamespace setVariable [""MYMOD_lastPatient"", _patient, true];

        spawned = true;
        publicVariable ""spawned"";

        if (_mode == 1) then {
            [_patient, true] call ace_medical_fnc_setUnconscious;
            private _selections = [""body"", ""head"", ""hand_r"", ""hand_l"", ""leg_r"", ""leg_l""];
            for ""_i"" from 1 to 4 do {
                private _sel = selectRandom _selections;
                [_patient, 0.8, _sel, ""bullet""] call ace_medical_fnc_addDamageToUnit;
            };
        };
    ", true];

    // 2. PLAYER-SIDE (Laptop menu - executes for everyone who has the screen)
    waitUntil { !isNull (missionNamespace getVariable ["laptop", objNull]) };

    laptop addAction ["<t color='#00FF00'>[Patient] Spawn: Healthy</t>", {
        params ["_target", "_caller"];
        [0] remoteExec ["MYMOD_fnc_createPatient", 2];
        [format ["%1 spawned healthy patient.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "!spawned", 5];

    laptop addAction ["<t color='#FFCC00'>[Patient] Spawn: Random Injuries</t>", {
        params ["_target", "_caller"];
        [1] remoteExec ["MYMOD_fnc_createPatient", 2];
        [format ["%1 spawned an injured patient.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "!spawned", 5];

    laptop addAction ["<t color='#FF3333'>[Cardiac] Asystole (No Pulse, No Shock)</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            ["ace_medical_FatalVitals", [_patient], _patient] call CBA_fnc_targetEvent;
            _patient setVariable ["kat_circulation_cardiacArrestType", 0, true];
        } else {
            [_patient, true] call ace_medical_fnc_setUnconscious;
        };
        [format ["%1 - Asystole applied.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#FF7744'>[Cardiac] PEA (Fake Pulse, No Shock)</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            ["ace_medical_FatalVitals", [_patient], _patient] call CBA_fnc_targetEvent;
            _patient setVariable ["kat_circulation_cardiacArrestType", 1, true];
        } else {
            [_patient, true] call ace_medical_fnc_setUnconscious;
        };
        [format ["%1 - PEA applied.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#FFAA00'>[Cardiac] V-Fib (Fast Pulse, Shockable)</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            ["ace_medical_FatalVitals", [_patient], _patient] call CBA_fnc_targetEvent;
            _patient setVariable ["kat_circulation_cardiacArrestType", 2, true];
        } else {
            [_patient, true] call ace_medical_fnc_setUnconscious;
        };
        [format ["%1 - V-Fib applied.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#FFFF00'>[Cardiac] V-Tach (Fast Pulse, Shockable)</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            ["ace_medical_FatalVitals", [_patient], _patient] call CBA_fnc_targetEvent;
            _patient setVariable ["kat_circulation_cardiacArrestType", 3, true];
        } else {
            [_patient, true] call ace_medical_fnc_setUnconscious;
        };
        [format ["%1 - V-Tach applied.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#3399FF'>[Breathing] Tension Pneumothorax</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            _patient setVariable ["kat_breathing_tensionpneumothorax", true, true];
            _patient setVariable ["kat_breathing_pneumothorax", 4, true];
            [_patient] call kat_circulation_fnc_updateInternalBleeding;
        } else {
            [_patient, 0.8, "body", "wound"] call ace_medical_fnc_addDamageToUnit;
        };
        [format ["%1 added Tension Pneumothorax.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#9966FF'>[Breathing] Hemopneumothorax</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            _patient setVariable ["kat_breathing_hemopneumothorax", true, true];
            _patient setVariable ["kat_breathing_pneumothorax", 4, true];
            [_patient] call kat_circulation_fnc_updateInternalBleeding;
        } else {
            [_patient, 0.8, "body", "wound"] call ace_medical_fnc_addDamageToUnit;
        };
        [format ["%1 added Hemopneumothorax.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#CC66FF'>[Cardiac] Tamponade</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        if (isClass (configFile >> "CfgPatches" >> "kat_main")) then {
            [_patient] call kat_breathing_fnc_createTamponade;
        } else {
            [_patient, true] call ace_medical_fnc_setUnconscious;
        };
        [format ["%1 added Cardiac Tamponade.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#FF6600'>[Patient] Add: Random Damage</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!alive _patient) exitWith {
            [format ["%1 - No living patient!", name _caller]] remoteExec ["systemChat", _caller];
        };
        
        private _selections = ["body", "head", "hand_r", "hand_l", "leg_r", "leg_l"];
        private _damageTypes = ["grenade", "stab", "bullet", "falling"];
        private _count = 2 + floor random 5;
        for "_i" from 1 to _count do {
            private _sel = selectRandom _selections;
            private _dmg = 0.5 + random 0.5;
            private _type = selectRandom _damageTypes;
            [_patient, _dmg, _sel, _type] call ace_medical_fnc_addDamageToUnit;
        };
        [format ["%1 added %2 random injuries.", name _caller, _count]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];

    laptop addAction ["<t color='#FF0000'>[Patient] Delete patient</t>", {
        params ["_target", "_caller"];
        private _patient = missionNamespace getVariable ["MYMOD_lastPatient", objNull];
        if (!isNull _patient) then {
            deleteVehicle _patient;
        };
        
        spawned = false;
        publicVariable "spawned";
        [format ["%1 deleted the patient.", name _caller]] remoteExec ["systemChat", 0];
    }, nil, 1.5, true, true, "", "spawned", 5];
};