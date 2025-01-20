#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Conversion"

[
    QGVAR(enable),
    "CHECKBOX",
    [LLSTRING(CONVERSION_ENABLE), LLSTRING(CONVERSION_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableConversionMessage),
    "CHECKBOX",
    [LLSTRING(CONVERSION_MESSAGE), LLSTRING(CONVERSION_MESSAGE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableTicketConversion),
    "CHECKBOX",
    [LLSTRING(CONVERSION_TICKET_CONVERSION), LLSTRING(CONVERSION_TICKET_CONVERSION_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(ticketConversionGain),
    "SLIDER",
    [LLSTRING(CONVERSION_TICKET_CONVERSION_GAIN), LLSTRING(CONVERSION_TICKET_CONVERSION_GAIN_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableLiberationConversion),
    "CHECKBOX",
    [LLSTRING(CONVERSION_LIBERATION_CONVERSION), LLSTRING(CONVERSION_LIBERATION_CONVERSION_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableLiberationConversionGain),
    "SLIDER",
    [LLSTRING(CONVERSION_LIBERATION_CONVERSION_GAIN), LLSTRING(CONVERSION_LIBERATION_CONVERSION_GAIN_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 50, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableLiberationConversionDistance),
    "SLIDER",
    [LLSTRING(CONVERSION_LIBERATION_CONVERSION_DISTANCE), LLSTRING(CONVERSION_LIBERATION_CONVERSION_DISTANCE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 5000, 1000, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableSpectatorRespawn),
    "CHECKBOX",
    [LLSTRING(CONVERSION_SPECTATOR_RESPAWN), LLSTRING(CONVERSION_SPECTATOR_RESPAWN_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(forceVehicleConversion),
    "CHECKBOX",
    [LLSTRING(CONVERSION_FORCE_VEHICLE), LLSTRING(CONVERSION_FORCE_VEHICLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(convertVehicles),
    "EDITBOX",
    [LLSTRING(CONVERSION_FORCE_VEHICLE_LIST), LLSTRING(CONVERSION_FORCE_VEHICLE_LIST_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    "'kat_stretcher'",
    1,
    {
        private _array = [_this, "CfgVehicles"] call EFUNC(chemical,getList);
        missionNamespace setVariable [QGVAR(convertVehicles), _array, true];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowManualConversion),
    "CHECKBOX",
    [LLSTRING(CONVERSION_MANUAL_CONVERSION), LLSTRING(CONVERSION_MANUAL_CONVERSION_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(manualConversionLevel),
    "LIST",
    [LLSTRING(CONVERSION_MANUAL_CONVERSION_LEVEL), LLSTRING(CONVERSION_MANUAL_CONVERSION_LEVEL_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(manualConversionLocation),
    "LIST",
    [LLSTRING(CONVERSION_MANUAL_CONVERSION_LOCATION), LLSTRING(CONVERSION_MANUAL_CONVERSION_LOCATION_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(manualConversionTime),
    "SLIDER",
    [LLSTRING(CONVERSION_LIBERATION_CONVERSION_TIME)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 60, 15, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;