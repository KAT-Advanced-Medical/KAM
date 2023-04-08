#include "script_component.hpp"

[QGVAR(pulseoxLocal), LINKFUNC(treatmentAdvanced_pulseoximeterLocal)] call CBA_fnc_addEventHandler;
[QGVAR(chestSealLocal), LINKFUNC(treatmentAdvanced_chestSealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(handleBreathing), LINKFUNC(handleBreathing)] call CBA_fnc_addEventHandler;
[QGVAR(hemopneumothoraxLocal), LINKFUNC(treatmentAdvanced_hemopneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(tensionpneumothoraxLocal), LINKFUNC(treatmentAdvanced_tensionpneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cyanosisLocal), LINKFUNC(treatmentAdvanced_CyanosisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lowSpO2pp), LINKFUNC(lowSpO2pp)] call CBA_fnc_addEventHandler;

[QGVAR(playCough), {
    params ["_unit"];
	//_unit call FUNC(playCough);
	playSound3D [QPATHTOF_SOUND(sounds\pneumothoraxcough.ogg), _unit, false, getPosASL _unit, 5, 1, 15];
}] call CBA_fnc_addEventHandler;

[QACEGVAR(medical,woundReceived),LINKFUNC(handlePulmoHit)] call CBA_fnc_addEventHandler;
