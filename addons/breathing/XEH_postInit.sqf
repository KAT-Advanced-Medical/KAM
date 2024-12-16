#include "script_component.hpp"

[QGVAR(pulseoxLocal), LINKFUNC(treatmentAdvanced_pulseoximeterLocal)] call CBA_fnc_addEventHandler;
[QGVAR(chestSealLocal), LINKFUNC(treatmentAdvanced_chestSealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(handleBreathing), LINKFUNC(handleBreathing)] call CBA_fnc_addEventHandler;
[QGVAR(hemopneumothoraxLocal), LINKFUNC(treatmentAdvanced_hemopneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(tensionpneumothoraxLocal), LINKFUNC(treatmentAdvanced_tensionpneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cyanosisLocal), LINKFUNC(treatmentAdvanced_CyanosisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(nasalCannulaLocal), LINKFUNC(treatmentAdvanced_nasalCannulaLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeNasalCannulaLocal), LINKFUNC(treatmentAdvanced_removeNasalCannulaLocal)] call CBA_fnc_addEventHandler;

[QGVAR(playCough), {
    params ["_unit"];
    _unit say3D [QGVAR(pneumothoraxcough), 15];
}] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

[QACEGVAR(medical_status,initialized), LINKFUNC(handleBreathingConditions)] call CBA_fnc_addEventHandler;

[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListWounds), LINKFUNC(gui_updateInjuryListWounds)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical,woundReceived),LINKFUNC(handlePulmoHit)] call CBA_fnc_addEventHandler;

private _items = missionNamespace getVariable [QGVAR(availOxyMask), "'G_AirPurifyingRespirator_01_F'"];
private _array = [_items, "CfgGlasses"] call EFUNC(chemical,getList);

missionNamespace setVariable [QGVAR(availOxyMaskList), _array, true];