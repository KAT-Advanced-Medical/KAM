#include "script_component.hpp"
/*
 * Author: YetheSamartaka
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_misc_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

if (!local _unit) exitWith {};

// KAT Airway

_unit setVariable ["kat_airway_obstruction", false, true]; // predelat aby to bylo vic citelné
_unit setVariable ["kat_airway_airway", false, true];
_unit setVariable ["kat_airway_overstretch", false, true];
_unit setVariable ["kat_airway_startTime", 0, true];
_unit setVariable ['kat_AEDinUse', false, true];
KAT_forceWakeup = false;

// KAT Breathing

_unit setVariable ["KAT_medical_airwayStatus", 100, true];
_unit setVariable ["KAT_medical_airwayOccluded", false, true];
_unit setVariable ["KAT_medical_pneumothorax", false, true];
_unit setVariable ["KAT_medical_hemopneumothorax", false, true];
_unit setVariable ["KAT_medical_tensionpneumothorax", false, true];
_unit setVariable ["KAT_medical_activeChestSeal", false, true];

_unit setVariable ["kat_breathing_pulseoximeter", false, true];
_unit setVariable ["kat_PulseoxiInUse_PFH", nil];
_unit setVariable ["kat_breathing_o2", false, true];
_unit setVariable ["KAT_circulation_X", false, true];
_unit setVariable [QGVAR(recovery), false, true];

// KAT Circulation

_unit setVariable ["KAT_circulation_IV_counts", 0, true];
_unit setVariable ["KAT_circulation_X", false, true];
_unit setVariable ["kat_AEDXPatient_PFH", nil];
_unit setVariable ["KAT_circulation_X_sound1", "x\kat\addons\circulation\sounds\noheartrate.wav", true];
_unit setVariable ["KAT_circulation_X_sound2", "x\kat\addons\circulation\sounds\heartrate.wav", true];
_unit setVariable ["KAT_circulation_use", false, true];
_unit setVariable ["KAT_circulation_returnedAED", false, true];

// KAT Pharmacy

_unit setVariable ["kat_pharma_flowRate", 1, true];
_unit setVariable ["kat_pharma_IVplaced", false, true];
_unit setVariable ["kat_pharma_usedIV", "", true];
_unit setVariable ["kat_pharma_IV_counts", 0, true];
_unit setVariable ["kat_pharma_IVsite", 0, true];
_unit setVariable ["kat_pharma_ondUse", false, true];
_unit setVariable ["kat_pharma_active", false, true];
_unit setVariable ["kat_IVPharma_PFH", nil];


// Part of KAT Airway: This is a temp workaround till the adjustSPO2 part is rewritten
_unit spawn {
    _unit = param [0,objNull,[objNull]];
    sleep 2;
    if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};
    _unit setVariable [QGVAR(airway_item), "", true];
}