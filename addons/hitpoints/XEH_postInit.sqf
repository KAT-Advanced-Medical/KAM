#include "script_component.hpp"

[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealMod)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListWounds), LINKFUNC(gui_updateInjuryListWounds)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;