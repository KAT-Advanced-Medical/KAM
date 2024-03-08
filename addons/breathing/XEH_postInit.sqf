#include "script_component.hpp"

[QGVAR(pulseoxLocal), LINKFUNC(treatmentAdvanced_pulseoximeterLocal)] call CBA_fnc_addEventHandler;
[QGVAR(chestSealLocal), LINKFUNC(treatmentAdvanced_chestSealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(handleBreathing), LINKFUNC(handleBreathing)] call CBA_fnc_addEventHandler;
[QGVAR(hemopneumothoraxLocal), LINKFUNC(treatmentAdvanced_hemopneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(tensionpneumothoraxLocal), LINKFUNC(treatmentAdvanced_tensionpneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cyanosisLocal), LINKFUNC(treatmentAdvanced_CyanosisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lowSpO2pp), LINKFUNC(lowSpO2pp)] call CBA_fnc_addEventHandler;
[QGVAR(nasalCannulaLocal), LINKFUNC(treatmentAdvanced_nasalCannulaLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeNasalCannulaLocal), LINKFUNC(treatmentAdvanced_removeNasalCannulaLocal)] call CBA_fnc_addEventHandler;

[QGVAR(playCough), {
    params ["_unit"];
    _unit say3D [QGVAR(pneumothoraxcough), 15];
}] call CBA_fnc_addEventHandler;

[QACEGVAR(medical,woundReceived),LINKFUNC(handlePulmoHit)] call CBA_fnc_addEventHandler;

["kat_oxygenTank_300_Item", "kat_oxygenTank_300"] call ACEFUNC(common,registerItemReplacement);
["kat_oxygenTank_150_Item", "kat_oxygenTank_150"] call ACEFUNC(common,registerItemReplacement);