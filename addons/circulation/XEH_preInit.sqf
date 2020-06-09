#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Circulation"

[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;


private _type = round random(3);
[
    QGVAR(bloodgroup),
    "LIST",
    localize LSTRING(client_bt),
    CBA_SETTINGS_CAT,
    [["A", "B", "AB", "O"], ["A", "B", "AB", "O"], _type],
    2,
    {
        player setVariable [QGVAR(bloodtype), _this, true];
        player setVariable ["ace_dogtags_dogtagData", nil, true];
    }
] call CBA_Settings_fnc_init;

//Settable list for using AED-X per medical class
[
    QGVAR(medLvl_AED_X),
    "LIST",
    ["Allow AED-X", "Training level requied to use an AED-X"],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
    true
] call CBA_settings_fnc_init;

//Distance limit for AED-X
[
    QGVAR(distanceLimit_AEDX),
    "SLIDER",
    ["Distance limit for AED-X in meters"],
    CBA_SETTINGS_CAT,
    [2, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
    QGVAR(timeLimit_AEDX),
    "SLIDER",
    ["Time limit for monitor of AED-X in seconds"],
    CBA_SETTINGS_CAT,
    [60, 14400, 1800, 0],
    true
] call CBA_Settings_fnc_init;



ADDON = true;
