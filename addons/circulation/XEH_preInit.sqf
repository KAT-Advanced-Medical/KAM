#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Circulation"

[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_enable),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;


private _type = round random(3);
[
    QGVAR(bloodgroup),
    "LIST",
    localize LSTRING(SETTING_bloodtype),
    CBA_SETTINGS_CAT,
    [["A", "B", "AB", "O"], ["A", "B", "AB", "O"], _type],
    2,
    {
        player setVariable [QGVAR(bloodtype), _this, true];
        player setVariable ["ace_dogtags_dogtagData", nil, true];
    }
] call CBA_Settings_fnc_init;

ADDON = true;
