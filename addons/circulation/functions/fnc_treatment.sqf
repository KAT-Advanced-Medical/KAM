#include "script_component.hpp"
/*
 * Author: Glowbal, KoffeinFlummi, mharis001
 * Starts the treatment process.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Treatment Started <BOOL>
 *
 * Example:
 * [player, cursorObject, "Head", "BasicBandage"] call ace_medical_treatment_fnc_treatment
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname"];

// Delay by a frame if cursor menu is open to prevent progress bar failing
if (uiNamespace getVariable [QACEGVAR(interact_menu,cursorMenuOpened), false]) exitWith {
    [ACEFUNC(medical_treatment,treatment), _this] call CBA_fnc_execNextFrame;
};

if !(_this call ACEFUNC(medical_treatment,canTreat)) exitWith {false};

private _config = configFile >> "ace_medical_treatment_actions" >> _classname;

// Get treatment time from config, exit if treatment time is zero
private _treatmentTime = if (isText (_config >> "treatmentTime")) then {
    GET_FUNCTION(_treatmentTime,_config >> "treatmentTime");

    if (_treatmentTime isEqualType {}) then {
        _treatmentTime = call _treatmentTime;
    };

    _treatmentTime
} else {
    getNumber (_config >> "treatmentTime");
};

if (_treatmentTime == 0) exitWith {false};

// Consume one of the treatment items if needed
// Store item user so that used item can be returned on failure
private _userAndItem = if (GET_NUMBER_ENTRY(_config >> "consumeItem") == 1) then {
    [_medic, _patient, getArray (_config >> "items")] call ACEFUNC(medical_treatment,useItem);
} else {
    [objNull, ""]; // Treatment does not require items to be consumed
};

_userAndItem params ["_itemUser", "_usedItem"];

// Patient Animation Added from Old Ace
if (alive _patient) then {
    private _patientAnim = getText (_config >> "animationPatient");
    if (_patient getVariable ["ACE_isUnconscious", false]) then {
        if !(animationState _patient in (getArray (_config >> "animationPatientUnconsciousExcludeOn"))) then {
            _patientAnim = getText (_config >> "animationPatientUnconscious");
        };
    };

    if (_medic != _patient && {vehicle _patient == _patient} && {_patientAnim != ""}) then {
        if (_patient getVariable ["ACE_isUnconscious", false]) then {
            [_patient, _patientAnim, 2] call ACEFUNC(common,doAnimation);
        } else {
            [_patient, _patientAnim, 1] call ACEFUNC(common,doAnimation);
        };
    };
};
//Old Ace Ending here

// Get treatment animation for the medic
private _medicAnim = if (_medic isEqualTo _patient) then {
    getText (_config >> ["animationMedicSelf", "animationMedicSelfProne"] select (stance _medic == "PRONE"));
} else {
    getText (_config >> ["animationMedic", "animationMedicProne"] select (stance _medic == "PRONE"));
};

_medic setVariable [QACEGVAR(medical_treatment,selectedWeaponOnTreatment), weaponState _medic];

// Adjust animation based on the current weapon of the medic
private _wpn = ["non", "rfl", "lnr", "pst"] param [["", primaryWeapon _medic, secondaryWeapon _medic, handgunWeapon _medic] find currentWeapon _medic, "non"];
_medicAnim = [_medicAnim, "[wpn]", _wpn] call CBA_fnc_replace;

// This animation is missing, use alternative
if (_medicAnim == "AinvPknlMstpSlayWlnrDnon_medic") then {
    _medicAnim = "AinvPknlMstpSlayWlnrDnon_medicOther";
};

// Determine the animation length
private _animDuration = ACEGVAR(medical_treatment,animDurations) getVariable _medicAnim;
if (isNil "_animDuration") then {
    WARNING_2("animation [%1] for [%2] has no duration defined",_medicAnim,_classname);
    _animDuration = 10;
};

// These animations have transitions that take a bit longer...
if (weaponLowered _medic) then {
    _animDuration = _animDuration + 0.5;

    // Fix problems with lowered weapon transitions by raising the weapon first
    if (currentWeapon _medic != "" && {_medicAnim != ""}) then {
        _medic action ["WeaponInHand", _medic];
    };
};

if (binocular _medic != "" && {binocular _medic == currentWeapon _medic}) then {
    _animDuration = _animDuration + 1;
};

// Play treatment animation for medic and determine the ending animation
if (vehicle _medic == _medic && {_medicAnim != ""}) then {
    // Speed up animation based on treatment time (but cap max to prevent odd animiations/cam shake)
    private _animRatio = _animDuration / _treatmentTime;
    TRACE_3("setAnimSpeedCoef",_animRatio,_animDuration,_treatmentTime);

    // Don't slow down animation too much to prevent it looking funny.
    if (_animRatio < ANIMATION_SPEED_MIN_COEFFICIENT) then {
        _animRatio = ANIMATION_SPEED_MIN_COEFFICIENT;
    };

    // Skip animation enitrely if progress bar too quick.
    if (_animRatio > ANIMATION_SPEED_MAX_COEFFICIENT) exitWith {};

    [QACEGVAR(common,setAnimSpeedCoef), [_medic, _animRatio]] call CBA_fnc_globalEvent;

    // Play animation
    private _endInAnim = "AmovP[pos]MstpS[stn]W[wpn]Dnon";

    private _pos = ["knl", "pne"] select (stance _medic == "PRONE");
    private _stn = "non";

    if (_wpn != "non") then {
        _stn = ["ras", "low"] select (weaponLowered _medic);
    };

    _endInAnim = [_endInAnim, "[pos]", _pos] call CBA_fnc_replace;
    _endInAnim = [_endInAnim, "[stn]", _stn] call CBA_fnc_replace;
    _endInAnim = [_endInAnim, "[wpn]", _wpn] call CBA_fnc_replace;

    [_medic, _medicAnim] call ACEFUNC(common,doAnimation);
    [_medic, _endInAnim] call ACEFUNC(common,doAnimation);
    _medic setVariable [QACEGVAR(medical_treatment,endInAnim), _endInAnim];

    if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
        ACEGVAR(advanced_fatigue,setAnimExclusions) pushBack "ace_medical_treatment";
    };
};

// Play a random treatment sound globally if defined
// Don't attempt to play if sounds array is empty
if (isArray (_config >> "sounds") && count getArray (_config >> "sounds") != 0) then {
    selectRandom getArray (_config >> "sounds") params ["_file", ["_volume", 1], ["_pitch", 1], ["_distance", 10]];
    playSound3D [_file, objNull, false, getPosASL _medic, _volume, _pitch, _distance];
};

GET_FUNCTION(_callbackStart,_config >> "callbackStart");
GET_FUNCTION(_callbackProgress,_config >> "callbackProgress");

if (_callbackProgress isEqualTo {}) then {
    _callbackProgress = {true};
};

[_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem] call _callbackStart;

[
    _treatmentTime,
    [_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem],
    ACEFUNC(medical_treatment,treatmentSuccess),
    ACEFUNC(medical_treatment,treatmentFailure),
    getText (_config >> "displayNameProgress"),
    _callbackProgress,
    ["isNotInside"]
] call ACEFUNC(common,progressBar);

true
