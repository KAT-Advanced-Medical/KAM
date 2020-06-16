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

//location for AED - Defi:
[
	QGVAR(useLocation_AED),
	"LIST",
	[localize LSTRING(LOCATION_AED),localize LSTRING(LOCATION_AED_DESCRIPTION)],
	CBA_SETTINGS_CAT,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
	true
] call CBA_Settings_fnc_init;

//Succes chance for AED-X
[
    QGVAR(SuccesCh_AED_X),
    "SLIDER",
    localize LSTRING(SUCESSCHANCE_AED_X),
    CBA_SETTINGS_CAT,
    [1, 100, 85, 0],
    true
] call CBA_Settings_fnc_init;

//Succes chance for AED
[
    QGVAR(SuccesCh_AED),
    "SLIDER",
    localize LSTRING(SUCESSCHANCE_AED),
    CBA_SETTINGS_CAT,
    [1, 100, 80, 0],
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
    [localize LSTRING(ALLOW_AED_X),localize LSTRING(TRAINING_LEVEL_AED_X)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
    true
] call CBA_settings_fnc_init;

//Distance limit for AED-X
[
    QGVAR(distanceLimit_AEDX),
    "SLIDER",
    localize LSTRING(DISTANCELIMIT_AED_X),
    CBA_SETTINGS_CAT,
    [2, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
    QGVAR(timeLimit_AEDX),
    "SLIDER",
    localize LSTRING(TIMELIMIT_AED_X),
    CBA_SETTINGS_CAT,
    [60, 14400, 1800, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
