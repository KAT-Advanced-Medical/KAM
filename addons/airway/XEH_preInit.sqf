#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Airway"

/*
When a patient enters the unconscious state, there are two things that can happen.
First of all the airway can collapse. In medical sense this mean, the airway can be blocked from your tongue muscle, 'cause of the missing muscle tone.
For example in real life, this will happen to nearly every unconscious person lying on the back.

The second thing that can happen is the the airway occluded state. When a patient is lying on the back and the body puke, it will not leave the mouth space.
It will stay in there and can block the airway too. The right treatment here, is to remove this vomit.
In real life, this will happen sometimes, not quiet often.
*/

// Enable airway injuries
[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;


// airway Injuries Death Timer
[
    QGVAR(deathTimer),
    "SLIDER",
    localize LSTRING(SETTING_TIMER),
    CBA_SETTINGS_CAT,
    [0, 1800, 300, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability obstruction
[
    QGVAR(probability_obstruction),
    "SLIDER",
    localize LSTRING(SETTING_obstruction),
    CBA_SETTINGS_CAT,
    [0, 100, 20, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability occluded
[
    QGVAR(probability_occluded),
    "SLIDER",
    localize LSTRING(SETTING_occluded),
    CBA_SETTINGS_CAT,
    [0, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

// Succes for headturning
[
    QGVAR(probability_headturning),
    "SLIDER",
    [localize LSTRING(SUCCES_HEADTURNING),localize LSTRING(SUCCES_HEADTURNING_DESC)],
    CBA_SETTINGS_CAT,
    [1, 100, 50, 0],
    true
] call CBA_Settings_fnc_init;

// airway puking sound yes or no?
// somebody told me that the sound which is played then someone is puking is super annoying and now you can remove it easily
[
    QGVAR(checkbox_puking_sound),
    "CHECKBOX",
    localize LSTRING(SETTING_puking_sound),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(string_exit),
    "LIST",
    ["keko_wasPunched string", localize LSTRING(SETTING_exit)],
    CBA_SETTINGS_CAT,
    [["", "keko_wasPunched"], ["", "keko_wasPunched"], 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Larynxtubus per medical class
[
    QGVAR(medLvl_Larynxtubus),
    "LIST",
    [localize LSTRING(ALLOW_LARYNXTUBUS),localize LSTRING(ALLOW_LARYNXTUBUS_DESC)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

//Settable list for using Guedeltubus per medical class
[
    QGVAR(medLvl_Guedeltubus),
    "LIST",
    [localize LSTRING(ALLOW_GUEDELTUBUS),localize LSTRING(ALLOW_GUEDELTUBUS_DESC)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using Accuvac per medical class
[
    QGVAR(medLvl_Accuvac),
    "LIST",
    [localize LSTRING(ALLOW_ACCUVAC),localize LSTRING(ALLOW_ACCUVAC_DESC)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

// Settable action time for CheckAirway
[
    QGVAR(CheckAirway_time),
    "SLIDER",
    [localize LSTRING(TIME_CHECKAIRWAY),localize LSTRING(TIME_CHECKAIRWAY_DESC)],
    CBA_SETTINGS_CAT,
    [1, 10, 2, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Head turning
[
    QGVAR(TurnAround_time),
    "SLIDER",
    [localize LSTRING(TIME_HEADTURNING),localize LSTRING(TIME_HEADTURNING_DESC)],
    CBA_SETTINGS_CAT,
    [1, 10, 2, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Accuvac
[
    QGVAR(Accuvac_time),
    "SLIDER",
    [localize LSTRING(TIME_ACCUVAC),localize LSTRING(TIME_ACCUVAC_DESC)],
    CBA_SETTINGS_CAT,
    [1, 20, 8, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Larynxtubus
[
    QGVAR(Larynxtubus_time),
    "SLIDER",
    [localize LSTRING(TIME_LARYNXTUBUS),localize LSTRING(TIME_LARYNXTUBUS_DESC)],
    CBA_SETTINGS_CAT,
    [1, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Guedeltubus
[
    QGVAR(Guedeltubus_time),
    "SLIDER",
    [localize LSTRING(TIME_GUEDELTUBUS),localize LSTRING(TIME_GUEDELTUBUS_DESC)],
    CBA_SETTINGS_CAT,
    [1, 20, 6, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
