// ACE Advanced fatigue duty factors
[
    QGVAR(advancedFatigueDutyDefault),
    "SLIDER",
    ["Default duty factor", "Duty factor that is applied by default. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyCrouching),
    "SLIDER",
    ["Crouching duty factor", "Duty factor that is applied when a player is crouching. Higher means lower stamina drain.\nIf you want to negate the effect that crouching has on ACE advanced fatigue, you must set this setting to 1.5."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyProne),
    "SLIDER",
    ["Prone duty factor", "Duty factor that is applied when a player is prone. Higher means lower stamina drain.\nIf you want to negate the effect that prone has on ACE advanced fatigue, you must set this setting to 10."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyWeaponRaised),
    "SLIDER",
    ["Weapon raised duty factor", "Duty factor that is applied when a player has their weapon raised. Higher means lower stamina drain.\nIf you want to negate the effect that a raised weapon has on ACE advanced fatigue, you must set this setting to 1.2."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyAimingDownSights),
    "SLIDER",
    ["Aiming down sights duty factor", "Duty factor that is applied when a player is aiming down sights. Higher means lower stamina drain.\nIf you want to negate the effect that aiming down sights has on ACE advanced fatigue, you must set this setting to 1.5 and the raised weapon setting to 1.2."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutySwimming),
    "SLIDER",
    ["Swimming duty factor", "Duty factor that is applied when a player is swimming. Higher means lower stamina drain.\nIf you want to negate the effect that swimming has on ACE advanced fatigue, you must set this setting to 6.5."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyDiving),
    "SLIDER",
    ["Diving duty factor", "Duty factor that is applied when a player is diving. Higher means lower stamina drain.\nIf you want to negate the effect that diving has on ACE advanced fatigue, you must set this setting to 2.5."],
    [CBA_SETTINGS_CAT, "Normal"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

// Sprinting
[
    QGVAR(advancedFatigueDutyDefaultSprinting),
    "SLIDER",
    ["Default sprinting duty factor", "Duty factor that is applied by default when sprinting. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyCrouchingSprinting),
    "SLIDER",
    ["Crouch-sprinting duty factor", "Duty factor that is applied when a player is crouch-sprinting. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyProneSprinting),
    "SLIDER",
    ["Prone-sprinting duty factor", "Duty factor that is applied when a player is prone-sprinting. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyWeaponRaisedSprinting),
    "CHECKBOX",
    ["Weapon-raised-sprinting compensation", "If enabled and sprinting, it will not apply the 'Weapon raised duty factor' setting."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutySwimmingSprinting),
    "SLIDER",
    ["Swim-sprinting duty factor", "Duty factor that is applied when a player is swim-sprinting. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

[
    QGVAR(advancedFatigueDutyDivingSprinting),
    "SLIDER",
    ["Dive-sprinting duty factor", "Duty factor that is applied when a player is dive-sprinting. Higher means lower stamina drain."],
    [CBA_SETTINGS_CAT, "Sprinting"],
    DEFAULT_SETTINGS
] call CBA_fnc_addSetting;

// Muscle damage
[
    QGVAR(muscleDamageFactor),
    "SLIDER",
    ["Muscle damage factor", "Factor that is applied to muscle damage. If set to 0, muscle damage is disabled."],
    [CBA_SETTINGS_CAT, "Muscle Damage"],
    [0, 1.5, 1, 6]
] call CBA_fnc_addSetting;

// AE reserves
[
    QGVAR(ae1ReserveFactor),
    "SLIDER",
    ["AE1 Reserve recovery factor", "Recovery factor that is applied to the AE1 Reserve. If set to < 0, the AE1 Reserve are kept at maximum."],
    [CBA_SETTINGS_CAT, "Energy Reserves"],
    [-0.01, 1.5, 1, 6]
] call CBA_fnc_addSetting;

[
    QGVAR(ae2ReserveFactor),
    "SLIDER",
    ["AE2 Reserve recovery factor", "Recovery factor that is applied to the AE2 Reserve. If set to < 0, the AE2 Reserve are kept at maximum."],
    [CBA_SETTINGS_CAT, "Energy Reserves"],
    [-0.01, 1.5, 1, 6]
] call CBA_fnc_addSetting;

// AN reserve & fatigue
[
    QGVAR(anReserveFactor),
    "SLIDER",
    ["AN Reserve recovery factor", "Recovery factor that is applied to the AN Reserve. If set to < 0, the AN Reserve are kept at maximum."],
    [CBA_SETTINGS_CAT, "Energy Reserves"],
    [-0.01, 1.5, 1, 6]
] call CBA_fnc_addSetting;

[
    QGVAR(anFatigueFactor),
    "SLIDER",
    ["AN Fatigue factor", "Factor that is applied to the AN Fatigue. If set to 0, the AN Fatigue is disabled, but you must set 'anReserveFactor' to > 1, otherwise the AN Reserve will not recover."],
    [CBA_SETTINGS_CAT, "Energy Reserves"],
    [0, 1.5, 1, 6]
] call CBA_fnc_addSetting;

// Alternative running compat
if (isClass (configFile >> "CfgPatches" >> "Alternative_Running")) then {
    [
        QGVAR(advancedFatigueDutyAlternativeRunning),
        "SLIDER",
        ["Alternative running duty factor", "Duty factor that is applied when using alternative running. Higher means lower stamina drain."],
        [CBA_SETTINGS_CAT, "Compats"],
        DEFAULT_SETTINGS
    ] call CBA_fnc_addSetting;
};

// AVS compat
if (isClass (configFile >> "CfgPatches" >> "APS_System")) then {
    [
        QGVAR(advancedFatigueDutyAVSVault),
        "SLIDER",
        ["AVS vaulting duty factor", "Duty factor that is applied when using alternative running. Higher means lower stamina drain."],
        [CBA_SETTINGS_CAT, "Compats"],
        DEFAULT_SETTINGS
    ] call CBA_fnc_addSetting;

    [
        QGVAR(advancedFatigueDutyAVSClimb),
        "SLIDER",
        ["AVS climbing duty factor", "Duty factor that is applied when using alternative running. Higher means lower stamina drain."],
        [CBA_SETTINGS_CAT, "Compats"],
        DEFAULT_SETTINGS
    ] call CBA_fnc_addSetting;

    [
        QGVAR(advancedFatigueDutyAVSJump),
        "SLIDER",
        ["AVS jumping duty factor", "Duty factor that is applied when using alternative running. Higher means lower stamina drain."],
        [CBA_SETTINGS_CAT, "Compats"],
        DEFAULT_SETTINGS
    ] call CBA_fnc_addSetting;

    [
        QGVAR(advancedFatigueDutyAVSSlide),
        "SLIDER",
        ["AVS sliding duty factor", "Duty factor that is applied when using alternative running. Higher means lower stamina drain."],
        [CBA_SETTINGS_CAT, "Compats"],
        DEFAULT_SETTINGS
    ] call CBA_fnc_addSetting;
};

// 'ace_advanced_fatigue_enabled' can only be set at mission start
["CBA_settingsInitialized", {
    if (!ace_advanced_fatigue_enabled) exitWith {};

    [{
        if (!alive ACE_player || isGamePaused) exitWith {};

        ace_advanced_fatigue_muscleDamage = ace_advanced_fatigue_muscleDamage * GVAR(muscleDamageFactor);

        if (GVAR(ae1ReserveFactor) < 0) then {
            ace_advanced_fatigue_ae1Reserve = AE1_MAXRESERVE;
        } else {
            ace_advanced_fatigue_ae1Reserve = ((ace_advanced_fatigue_ae1Reserve * GVAR(ae1ReserveFactor)) min AE1_MAXRESERVE) max 0;
        };

        if (GVAR(ae2ReserveFactor) < 0) then {
            ace_advanced_fatigue_ae2Reserve = AE2_MAXRESERVE;
        } else {
            ace_advanced_fatigue_ae2Reserve = ((ace_advanced_fatigue_ae2Reserve * GVAR(ae2ReserveFactor)) min AE2_MAXRESERVE) max 0;
        };

        if (GVAR(anReserveFactor) < 0) then {
            ace_advanced_fatigue_anReserve = AN_MAXRESERVE;
        } else {
            ace_advanced_fatigue_anReserve = ((ace_advanced_fatigue_anReserve * GVAR(anReserveFactor)) min AN_MAXRESERVE) max 0;
        };

        ace_advanced_fatigue_anFatigue = ((ace_advanced_fatigue_anFatigue * GVAR(anFatigueFactor)) min 1) max 0;
    }, 1] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
