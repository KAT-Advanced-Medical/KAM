#include "script_component.hpp"

[QGVAR(fractureSelect), LINKFUNC(fractureSelectLocal)] call CBA_fnc_addEventHandler;
[QGVAR(closedReduction), LINKFUNC(closedReductionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(openReduction), LINKFUNC(openReductionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(incision), LINKFUNC(incisionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(openReductionProgress), LINKFUNC(openReductionProgressLocal)] call CBA_fnc_addEventHandler;
[QGVAR(debridement), LINKFUNC(debridementLocal)] call CBA_fnc_addEventHandler;
[QGVAR(NPWT), LINKFUNC(npwtTreatmentLocal)] call CBA_fnc_addEventHandler;
