#include "..\script_component.hpp"
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

_unit setVariable [QEGVAR(airway,obstruction), false, true];
_unit setVariable [QEGVAR(airway,airway), false, true];
_unit setVariable [QEGVAR(airway,occluded), false, true];
_unit setVariable [QEGVAR(airway,overstretch), false, true];
_unit setVariable [QEGVAR(airway,wasOccluded), false];
KAT_forceWakeup = false;
_unit setVariable [QEGVAR(airway,recovery), false, true];
_unit setVariable [QEGVAR(airway,airway_item), "", true];
_unit setVariable [QEGVAR(airway,clearedTime), 0, true];

// KAT Brain

_unit setVariable [QEGVAR(brain,CMR),20,true];
_unit setVariable [QEGVAR(brain,CBF),800,true];
_unit setVariable [QEGVAR(brain,CVR),0.1,true];
_unit setVariable [QEGVAR(brain,ICP),10,true];
_unit setVariable [QEGVAR(brain,CPR),100,true];
_unit setVariable [QEGVAR(brain,rO2),80,true];
_unit setVariable [QEGVAR(brain,necrosis),0,true];
_unit setVariable [QGVAR(deoxygenatedTicks),0,true];
_unit setVariable [QEGVAR(brain,reversibleDamage),0,true];
_unit setVariable [QEGVAR(brain,autoregulationPFH), [_unit] call EFUNC(brain,handleAutoregulation),true];
_unit setVariable [QEGVAR(brain,activityPFH), [_unit] call EFUNC(brain,handleBrainActivity),true];


// KAT Breathing

_unit setVariable [QEGVAR(breathing,airwayStatus), 100, true];
_unit setVariable [QEGVAR(breathing,pneumothorax), 0, true];
_unit setVariable [QEGVAR(breathing,hemopneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,tensionpneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];
_unit setVariable [QEGVAR(breathing,deepPenetratingInjury), false, true];
_unit setVariable [QEGVAR(breathing,PneumoBreathCooldownOn), false, true];

_unit setVariable [QEGVAR(breathing,BVMInUse), false, true];
_unit setVariable [QEGVAR(breathing,oxygenTankConnected), false, true];
_unit setVariable [QEGVAR(breathing,oxygenTankPreferred), "", true];

_unit setVariable [QEGVAR(breathing,pulseoximeter), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_Volume), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_VolumePatient), false, true];
_unit setVariable [QEGVAR(breathing,PulseOximeter_Attached), [0,0], true];

_unit setVariable ["kat_PulseoxiInUse_PFH", nil, true];
_unit setVariable ["kat_O2Breathing_PFH", nil, true];

_unit setVariable [QEGVAR(breathing,usingStethoscope), nil];

// KAT Circulation

_unit setVariable ["kat_AEDXPatient_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_HR_PFH", nil, true];
_unit setVariable ["kat_AEDXPatient_PulseOx_PFH", nil, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_Charged), false, true];
_unit setVariable [QEGVAR(circulation,DefibrillatorPads_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_MedicVitalsMonitor_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_MedicVitalsMonitor_Patient), nil, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Connected), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Provider), nil, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Volume), false, true];
_unit setVariable [QEGVAR(circulation,AED_X_VitalsMonitor_VolumePatient), false, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_Provider), nil, true];
_unit setVariable [QEGVAR(circulation,Defibrillator_ShockAmount), 0, true];
_unit setVariable [QEGVAR(circulation,DefibrillatorInUse), false, true];
_unit setVariable [QEGVAR(circulation,MedicDefibrillatorInUse), false, true];
_unit setVariable [QEGVAR(circulation,MedicDefibrillator_Patient), nil, true];
_unit setVariable [QEGVAR(circulation,cardiacArrestType), 0, true];
_unit setVariable [QEGVAR(circulation,heartRestart), false, true];
_unit setVariable [QEGVAR(circulation,cprCount), 2, true];
_unit setVariable [QEGVAR(circulation,bloodtype), [_unit, _dead, true] call EFUNC(circulation,generateBloodType), true];
_unit setVariable [QEGVAR(circulation,internalBleeding), 0, true];
_unit setVariable [QEGVAR(circulation,StoredBloodPressure), [0,0], true];

_unit setVariable [VAR_BLOODPRESSURE_CHANGE, nil, true];

_unit setVariable [QEGVAR(circulation,isPerformingCPR), false, true];
_unit setVariable [QEGVAR(circulation,OxygenationPeriod), 0, true];

// KAT Misc
_unit setVariable [QEGVAR(misc,isLeftArmFree), true, true];
_unit setVariable [QEGVAR(misc,isRightArmFree), true, true];
_unit setVariable [QEGVAR(misc,isLeftLegFree), true, true];
_unit setVariable [QEGVAR(misc,isRightLegFree), true, true];
_unit setVariable [QGVAR(isLeftArmFree), true, true];
_unit setVariable [QGVAR(isRightArmFree), true, true];
_unit setVariable [QGVAR(isLeftLegFree), true, true];
_unit setVariable [QGVAR(isRightLegFree), true, true];

_unit setVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_PFH), -1];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];

[QGVAR(handleRespawn), _unit] call CBA_fnc_localEvent;
