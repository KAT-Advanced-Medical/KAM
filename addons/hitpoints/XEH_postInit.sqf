#include "script_component.hpp"

[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealMod)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListWounds), LINKFUNC(gui_updateInjuryListWounds)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QGVAR(reduceJoint), LINKFUNC(reduceJointLocal)] call CBA_fnc_addEventHandler;
[QGVAR(iceJoint), LINKFUNC(iceJointLocal)] call CBA_fnc_addEventHandler;
[QGVAR(wrapJoint), LINKFUNC(wrapJointLocal)] call CBA_fnc_addEventHandler;
[QGVAR(stabilizeJoint), LINKFUNC(stabilizeJointLocal)] call CBA_fnc_addEventHandler;
[QGVAR(bindPelvis), LINKFUNC(bindPelvisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeBandage), LINKFUNC(removeBandageLocal)] call CBA_fnc_addEventHandler;
[QGVAR(wrapWound), LINKFUNC(wrapWoundLocal)] call CBA_fnc_addEventHandler;
[QGVAR(burnDressing), LINKFUNC(burnDressingLocal)] call CBA_fnc_addEventHandler;


