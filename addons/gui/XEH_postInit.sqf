#include "script_component.hpp"

[QACEGVAR(medical_gui,logListAppended), LINKFUNC(logListAppended)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical,ace_medicalMenuOpened), LINKFUNC(updateMedications)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical,ace_medicalMenuOpened), LINKFUNC(updateSyringes)] call CBA_fnc_addEventHandler;
