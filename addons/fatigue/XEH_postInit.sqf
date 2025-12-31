#include "script_component.hpp"

// Duty < 1: Reduces fatigue impact; duty > 1 increases fatigue impact
// https://github.com/acemod/ACE3/blob/master/addons/advanced_fatigue/functions/fnc_getAnimDuty.sqf
[QGVAR(advancedFatigueDuty), {
    params ["_unit"];

    private _duty = 1;
    private _animName = animationState _unit;
    private _animType = _animName select [1, 3];

    if (_animType in ["idl", "mov", "adj"]) then {
        switch (_animName select [5, 3]) do {
            // Crouching
            case "knl": {
                _duty = 1 / ([GVAR(advancedFatigueDutyCrouching), GVAR(advancedFatigueDutyCrouchingSprinting)] select GVAR(sprinting));
            };
            // Prone
            case "pne": {
                _duty = 1 / ([GVAR(advancedFatigueDutyProne), GVAR(advancedFatigueDutyProneSprinting)] select GVAR(sprinting));
            };
            default {
                _duty = 1 / ([GVAR(advancedFatigueDutyDefault), GVAR(advancedFatigueDutyDefaultSprinting)] select GVAR(sprinting));
            };
        };

        if (currentWeapon _unit != handgunWeapon _unit) then {
            // Low ready jog (weapon up, but not ADS)
            if (_animName select [13, 3] == "ras") then {
                // Only compensate when sprinting and if setting enabled
                if (!GVAR(advancedFatigueDutyWeaponRaisedSprinting) || !GVAR(sprinting)) then {
                    _duty = _duty / GVAR(advancedFatigueDutyWeaponRaised);
                };

                // High ready jog/walk (weapon up and ADS); Sprinting not possible here
                if (_animName select [9, 3] == "tac") then {
                    _duty = _duty / GVAR(advancedFatigueDutyAimingDownSights);
                };
            };
        };
    } else {
        // Swimming and diving
        switch (true) do {
            // Swimming
            case (_animType in ["swm", "ssw", "bsw"]): {
                _duty = 1 / ([GVAR(advancedFatigueDutySwimming), GVAR(advancedFatigueDutySwimmingSprinting)] select GVAR(sprinting));
            };
            // Diving
            case (_animType in ["dve", "sdv", "bdv"]): {
                _duty = 1 / ([GVAR(advancedFatigueDutyDiving), GVAR(advancedFatigueDutyDivingSprinting)] select GVAR(sprinting));
            };
        };
    };

    _duty
}] call ACEFUNC(advanced_fatigue,addDutyFactor);

// Alternative Running - compat
if (isClass (configFile >> "CfgPatches" >> "Alternative_Running")) then {
    [QGVAR(advancedFatigueAlternativeRunningDuty), {
        params ["_unit"];

        private _duty = 1;

        if ((animationState _unit) in ["arma_alternativerunwithlauncher", "arma_alternativepistol", "arma_alternativerun_water_light", "arma_alternativerun", "arma_alternativerunlowered", "arma_alternativerun_water_heavy", "arma_alternativerun_ww2style"]) then {
            _duty = 1 / GVAR(advancedFatigueDutyAlternativeRunning);
        };

        _duty
    }] call ACEFUNC(advanced_fatigue,addDutyFactor);
};

// Advanced Vault System: Remastered - compat
if (isClass (configFile >> "CfgPatches" >> "APS_System")) then {
    [QGVAR(advancedFatigueAVSRemasteredDuty), {
        params ["_unit"];

        private _animName = animationState _unit;

        switch (true) do {
            // Vaulting
            case (_animName in [
                "mainweapon_vault_fast", "pistol_vault_fast", "unarmed_vault_fast", "mainweapon_vault_slow", "pistol_vault_fast", "unarmed_vault_slow", "mainweapon_vault_little", "pistol_vault_little", "unarmed_vault_little",
                "mainweapon_vault_middle", "pistol_vault_middle", "unarmed_vault_middle", "mainweapon_vault_middle_over", "pistol_vault_middle_over", "unarmed_vault_middle_over"
            ]): {
                1 / GVAR(advancedFatigueDutyAVSVault)
            };
            // Climbing
            case (_animName in ["mainweapon_climb_on", "unarmed_climb_on", "mainweapon_climb_on_over", "unarmed_climb_on_over", "unarmed_in_air_grab_middle", "unarmed_in_air_grab_high"]): {
                1 / GVAR(advancedFatigueDutyAVSClimb)
            };
            // Jumping
            case (_animName in ["mainweapon_jump_land_roll", "pistol_jump_land_roll", "unarmed_jump_land_roll"]): {
                1 / GVAR(advancedFatigueDutyAVSJump)
            };
            // Sliding
            case (_animName in ["mainweapon_slide", "pistol_slide"]): {
                1 / GVAR(advancedFatigueDutyAVSSlide)
            };
            default {
                1
            };
        }
    }] call ACEFUNC(advanced_fatigue,addDutyFactor);
};

GVAR(sprinting) = false;

addUserActionEventHandler ["turbo", "Activate", {
    GVAR(sprinting) = true;
}];

addUserActionEventHandler ["turbo", "Deactivate", {
    GVAR(sprinting) = false;
}];
