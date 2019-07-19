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
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [true],
    true
] call CBA_Settings_fnc_init;


// airway Injuries Death Timer
[
    QGVAR(deathTimer),
    "SLIDER",
    localize LSTRING(SETTING_TIMER),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 1800, 300, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability obstruction
[
    QGVAR(probability_obstruction),
    "SLIDER",
    localize LSTRING(SETTING_obstruction),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 100, 20, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability occluded
[
    QGVAR(probability_occluded),
    "SLIDER",
    localize LSTRING(SETTING_occluded),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

// airway puking sound yes or no?
// somebody told me that the sound which is played then someone is puking is super annoying and now you can remove it easily
[
    QGVAR(checkbox_puking_sound),
    "CHECKBOX",
    localize LSTRING(SETTING_puking_sound),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(string_exit),
    "LIST",
    localize LSTRING(SETTING_exit),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [["", "keko_wasPunched"], ["", "keko_wasPunched"], 0],
    true
] call CBA_Settings_fnc_init;
