#include "functions\function_macros.hpp"
LOGF_1("[%1] PreInit Begin", QUOTE(ADDON));

LOGF_1("[%1] PREP Begin", QUOTE(ADDON));
#include "XEH_PREP.sqf"
LOGF_1("[%1] PREP Complete", QUOTE(ADDON));

private _version = [] call FUNC(getVersion);
LOGF_2("%1 at version %2", QUOTE(ADDON), _version);

// ace_common_getVersion is broken for some patches, we look manually to ensure data is good, probably wont work everywhere.
getArray(configFile >> "CfgPatches" >> "ace_main" >> "versionAR") params ["_aceMajor", "_aceMinor"];

if(_aceMajor >= 3 && _aceMinor >= 13) then {
	LOG(format["ACE Version is >= 3.13"]);
	GVAR(aceAfter_313) = true;
}else{
	LOG(format["ACE Version is < 3.13"]);
	GVAR(aceAfter_313) = false;
};

if(_aceMajor >= 3 && _aceMinor >= 16) then {
	LOG(format["ACE Version is >= 3.16"]);
	GVAR(aceAfter_316) = true;
}else{
	LOG(format["ACE Version is < 3.16"]);
	GVAR(aceAfter_316) = false;
};

// Integrations Search
LOG("Searching for Integrations");

private _hasKAT = isClass(configFile >> "CfgPatches" >> "kat_main");
GVAR(KATInstalled) = _hasKAT;
LOGF_1("Found KAT: %1", _hasKAT);

LOG("Integration Search Complete");

LOGF_1("[%1] CBA Options Begin", QUOTE(ADDON));

#define LOC(module,name) localize LSTRING(module,name)
// General
private _generalCategory = [LOC(Settings,Addon_Name), LOC(Settings_General,Category)];
[QUOTE(GVAR(VERSION)), "CHECKBOX", [format[LOC(Settings_General,Version), _version], LOC(Settings_General,Version_Tooltip)], _generalCategory, false, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(EnableAVM)), "CHECKBOX", [LOC(Settings_General,Enable), LOC(Settings_General,Enable_Tooltip)], _generalCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(WarnViewingDead)), "CHECKBOX", [LOC(Settings_General,Warn_Selecting_Dead)], _generalCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(CacheInterval)), "SLIDER", [LOC(Settings_General,Cache_Interval), LOC(Settings_General,Cache_Interval_Tooltip)], _generalCategory, [0, 10, 0.4, 1], 0, {}] call CBA_fnc_addSetting;

// Incapacitated
private _incapacitatedCategory = [LOC(Settings,Addon_Name), LOC(Settings_Incapacitated,Category)];
[QUOTE(GVAR(EnableIncapacitated)), "CHECKBOX", [LOC(Settings_Incapacitated,Enable), LOC(Settings_Incapacitated,Enable_Tooltip)], _incapacitatedCategory, false, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Incapacitated_ShowCount)), "CHECKBOX", [format[LOC(Settings_Incapacitated,Show_Count), _version], LOC(Settings_Incapacitated,Show_Count_Tooltip)], _incapacitatedCategory, false, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Incapacitated_CanUnloadAll)), "CHECKBOX", [LOC(Settings_Incapacitated,Allow_Unload_All), LOC(Settings_Incapacitated,Allow_Unload_All_Tooltip)], _incapacitatedCategory, true, 0, {}] call CBA_fnc_addSetting;

// Unstable
private _unstableCategory = [LOC(Settings,Addon_Name), LOC(Settings_Unstable,Category)];
[QUOTE(GVAR(EnableUnstable)), "CHECKBOX", [LOC(Settings_Unstable,Enable), LOC(Settings_Unstable,Enable_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_ShowCount)), "CHECKBOX", [LOC(Settings_Unstable,Show_Count), LOC(Settings_Unstable,Show_Count_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackCardiacArrest)), "CHECKBOX", [LOC(Settings_Unstable,Track_Cardiac_Arrest), LOC(Settings_Unstable,Track_Cardiac_Arrest)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackBleeding)), "CHECKBOX", [LOC(Settings_Unstable,Track_Bleeding), LOC(Settings_Unstable,Track_Bleeding_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackUnconscious)), "CHECKBOX", [LOC(Settings_Unstable,Track_Unconscious), LOC(Settings_Unstable,Track_Unconscious_Tooltip)] ,_unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLowBP)), "CHECKBOX", [LOC(Settings_Unstable,Track_Low_Blood_Pressure), LOC(Settings_Unstable,Track_Low_Blood_Pressure_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_ThresholdLowBP)), "SLIDER", [LOC(Settings_Unstable,Low_Blood_Pressure_Threshold), LOC(Settings_Unstable,Low_Blood_Pressure_Threshold_Tooltip)], _unstableCategory, [1, 120, 80, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackIV)), "CHECKBOX", [LOC(Settings_Unstable,Track_IV), LOC(Settings_Unstable,Track_IV_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLowHR)), "CHECKBOX", [LOC(Settings_Unstable,Track_Low_Heart_Rate), LOC(Settings_Unstable,Track_Low_Heart_Rate_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_ThresholdLowHR)), "SLIDER", [LOC(Settings_Unstable,Low_Heart_Rate_Threshold), LOC(Settings_Unstable,Low_Heart_Rate_Threshold_Tooltip)], _unstableCategory, [1, 120, 50, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLegFractures)), "CHECKBOX", [LOC(Settings_Unstable,Track_Leg_Fractures), LOC(Settings_Unstable,Track_Leg_Fractures_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLegSplints)), "CHECKBOX", [LOC(Settings_Unstable,Track_Leg_Splints), LOC(Settings_Unstable,Track_Leg_Splints_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackDead)), "CHECKBOX", [LOC(Settings_Unstable,Track_Dead), LOC(Settings_Unstable,Track_Dead_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TakeDogtags)), "CHECKBOX", [LOC(Settings_Unstable,Take_Dogtags), LOC(Settings_Unstable,Take_Dogtags_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_DogtagsDeadOnly)), "CHECKBOX", [LOC(Settings_Unstable,Take_Dogtags_Dead_Only), LOC(Settings_Unstable,Take_Dogtags_Dead_Only_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_AllowUnload)), "CHECKBOX", [LOC(Settings_Unstable,Allow_Unload), LOC(Settings_Unstable,Allow_Unload_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;

// Stable
private _stableCategory = [LOC(Settings,Addon_Name), LOC(Settings_Stable,Category)];
[QUOTE(GVAR(EnableStable)), "CHECKBOX", [LOC(Settings_Stable,Enable),LOC(Settings_Stable,Enable_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_ShowCount)), "CHECKBOX", [LOC(Settings_Stable,Show_Count), LOC(Settings_Stable,Show_Count_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackNeedsBandage)), "CHECKBOX", [LOC(Settings_Stable,Track_Open_Wounds),LOC(Settings_Stable,Track_Open_Wounds_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackStitchableWounds)), "CHECKBOX", [LOC(Settings_Stable,Track_Stitchable_Wounds),LOC(Settings_Stable,Track_Stitchable_Wounds_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackLowBP)), "CHECKBOX", [LOC(Settings_Stable,Track_Low_Blood_Pressure),LOC(Settings_Stable,Track_Low_Blood_Pressure_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackIV)), "CHECKBOX", [LOC(Settings_Stable,Track_IV),LOC(Settings_Stable,Track_IV_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_ThresholdLowBP)), "SLIDER", [LOC(Settings_Stable,Low_Blood_Pressure_Threshold),LOC(Settings_Stable,Low_Blood_Pressure_Threshold_Tooltip)], _stableCategory, [1, 120, 80, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackLowHR)), "CHECKBOX", [LOC(Settings_Stable,Track_Low_Heart_Rate),LOC(Settings_Stable,Track_Low_Heart_Rate_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_ThresholdLowHR)), "SLIDER", [LOC(Settings_Stable,Low_Heart_Rate_Threshold),LOC(Settings_Stable,Low_Heart_Rate_Threshold_Tooltip)], _stableCategory, [1, 120, 50, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackFractures)), "CHECKBOX", [LOC(Settings_Stable,Track_Arm_Fractures),LOC(Settings_Stable,Track_Arm_Fractures_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackSplints)), "CHECKBOX", [LOC(Settings_Stable,Track_Arm_Splints),LOC(Settings_Stable,Track_Arm_Splints_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackTourniquets)), "CHECKBOX", [LOC(Settings_Stable,Track_Tourniquets),LOC(Settings_Stable,Track_Tourniquets_Tooltip)], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;

// Vehicles
private _vehicleCategory = [LOC(Settings,Addon_Name), LOC(Settings_Vehicles,Category)];

[QUOTE(GVAR(Vehicles_EnableCar)), "CHECKBOX", [LOC(Settings_Vehicles,Car), LOC(Settings_Vehicles,Car_Tooltip)], _vehicleCategory, true, 0, {}, true] call CBA_fnc_addSetting;
[QUOTE(GVAR(Vehicles_EnableHelicopter)), "CHECKBOX", [LOC(Settings_Vehicles,Helicopter), LOC(Settings_Vehicles,Helicopter_Tooltip)], _vehicleCategory, true, 0, {}, true] call CBA_fnc_addSetting;
[QUOTE(GVAR(Vehicles_EnablePlane)), "CHECKBOX", [LOC(Settings_Vehicles,Plane), LOC(Settings_Vehicles,Plane_Tooltip)], _vehicleCategory, true, 0, {}, true] call CBA_fnc_addSetting;
[QUOTE(GVAR(Vehicles_EnableShip)), "CHECKBOX", [LOC(Settings_Vehicles,Ship), LOC(Settings_Vehicles,Ship_Tooltip)], _vehicleCategory, true, 0, {}, true] call CBA_fnc_addSetting;
[QUOTE(GVAR(Vehicles_EnableTank)), "CHECKBOX", [LOC(Settings_Vehicles,Tank), LOC(Settings_Vehicles,Tank_Tooltip)], _vehicleCategory, true, 0, {}, true] call CBA_fnc_addSetting;

// KAT Integration
if(GVAR(KATInstalled)) then {
	[QUOTE(GVAR(EnableSupportKAT)), "CHECKBOX", [LOC(Settings_Integrations,Enable_KAT), LOC(Settings_Integrations,Enable_KAT_Tooltip)], [LOC(Settings,Addon_Name), LOC(Settings_Integrations,Category)], true, 0, {}] call CBA_fnc_addSetting;
	[QUOTE(GVAR(Unstable_TrackSpO2)), "CHECKBOX", [LOC(Settings_Unstable_KAT,Track_SpO2), LOC(Settings_Unstable_KAT,Track_SpO2_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
	[QUOTE(GVAR(Unstable_TrackAllPneumothorax)), "CHECKBOX", [LOC(Settings_Unstable_KAT,Track_Pneumothorax), LOC(Settings_Unstable_KAT,Track_Pneumothorax_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
	[QUOTE(GVAR(Unstable_TrackAirwayBlocked)), "CHECKBOX", [LOC(Settings_Unstable_KAT,Track_Blocked_Airways), LOC(Settings_Unstable_KAT,Track_Blocked_Airways_Tooltip)], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
} else
{
	GVAR(EnableSupportKAT) = false;
};

LOGF_1("[%1] CBA Options Complete", QUOTE(ADDON));

LOGF_1("[%1] PreInit Complete", QUOTE(ADDON));